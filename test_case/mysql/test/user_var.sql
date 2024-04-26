drop table if exists t1,t2;
set @a := foo;
set @a := connection_id() + 3;
select @a - connection_id();

set @b := 1;
select @b;

-- Check using and setting variables with SELECT DISTINCT

CREATE TABLE t1 ( i int not null, v int not null,index (i));
insert into t1 values (1,1),(1,3),(2,1);
create table t2 (i int not null, unique (i));
insert into t2 select distinct i from t1;
select * from t2;
select distinct t2.i,@vv1:=if(sv1.i,1,0),@vv2:=if(sv2.i,1,0),@vv3:=if(sv3.i,1,0), @vv1+@vv2+@vv3 from t2 left join t1 as sv1 on sv1.i=t2.i and sv1.v=1 left join t1 as sv2 on sv2.i=t2.i and sv2.v=2 left join t1 as sv3 on sv3.i=t2.i and sv3.v=3;
select @vv1,i,v from t1 where i=@vv1;
drop table t1,t2;

-- Check types of variables
set @a=0,@b=0;
select @a:=10,   @b:=1,   @a > @b, @a < @b;
select @a:="10", @b:="1", @a > @b, @a < @b;
select @a:=10,   @b:=2,   @a > @b, @a < @b;
select @a:="10", @b:="2", @a > @b, @a < @b;

-- Fixed bug #1194
select @a:=1;
select @a, @a:=1;

create table t1 (id int, d double, c char(10));
insert into t1 values (1,2.0, "test");
select @c:=0;
update t1 SET id=(@c:=@c+1);
select @c;
select @c:=0;
update t1 set id=(@c:=@c+1);
select @c;
select @c:=0;
select @c:=@c+1;
select @d,(@d:=id),@d from t1;
select @e,(@e:=d),@e from t1;
select @f,(@f:=c),@f from t1;
set @g=1;
select @g,(@g:=c),@g from t1;
select @c, @d, @e, @f;
select @d:=id, @e:=id, @f:=id, @g:=@id from t1;
select @c, @d, @e, @f, @g;
drop table t1;

-- just for fun :)
select @a:=10, @b:=2, @a>@b, @a:="10", @b:="2", @a>@b, @a:=10, @b:=2, @a>@b, @a:="10", @b:="2", @a>@b;

--
-- bug#1739
-- Item_func_set_user_var sets update_query_id, Item_func_get_user_var checks it
--
create table t1 (i int not null);
insert t1 values (1),(2),(2),(3),(3),(3);
select @a:=0;
select @a, @a:=@a+count(*), count(*), @a from t1 group by i;
select @a:=0;
select @a+0, @a:=@a+0+count(*), count(*), @a+0 from t1 group by i;

set @a=0;
select @a,@a:="hello",@a,@a:=3,@a,@a:="hello again" from t1 group by i;
select @a,@a:="hello",@a,@a:=3,@a,@a:="hello again" from t1 group by i;
drop table t1;

--
-- Bug #2244: User variables did not copy collation and derivation
-- attributes from values they were initialized to.
--

set @a=_latin2'test';
select charset(@a),collation(@a),coercibility(@a);
select @a=_latin2'TEST';
select @a=_latin2'TEST' collate latin2_bin;

set @a=_latin2'test' collate latin2_general_ci;
select charset(@a),collation(@a),coercibility(@a);
select @a=_latin2'TEST';
select @a=_latin2'TEST' collate latin2_bin;

--
-- Check the same invoking Item_set_user_var
--
select charset(@a:=_latin2'test');
select collation(@a:=_latin2'test');
select coercibility(@a:=_latin2'test');
select collation(@a:=_latin2'test' collate latin2_bin);
select coercibility(@a:=_latin2'test' collate latin2_bin);
select (@a:=_latin2'test' collate latin2_bin) = _latin2'TEST';
select charset(@a),collation(@a),coercibility(@a);
select (@a:=_latin2'test' collate latin2_bin) = _latin2'TEST' collate latin2_general_ci;

--
-- Bug #6321 strange error:
--   string function FIELD(<uservariable content NULL>, ...)
--
set @var= NULL ;
select FIELD( @var,'1it','Hit') as my_column;

