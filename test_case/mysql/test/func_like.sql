--

--disable_warnings
drop table if exists t1;

create table t1 (a varchar(10), key(a)) charset utf8mb4;
insert into t1 values ("a"),("abc"),("abcd"),("hello"),("test");
select * from t1 where a like "abc%";
select * from t1 where a like concat("abc","%");
select * from t1 where a like "ABC%";
select * from t1 where a like "test%";
select * from t1 where a like "te_t";

--
-- The following will test non-anchored matches
--
select * from t1 where a like "%a%";
select * from t1 where a like "%abcd%";
select * from t1 where a like "%abc\d%";

drop table t1;

create table t1 (a varchar(10), key(a));

--
-- Bug #2231
--
insert into t1 values ('a'), ('a\\b');
select * from t1 where a like 'a\\%' escape '--';
select * from t1 where a like 'a\\%' escape '--' and a like 'a\\\\b';

--
-- Bug #4200: Prepared statement parameter as argument to ESCAPE
--
prepare stmt1 from 'select * from t1 where a like \'a\\%\' escape ?';
set @esc='--';

drop table t1;

--
-- Bug #2885: like and datetime
--

create table t1 (a datetime);
insert into t1 values ('2004-03-11 12:00:21');
select * from t1 where a like '2004-03-11 12:00:21';
drop table t1;

--
-- Test like with non-default character set
--

CREATE TABLE t1 (a VARCHAR(10) CHARACTER SET koi8r);

INSERT INTO t1 VALUES ('фыва'),('Фыва'),('фЫва'),('фыВа'),('фывА'),('ФЫВА');

INSERT INTO t1 VALUES ('фывапролдж'),('Фывапролдж'),('фЫвапролдж'),('фыВапролдж');
INSERT INTO t1 VALUES ('фывАпролдж'),('фываПролдж'),('фывапРолдж'),('фывапрОлдж');
INSERT INTO t1 VALUES ('фывапроЛдж'),('фывапролДж'),('фывапролдЖ'),('ФЫВАПРОЛДЖ');

SELECT * FROM t1 WHERE a LIKE '%фЫва%';
SELECT * FROM t1 WHERE a LIKE '%фЫв%';
SELECT * FROM t1 WHERE a LIKE 'фЫва%';

DROP TABLE t1;

-- Bug #2547 Strange "like" behaviour in tables with default charset=cp1250
-- Test like with non-default character set using TurboBM
--
CREATE TABLE t1 (a varchar(250) NOT NULL) DEFAULT CHARACTER SET=cp1250;
INSERT INTO t1 VALUES
('Techni Tapes Sp. z o.o.'),
('Pojazdy Szynowe PESA Bydgoszcz SA Holding'),
('AKAPESTER 1 P.P.H.U.'),
('Pojazdy Szynowe PESA Bydgoszcz S A Holding'),
('PPUH PESKA-I Maria Struniarska');

select * from t1 where a like '%PESA%';
select * from t1 where a like '%PESA %';
select * from t1 where a like '%PES%';
select * from t1 where a like '%PESKA%';
select * from t1 where a like '%ESKA%';
DROP TABLE t1;

--
-- LIKE crashed for binary collations in some cases
--
select _cp866'aaaaaaaaa' like _cp866'%aaaa%' collate cp866_bin;

--
-- Check multi-byte escape character
--
select 'andre%' like 'andreй%' escape 'й';

-- Check multi-byte escape character with charset conversion:
-- For "a LIKE b ESCAPE c" expressions,
-- escape character is converted into the operation character set,
-- which is result of aggregation  of character sets of "a" and "b".
-- "c" itself doesn't take part in aggregation, because its collation
-- doesn't matter, escape character is always compared binary.
-- In the example below, escape character is converted from utf8mb4 into cp1251:
--
select _cp1251 'andre%' like convert('andreй%' using cp1251)  escape 'й';
CREATE TABLE t1(a SET('a') NOT NULL, UNIQUE KEY(a));
CREATE TABLE t2(b INT PRIMARY KEY);
INSERT IGNORE INTO t1 VALUES ();
INSERT INTO t2 VALUES (1), (2), (3);
SELECT 1 FROM t2 JOIN t1 ON 1 LIKE a GROUP BY a;
DROP TABLE t1, t2;
SELECT '' LIKE '1' ESCAPE COUNT(1);

