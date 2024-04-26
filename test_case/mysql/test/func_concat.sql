--

--disable_warnings
DROP TABLE IF EXISTS t1;
DROP PROCEDURE IF EXISTS p1;

CREATE TABLE t1 ( number INT NOT NULL, alpha CHAR(6) NOT NULL );
INSERT INTO t1 VALUES (1413006,'idlfmv'),
(1413065,'smpsfz'),(1413127,'sljrhx'),(1413304,'qerfnd');

SELECT number, alpha, CONCAT_WS('<---->',number,alpha) AS new
FROM t1 GROUP BY number;

SELECT CONCAT_WS('<---->',number,alpha) AS new
FROM t1 GROUP BY new LIMIT 1;

SELECT number, alpha, CONCAT_WS('<->',number,alpha) AS new
FROM t1 GROUP BY new LIMIT 1;

SELECT number, alpha, CONCAT_WS('-',number,alpha,alpha,alpha,alpha,alpha,alpha,alpha) AS new
FROM t1 GROUP BY new LIMIT 1;

SELECT number, alpha, CONCAT_WS('<------------------>',number,alpha) AS new
FROM t1 GROUP BY new LIMIT 1;
drop table t1;

--
-- Bug #5540: a problem with double type
--

create table t1 (a char(4), b double, c date, d tinyint(4));
insert into t1 values ('AAAA', 105, '2003-03-01', 1);
select * from t1 where concat(A,C,B,D) = 'AAAA2003-03-011051';
drop table t1;

-- BUG#6825 
select 'a' union select concat('a', -4);
select 'a' union select concat('a', -4.5);

select 'a' union select concat('a', -(4 + 1));
select 'a' union select concat('a', 4 - 5);

select 'a' union select concat('a', -'3');
select 'a' union select concat('a', -concat('3',4));

select 'a' union select concat('a', -0);
select 'a' union select concat('a', -0.0);
select 'a' union select concat('a', -0.0000);

--
-- Bug#16716: subselect in concat() may lead to a wrong result
--
select concat((select x from (select 'a' as x) as t1 ),
  (select y from (select 'b' as y) as t2 )) from (select 1 union select 2 )
  as t3;

-- End of 4.1 tests

--
-- Bug#15962: CONCAT() in UNION may lead to a data trucation.
--
create table t1(f1 varchar(6)) charset=utf8mb3;
insert into t1 values ("123456");
select concat(f1, 2) a from t1 union select 'x' a from t1;
drop table t1;

--
-- Bug #36488: regexp returns false matches, concatenating with previous rows
--
CREATE TABLE t1 (c1 varchar(100), c2 varchar(100));
INSERT INTO t1 VALUES ('',''), ('','First'), ('Random','Random');
SELECT * FROM t1 WHERE CONCAT(c1,' ',c2) REGEXP 'First.*';
DROP TABLE t1;
CREATE TABLE t1 (
  a VARCHAR(100) NOT NULL DEFAULT '0',
  b VARCHAR(2) NOT NULL DEFAULT '',
  c VARCHAR(2) NOT NULL DEFAULT '',
  d TEXT NOT NULL,
  PRIMARY KEY (a, b, c),
  KEY (a)
) DEFAULT CHARSET=utf8mb3;

INSERT INTO t1 VALUES ('gui_A', 'a', 'b', 'str1'),
  ('gui_AB', 'a', 'b', 'str2'), ('gui_ABC', 'a', 'b', 'str3');

CREATE TABLE t2 (
  a VARCHAR(100) NOT NULL DEFAULT '',
  PRIMARY KEY (a)
) DEFAULT CHARSET=latin1;

INSERT INTO t2 VALUES ('A'), ('AB'), ('ABC');

SELECT CONCAT('gui_', t2.a), t1.d FROM t2 
  LEFT JOIN t1 ON t1.a = CONCAT('gui_', t2.a) AND t1.b = 'a' AND t1.c = 'b';

DROP TABLE t1, t2;

CREATE PROCEDURE p1(a varchar(255), b int, c int)
  SET @query = CONCAT_WS(",", a, b, c);
SELECT @query;

DROP PROCEDURE p1;
CREATE PROCEDURE p1()
BEGIN
  DECLARE v1 DOUBLE(10,3);
  SET v1= 100;
  SET @s = CONCAT('--#######################################', 40 , v1);
  SELECT @s;

DROP PROCEDURE p1;