--
-- Bug#9425 A user variable doesn't always have implicit coercibility
--
select @v, coercibility(@v);
set @v1=null, @v2=1, @v3=1.1, @v4=now();
select coercibility(@v1),coercibility(@v2),coercibility(@v3),coercibility(@v4);

--
-- Bug #9286  SESSION/GLOBAL should be disallowed for user variables
--
--error 1064
set session @honk=99;

--
-- Bug #10724  @@local not preserved in column name of select
--
-- The value doesn't actually matter, we just care about the column name
--replace_column 1 --
select @@local.max_allowed_packet;
select @@session.max_allowed_packet;
select @@global.max_allowed_packet;
select @@max_allowed_packet;
select @@Max_Allowed_Packet;
select @@version;
select @@global.version;

-- Bug #6598: problem with cast(NULL as signed integer);
--

set @first_var= NULL;
create table t1 select @first_var;
drop table t1;
set @first_var= cast(NULL as signed integer);
create table t1 select @first_var;
drop table t1;
set @first_var= NULL;
create table t1 select @first_var;
drop table t1;
set @first_var= concat(NULL);
create table t1 select @first_var;
drop table t1;
set @first_var=1;
set @first_var= cast(NULL as CHAR);
create table t1 select @first_var;
drop table t1;

--
-- Bug #7498 User variable SET saves SIGNED BIGINT as UNSIGNED BIGINT
--

-- First part, set user var to large number and select it
set @a=18446744071710965857;
select @a;

-- Second part, set user var from large number in table
-- then select it
CREATE TABLE `bigfailure` (
  `afield` BIGINT UNSIGNED NOT NULL
);
INSERT INTO `bigfailure` VALUES (18446744071710965857);
SELECT * FROM bigfailure;
select * from (SELECT afield FROM bigfailure) as b;
select * from bigfailure where afield = (SELECT afield FROM bigfailure);
select * from bigfailure where afield = 18446744071710965857;
select * from bigfailure where afield = 18446744071710965856+1;

SET @a := (SELECT afield FROM bigfailure);
SELECT @a;
SET @a := (select afield from (SELECT afield FROM bigfailure) as b);
SELECT @a;
SET @a := (select * from bigfailure where afield = (SELECT afield FROM bigfailure));
SELECT @a;

drop table bigfailure;

--
-- Bug#16861: User defined variable can have a wrong value if a tmp table was
--            used.
--
create table t1(f1 int, f2 int);
insert into t1 values (1,2),(2,3),(3,1);
select @var:=f2 from t1 group by f1 order by f2 desc limit 1;
select @var;
create table t2 as select @var:=f2 from t1 group by f1 order by f2 desc limit 1;
select * from t2;
select @var;
drop table t1,t2;

--
-- Bug#19024 - SHOW COUNT(*) WARNINGS not return Errors 
--
--error 1064
insert into city 'blah';

--
-- Bug#28494: Grouping by Item_func_set_user_var produces incorrect result.
--
create table t1(f1 int, f2 varchar(2), f3 float, f4 decimal(2,1));
insert into t1 values 
  (1, "a", 1.5, 1.6), (1, "a", 1.5, 1.6), (2, "b", 2.5, 2.6),
  (3, "c", 3.5, 3.6), (4, "d", 4.5, 4.6), (1, "a", 1.5, 1.6),
  (3, "c", 3.5, 3.6), (1, "a", 1.5, 1.6);
select @a:=f1, count(f1) from t1 group by 1 order by 1 desc;
select @a:=f1, count(f1) from t1 group by 1 order by 1 asc;
select @a:=f2, count(f2) from t1 group by 1 order by 1 desc;
select @a:=f3, count(f3) from t1 group by 1 order by 1 desc;
select @a:=f4, count(f4) from t1 group by 1 order by 1 desc;
drop table t1;

--
-- Bug#32482: Crash for a query with ORDER BY a user variable.
--
create table t1 (f1 int);
insert into t1 values (2), (1);
select @i := f1 as j from t1 order by 1;
drop table t1;
create table t1(a int);
insert into t1 values(5),(4),(4),(3),(2),(2),(2),(1);
set @rownum := 0;
set @rank := 0;
set @prev_score := NULL;
select @rownum := @rownum + 1 as `row`,
 @rank := IF(@prev_score!=a, @rownum, @rank) as `rank`,
 @prev_score := a as score
from t1 order by score desc;
drop table t1;