select 0x0000000001020003F03F40408484040ADDE40 like 0x256F3B38312A7725;
select 0x003c8793403032 like '%-112%';
select 0x903f645a8c507dd79178 like '%-128%';
select 0xac14aa84f000d276d66ed9 like '%-107%';
select 0xf0be117400d02a20b8e049da3e74 like '%-123%';
select 0x961838f6fc3c7f9ec17b5d900410d8aa like '%-113%';
select 0x6a8473fc1c64ce4f2684c05a400c5e7ca4a01a like '%emailin%';
select 0x00b25278956e0044683dfc180cd886aeff2f5bc3fc18 like '%-122%';
select 0xbc24421ce6194ab5c260e80af647ae58fdbfca18a19dc8411424 like '%-106%';

CREATE TABLE t1(x CHAR(1)) ENGINE=InnoDB;

-- The escape string is null and defaults to '\'.
SELECT ('a%b' LIKE 'a\%b' ESCAPE (SELECT x FROM t1));
SELECT ('a%b' LIKE 'ax%b' ESCAPE (SELECT x FROM t1));

-- The escape string is 'x'.
INSERT INTO t1 VALUES ('x');
SELECT ('a%b' LIKE 'a\%b' ESCAPE (SELECT x FROM t1));
SELECT ('a%b' LIKE 'ax%b' ESCAPE (SELECT x FROM t1));

-- The escape string cannot have more than one character.
--error ER_WRONG_ARGUMENTS
SELECT ('a%b' LIKE 'ax%b' ESCAPE (SELECT 'xy' FROM t1));

-- The subquery cannot return more than one row.
INSERT INTO t1 VALUES ('y');
SELECT ('a%b' LIKE 'ax%b' ESCAPE (SELECT x FROM t1));
DELETE FROM t1 WHERE x = 'y';

-- The escape clause must have exactly one column.
--error ER_OPERAND_COLUMNS
SELECT ('a%b' LIKE 'ax%b' ESCAPE (SELECT x, x FROM t1));
SELECT ('a%b' LIKE 'ax%b' ESCAPE ('x', 'y'));

-- The escape clause needs to be constant during execution.
--error ER_WRONG_ARGUMENTS
SELECT ('a%b' LIKE 'ax%b' ESCAPE x) FROM t1;

-- Also test on an indexed column to exercise the range optimizer.
-- (The range optimizer will give up because it does not know the
-- value of the escape character, so the query execution plan will
-- not actually use range optimization.)
CREATE TABLE t2(x int, y varchar(100)) ENGINE=InnoDB;
CREATE INDEX idx ON t2(y);
INSERT INTO t2 VALUES (1, 'abcd'), (2, 'ab%cde');
let $query=
SELECT * FROM t2 WHERE y LIKE 'abc%%' ESCAPE (SELECT 'c' FROM t1) ORDER BY y;

DROP TABLE t1, t2;

CREATE TABLE t1(a INTEGER) engine=innodb;
INSERT INTO t1 VALUES(1);
SELECT 1 FROM t1 HAVING (SELECT 1 FROM t1) LIKE EXP(NOW());
DROP TABLE t1;
CREATE TABLE t1(wildstr VARCHAR(10), str VARCHAR(10), like_result INTEGER)
COLLATE utf8mb4_0900_ai_ci;
INSERT INTO t1 VALUES('abc', 'abc', 1), ('AbC', 'aBc', 1), ('_bc', 'abc', 1),
('a_c', 'abc', 1), ('ab_', 'abc', 1), ('%c', 'abc', 1), ('a%c', 'abc', 1),
('a%', 'abc', 1), ('a%d_f', 'abcdef', 1), ('a%d%g', 'abcdefg', 1),
('a_c_e', 'abcde', 1), ('a%%de', 'abcde', 1), ('a__de', 'abcde', 1),
(_utf16 0x65700025636E005F5E93, _utf16 0x65706C49636E5B575E93, 1),
('a\\', 'a\\', 1);
SELECT wildstr, str, like_result FROM t1 WHERE (str LIKE wildstr) <>
like_result;
DROP TABLE t1;
SELECT 'aa' LIKE CONVERT('%a' USING big5);
SELECT 'aa' LIKE CONVERT('%a' USING utf8mb4);
SELECT 'aa' LIKE CONVERT('%a' USING gb18030);
SELECT 'aa' LIKE CONVERT('%a' USING binary);
SELECT 'aa' LIKE CONVERT('%a' USING latin1);
SET NAMES gb2312;
SELECT 'aa' LIKE '%a' COLLATE gb2312_bin;
SET NAMES DEFAULT;
SELECT 'aa' LIKE CONVERT('%a' USING utf8mb3);
SET NAMES big5;
select 1 where 'b%a' like '%%a' escape '%';
select 1 where 'b_a' like '__a' escape '_';
select 1 where 'b%a' like '--%a' escape '#';
select 1 where 'b_a' like '--_a' escape '#';
SET NAMES utf8mb4;
select 1 where 'b%a' like '%%a' escape '%';
select 1 where 'b_a' like '__a' escape '_';
select 1 where 'b%a' like '--%a' escape '#';
select 1 where 'b_a' like '--_a' escape '#';
SET NAMES gb18030;
select 1 where 'b%a' like '%%a' escape '%';
select 1 where 'b_a' like '__a' escape '_';
select 1 where 'b%a' like '--%a' escape '#';
select 1 where 'b_a' like '--_a' escape '#';
SET NAMES binary;
select 1 where 'b%a' like '%%a' escape '%';
select 1 where 'b_a' like '__a' escape '_';
select 1 where 'b%a' like '--%a' escape '#';
select 1 where 'b_a' like '--_a' escape '#';
SET NAMES latin1;
select 1 where 'b%a' like '%%a' escape '%';
select 1 where 'b_a' like '__a' escape '_';
select 1 where 'b%a' like '--%a' escape '#';
select 1 where 'b_a' like '--_a' escape '#';
SET NAMES gb2312;
select 1 where 'b%a' like '%%a' escape '%';
select 1 where 'b_a' like '__a' escape '_';
select 1 where 'b%a' like '--%a' escape '#';
select 1 where 'b_a' like '--_a' escape '#';
SET NAMES utf8mb3;
select 1 where 'b%a' like '%%a' escape '%';
select 1 where 'b_a' like '__a' escape '_';
select 1 where 'b%a' like '--%a' escape '#';
select 1 where 'b_a' like '--_a' escape '#';