--
-- Bug#26020: User-Defined Variables are not consistent with columns data types
--

create table t1(b bigint);
insert into t1 (b) values (10), (30), (10);
set @var := 0;
select if(b=@var, 999, b) , @var := b from t1  order by b;
drop table t1;

create temporary table t1 (id int);
insert into t1 values (2), (3), (3), (4);
set @lastid=-1;
select @lastid != id, @lastid, @lastid := id from t1;
drop table t1;

create temporary table t1 (id bigint);
insert into t1 values (2), (3), (3), (4);
set @lastid=-1;
select @lastid != id, @lastid, @lastid := id from t1;
drop table t1;

--
-- Bug#42009: SELECT into variable gives different results to direct SELECT
--
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES (0, 0), (2, 1), (2, 3), (1, 1), (30, 20);
SELECT a, b INTO @a, @b FROM t1 WHERE a=2 AND b=3 GROUP BY a, b;
SELECT @a, @b;
SELECT a, b FROM t1 WHERE a=2 AND b=3 GROUP BY a, b;
DROP TABLE t1;

--
-- Bug#47371: reference by same column name
--
CREATE TABLE t1 (f1 int(11) default NULL, f2 int(11) default NULL);
CREATE TABLE t2 (f1 int(11) default NULL, f2 int(11) default NULL, foo int(11));
CREATE TABLE t3 (f1 int(11) default NULL, f2 int(11) default NULL);

INSERT INTO t1 VALUES(10, 10);
INSERT INTO t1 VALUES(10, 10);
INSERT INTO t2 VALUES(10, 10, 10);
INSERT INTO t2 VALUES(10, 10, 10);
INSERT INTO t3 VALUES(10, 10);
INSERT INTO t3 VALUES(10, 10);

SELECT MIN(t2.f1),
@bar:= (SELECT MIN(t3.f2) FROM t3 WHERE t3.f2 > foo)
FROM t1,t2 WHERE t1.f1 = t2.f1 ORDER BY t2.f1;
DROP TABLE t1, t2, t3;

--
-- Bug#42188: crash and/or memory corruption with user variables in trigger
--

CREATE TABLE t1 (i INT);
CREATE TRIGGER t_after_insert AFTER INSERT ON t1 FOR EACH ROW SET @bug42188 = 10;
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;

--
-- Bug #55615: debug assertion after using variable in assignment and
-- referred to
-- Bug #55564: crash with user variables, assignments, joins...
--

CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (0),(0);
SELECT (@a:=(SELECT @a:=1 FROM t1 LIMIT 1)) AND COUNT(1) FROM t1 GROUP BY @a;
SELECT IF(
  @v:=LEAST((SELECT 1 FROM t1 t2 LEFT JOIN t1 ON (@v) GROUP BY t1.a), a),
  count(*), 1) 
FROM t1 GROUP BY a LIMIT 1;

DROP TABLE t1;

--
-- BUG#56138 "valgrind errors about overlapping memory when
-- double-assigning same variable"
--

select @v:=@v:=sum(1) from dual;

--
-- Bug #57187: more user variable fun with multiple assignments and
--             comparison in query
--

CREATE TABLE t1(a DECIMAL(31,21));
INSERT INTO t1 VALUES (0);

SELECT (@v:=a) <> (@v:=1) FROM t1;

DROP TABLE t1;

--
-- Bug#50511: Sometimes wrong handling of user variables containing NULL.
--

--disable_warnings
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(f1 INT AUTO_INCREMENT, PRIMARY KEY(f1));

INSERT INTO t1 SET f1 = NULL ;

SET @aux = NULL ;
INSERT INTO t1 SET f1 = @aux ;

SET @aux1 = 0.123E-1;
SET @aux1 = NULL;
INSERT INTO t1 SET f1 = @aux1 ;

SELECT * FROM t1;

DROP TABLE t1;

CREATE TABLE t1(f1 VARCHAR(257) , f2 INT, PRIMARY KEY(f2));
CREATE TRIGGER trg1 BEFORE INSERT ON t1 FOR EACH ROW SET @aux = 1;

SET @aux = 1;
SET @aux = NULL;
INSERT INTO test.t1 (f1, f2) VALUES (1, 1), (@aux, 2);

SET @aux = 'text';
SET @aux = NULL;
INSERT INTO t1(f1, f2) VALUES (1, 3), (@aux, 4);

SELECT f1, f2 FROM t1 ORDER BY f2;

DROP TRIGGER trg1;
DROP TABLE t1;

SET @bug12408412=1;
SELECT GROUP_CONCAT(@bug12408412 ORDER BY 1) INTO @bug12408412;

--
-- Bug #11764372 57197: EVEN MORE USER VARIABLE CRASHING FUN
--

CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (1), (2);
SELECT DISTINCT @a:=MIN(t1.a) FROM t1, t1 AS t2
GROUP BY @b:=(SELECT COUNT(*) > t2.a);
DROP TABLE t1;

--
-- Bug #11764371 57196: MORE FUN WITH ASSERTION: !TABLE->FILE ||
-- TABLE->FILE->INITED == HANDLER::
--

CREATE TABLE t1(a INT) ENGINE=InnoDB;
INSERT INTO t1 VALUES (0);
SELECT DISTINCT POW(COUNT(*), @a:=(SELECT 1 FROM t1 LEFT JOIN t1 AS t2 ON @a))
AS b FROM t1 GROUP BY a;
SELECT @a;
DROP TABLE t1;
CREATE TABLE t1(f1 INT, f2 INT);
INSERT INTO t1 VALUES (1,2),(2,3),(3,1);
CREATE TABLE t2(a INT);
INSERT INTO t2 VALUES (1);
SET @var=NULL;
SELECT @var:=(SELECT f2 FROM t2 WHERE @var) FROM t1 GROUP BY f1 ORDER BY f2 DESC
LIMIT 1;
SELECT @var;
DROP TABLE t1, t2;

--
-- Bug#14058892: Extra rows returned when variable is used in subquery in
--               ON clause of RIGHT JOIN
--
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);

CREATE TABLE t2(a INT);
INSERT INTO t2 VALUES (1), (3), (5), (7), (9);

CREATE TABLE t3(a INT);
INSERT INTO t3 VALUES (1), (4), (7), (10);

SET @var1 = 6;

let $query=
SELECT t1.a, t2.a, t3.a, (@var1:= @var1+0) AS var
FROM t1
     LEFT JOIN t2 ON t1.a=t2.a AND t2.a < @var1
     LEFT JOIN t3 ON t1.a=t3.a AND t3.a < @var1;

DROP TABLE t1, t2, t3;

--
-- Starting with MySQL 5.7:
-- Enforcing max length on variable names
--

-- Length 64 is ok.
set    @X234567890123456789012345678901234567890123456789012345678901234 = 12;
select @X234567890123456789012345678901234567890123456789012345678901234;

-- Length 65 is illegal
-- error ER_ILLEGAL_USER_VAR
set    @X2345678901234567890123456789012345678901234567890123456789012345 = 12;

-- Length 0 is illegal
-- error ER_ILLEGAL_USER_VAR
set @``= "illegal";

-- trailing spaces are illegal
-- error ER_ILLEGAL_USER_VAR
set @`endswithspace `= "illegal";

-- No error reported, illegal identifier treated as non existent
select @X2345678901234567890123456789012345678901234567890123456789012345;
select @``;
select @`endswithspace `;

--
--Bug#18486509 ASSERTION FAILED: TABLE->KEY_READ == 0 IN CLOSE_THREAD_TABLE
--
CREATE TABLE t1(a INT,KEY(a))ENGINE=INNODB;
SELECT 1 NOT IN (SELECT 1 FROM t1 as t1 GROUP BY 1 LIKE (SELECT 1 FROM t1 as t2)) AS col;
SELECT 1 NOT IN (SELECT 1 FROM t1 as t1 ORDER BY 1 LIKE (SELECT 1 FROM t1 as t2)) AS col;
SET @c =(SELECT 1 NOT IN (SELECT 1 FROM t1 as t1 GROUP BY 1 LIKE (SELECT 1 FROM t1 as t2)) AS col);
SET @d =(SELECT 1 NOT IN (SELECT 1 FROM t1 as t1 ORDER BY 1 LIKE (SELECT 1 FROM t1 as t2)) AS col);
DROP TABLE t1;