SET NAMES default;
SELECT 'a' LIKE '%' ESCAPE CAST('' AS JSON);
CREATE TABLE t1 (c1 INT);
INSERT INTO t1 VALUES (42);
DELETE FROM t1 WHERE
( EXISTS
   (SELECT * WHERE '520:33:32.77' < (c1 - INTERVAL(1) MONTH))
) LIKE (c1);
DROP TABLE t1;
CREATE TABLE t(col1 DATE);
INSERT INTO t(col1) VALUES('2019-06-13'), ('2019-07-13');
SELECT * FROM t WHERE col1 LIKE '2019%';
SELECT * FROM t WHERE col1 LIKE '2019-06-1%';
DROP TABLE t;

create table t1(a int);
insert into t1 values(0);

set @pattern="%1%";

-- "0" doesn't match the pattern
select 1 from t1 where a like @pattern;

drop table t1;

-- Used to miss the ESCAPE clause.
EXPLAIN SELECT 'abba' LIKE 'abba' ESCAPE 'b';

CREATE TABLE t(x VARCHAR(10),
               gc INTEGER GENERATED ALWAYS AS (x LIKE 'abba' ESCAPE 'b'));
INSERT INTO t(x) VALUES ('abba'), ('aba'), ('abbbba');

-- Used to miss the ESCAPE clause.
SHOW CREATE TABLE t;

-- Used to return the wrong row.
SELECT x FROM t WHERE gc <> 0;

CREATE VIEW v AS SELECT x, 'abba' LIKE x ESCAPE 'b' AS y FROM t;

-- Used to miss the ESCAPE clause.
SHOW CREATE VIEW v;

-- Used to return the wrong row.
SELECT x FROM v WHERE y <> 0;

DROP VIEW v;
DROP TABLE t;
SELECT _latin1'abc' LIKE _latin1'a\\bc' ESCAPE _latin1'' AS col1,
       _utf8mb4'abc' LIKE _utf8mb4'a\\bc' ESCAPE _utf8mb4'' AS col2,
       _latin1'abc' LIKE _latin1'a\\bc' ESCAPE _ascii'' AS col3;

SET sql_mode = CONCAT(@@sql_mode, ',NO_BACKSLASH_ESCAPES');
SELECT _latin1'a\bc' LIKE _latin1'a\%' AS col1,
       _utf8mb4'a\bc' LIKE _utf8mb4'a\%' AS col2;
SET sql_mode = DEFAULT;

CREATE TABLE t1(c1 VARCHAR(20) NOT NULL);
INSERT INTO t1 VALUES ('100'), ('abc\\d');
SELECT * FROM t1 WHERE c1 LIKE c1;
SELECT c1 LIKE c1 AS l FROM t1;
SELECT * FROM t1 WHERE c1 LIKE c1 ESCAPE '1';
SELECT c1 LIKE c1 ESCAPE '1' AS l FROM t1;
SELECT * FROM t1 WHERE c1 LIKE c1 ESCAPE 1;
SELECT c1 LIKE c1 ESCAPE 1 AS l FROM t1;
DROP TABLE t1;