CREATE TABLE t1(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES (1,1), (1,2), (2,1);



let $query1=SELECT a FROM t1 WHERE a = @x;
let $query2=SELECT a FROM t1 WHERE a = @x AND (@x:= @x);
let $query3=SELECT a FROM t1 WHERE a = @x INTO @x;

SET @x= 1;

SET @x= 2;

DROP TABLE t1;
CREATE TABLE t1(a VARCHAR(10) CHARSET latin1, b VARCHAR(20) CHARSET utf16);
INSERT INTO t1 VALUES ('a', 'abcd');
SELECT (@x:=b) FROM t1;
SELECT * FROM t1 WHERE b = (SELECT (@x:=1) FROM t1) OR a = @x;
SELECT (@x:=a) FROM t1;
SELECT * FROM t1 WHERE a = (SELECT (@x:=_utf16 0x1023) FROM t1) OR b = @x;
DROP TABLE t1;
SET @c := FROM_UNIXTIME(1537002029);

CREATE TABLE t1 (pk INTEGER PRIMARY KEY, d DATE);
INSERT INTO t1 VALUES(1, '2017-01-01');
SELECT d < 00010101000000.0 AS a FROM t1;
set @tsn= 00010101000000.0;
SELECT d < @tsn AS a FROM t1;
DROP TABLE t1;

-- Test prepared statements with signed and unsigned integer user variables

CREATE TABLE numbers
(pk INTEGER PRIMARY KEY,
 ui BIGINT UNSIGNED,
 si BIGINT
);

INSERT INTO numbers VALUES
(0, 0, -9223372036854775808), (1, 18446744073709551615, 9223372036854775807);

SET @ui_min = CAST(0 AS UNSIGNED);
SET @ui_max = CAST(18446744073709551615 AS UNSIGNED);
SET @si_min = CAST(-9223372036854775808 AS SIGNED);
SET @si_max = CAST(9223372036854775807 AS SIGNED);

DROP TABLE numbers;

-- Test prepared statements with user variables with varying collations

CREATE TABLE strings
(pk INTEGER PRIMARY KEY,
 vc_ascii VARCHAR(20) COLLATE ascii_general_ci,
 vc_latin1 VARCHAR(20) COLLATE latin1_general_ci,
 vc_utf8mb4 VARCHAR(20) COLLATE utf8mb4_0900_ai_ci,
 vc_utf16 VARCHAR(20) COLLATE utf16_general_ci,
 vc_utf32 VARCHAR(20) COLLATE utf32_general_ci
);

SET @str_ascii=_ASCII'abcxyz';
SET @str_utf8mb4=CONVERT(x'616263C3A6C3B8C3A578797A' USING utf8mb4);
SET @str_latin1=CONVERT(@str_utf8mb4 USING latin1);
SET @str_utf16=CONVERT(@str_utf8mb4 USING utf16);
SET @str_utf32=CONVERT(@str_utf8mb4 USING utf32);

INSERT INTO strings VALUES
(0, @str_ascii, @str_ascii, @str_ascii, @str_ascii, @str_ascii),
(1, @str_ascii, @str_utf8mb4, @str_utf8mb4, @str_utf8mb4, @str_utf8mb4);

DROP TABLE strings;

set @maxint=18446744073709551615;

-- Tests user_var_entry::val_real/decimal()
-- was wrong -1
SELECT @maxint + 0e0;
SELECT 18446744073709551615 + 0e0;
SELECT @maxint + 0.0;
SELECT 18446744073709551615 + 0.0;

-- Tests Item_param::val_real/decimal/int/str()
PREPARE s FROM 'SELECT 0e0 + ?';

do null not between 1 and @undefined_var;

SET @f = _utf32 'a';
CREATE TABLE t1 (a TIMESTAMP);
INSERT INTO t1 VALUES ('2018-05-12 07:43:04'), ('2018-05-12 07:43:04');
SELECT 1 FROM t1 WHERE @f<>'3761-03-28' XOR (@f:='5570-12-30') > a;
DROP TABLE t1;

CREATE TABLE t(a BIT(4), b INTEGER);
SELECT AVG((@e:= a)) FROM t;
SELECT AVG((@e:= a)) FROM t GROUP BY b;
DROP TABLE t;

CREATE TABLE t1 (a TINYINT);
INSERT INTO t1 VALUES (1);
SELECT (@a:=a) FROM t1 GROUP BY 1;
DROP TABLE t1;