select @a - connection_id();
select @b;
CREATE TABLE t1 ( i int not null, v int not null,index (i));
insert into t1 values (1,1),(1,3),(2,1);
create table t2 (i int not null, unique (i));
insert into t2 select distinct i from t1;
select * from t2;
select distinct t2.i,@vv1:=if(sv1.i,1,0),@vv2:=if(sv2.i,1,0),@vv3:=if(sv3.i,1,0), @vv1+@vv2+@vv3 from t2 left join t1 as sv1 on sv1.i=t2.i and sv1.v=1 left join t1 as sv2 on sv2.i=t2.i and sv2.v=2 left join t1 as sv3 on sv3.i=t2.i and sv3.v=3;
select @vv1,i,v from t1 where i=@vv1;
drop table t1,t2;
select @a:=10,   @b:=1,   @a > @b, @a < @b;
select @a:="10", @b:="1", @a > @b, @a < @b;
select @a:=10,   @b:=2,   @a > @b, @a < @b;
select @a:="10", @b:="2", @a > @b, @a < @b;
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
select @g,(@g:=c),@g from t1;
select @c, @d, @e, @f;
select @d:=id, @e:=id, @f:=id, @g:=@id from t1;
select @c, @d, @e, @f, @g;
drop table t1;
select @a:=10, @b:=2, @a>@b, @a:="10", @b:="2", @a>@b, @a:=10, @b:=2, @a>@b, @a:="10", @b:="2", @a>@b;
create table t1 (i int not null);
insert t1 values (1),(2),(2),(3),(3),(3);
select @a:=0;
select @a, @a:=@a+count(*), count(*), @a from t1 group by i;
select @a:=0;
select @a+0, @a:=@a+0+count(*), count(*), @a+0 from t1 group by i;
select @a,@a:="hello",@a,@a:=3,@a,@a:="hello again" from t1 group by i;
select @a,@a:="hello",@a,@a:=3,@a,@a:="hello again" from t1 group by i;
drop table t1;
select charset(@a),collation(@a),coercibility(@a);
select @a=_latin2'TEST';
select charset(@a),collation(@a),coercibility(@a);
select @a=_latin2'TEST';
select charset(@a:=_latin2'test');
select collation(@a:=_latin2'test');
select coercibility(@a:=_latin2'test');
select collation(@a:=_latin2'test' collate latin2_bin);
select coercibility(@a:=_latin2'test' collate latin2_bin);
select (@a:=_latin2'test' collate latin2_bin) = _latin2'TEST';
select charset(@a),collation(@a),coercibility(@a);
select (@a:=_latin2'test' collate latin2_bin) = _latin2'TEST' collate latin2_general_ci;
select FIELD( @var,'1it','Hit') as my_column;
select @v, coercibility(@v);
select coercibility(@v1),coercibility(@v2),coercibility(@v3),coercibility(@v4);
select @@local.max_allowed_packet;
select @@session.max_allowed_packet;
select @@global.max_allowed_packet;
select @@max_allowed_packet;
select @@Max_Allowed_Packet;
select @@version;
select @@global.version;
create table t1 select @first_var;
drop table t1;
create table t1 select @first_var;
drop table t1;
create table t1 select @first_var;
drop table t1;
create table t1 select @first_var;
drop table t1;
create table t1 select @first_var;
drop table t1;
select @a;
CREATE TABLE `bigfailure` (
  `afield` BIGINT UNSIGNED NOT NULL
);
INSERT INTO `bigfailure` VALUES (18446744071710965857);
SELECT * FROM bigfailure;
select * from (SELECT afield FROM bigfailure) as b;
select * from bigfailure where afield = (SELECT afield FROM bigfailure);
select * from bigfailure where afield = 18446744071710965857;
select * from bigfailure where afield = 18446744071710965856+1;
SELECT @a;
SELECT @a;
SELECT @a;
drop table bigfailure;
create table t1(f1 int, f2 int);
insert into t1 values (1,2),(2,3),(3,1);
select @var;
select @var;
select @a:=f1, count(f1) from t1 group by 1 order by 1 desc;
select @a:=f1, count(f1) from t1 group by 1 order by 1 asc;
select @a:=f2, count(f2) from t1 group by 1 order by 1 desc;
drop table t1;
create table t1 (f1 int);
insert into t1 values (2), (1);
select @i := f1 as j from t1 order by 1;
drop table t1;
create table t1(a int);
insert into t1 values(5),(4),(4),(3),(2),(2),(2),(1);
select @rownum := @rownum + 1 as `row`,
 @rank := IF(@prev_score!=a, @rownum, @rank) as `rank`,
 @prev_score := a as score
from t1 order by score desc;
drop table t1;
create table t1(b bigint);
insert into t1 (b) values (10), (30), (10);
select if(b=@var, 999, b) , @var := b from t1  order by b;
drop table t1;
create temporary table t1 (id int);
insert into t1 values (2), (3), (3), (4);
select @lastid != id, @lastid, @lastid := id from t1;
drop table t1;
create temporary table t1 (id bigint);
insert into t1 values (2), (3), (3), (4);
select @lastid != id, @lastid, @lastid := id from t1;
drop table t1;
CREATE TABLE t1(a INT, b INT);
INSERT INTO t1 VALUES (0, 0), (2, 1), (2, 3), (1, 1), (30, 20);
SELECT a, b INTO @a, @b FROM t1 WHERE a=2 AND b=3 GROUP BY a, b;
SELECT @a, @b;
SELECT a, b FROM t1 WHERE a=2 AND b=3 GROUP BY a, b;
DROP TABLE t1;
CREATE TABLE t1 (f1 int(11) default NULL, f2 int(11) default NULL);
CREATE TABLE t2 (f1 int(11) default NULL, f2 int(11) default NULL, foo int(11));
CREATE TABLE t3 (f1 int(11) default NULL, f2 int(11) default NULL);
INSERT INTO t1 VALUES(10, 10);
INSERT INTO t1 VALUES(10, 10);
INSERT INTO t2 VALUES(10, 10, 10);
INSERT INTO t2 VALUES(10, 10, 10);
INSERT INTO t3 VALUES(10, 10);
INSERT INTO t3 VALUES(10, 10);
DROP TABLE t1, t2, t3;
CREATE TABLE t1 (i INT);
INSERT INTO t1 VALUES (1);
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (0),(0);
SELECT (@a:=(SELECT @a:=1 FROM t1 LIMIT 1)) AND COUNT(1) FROM t1 GROUP BY @a;
SELECT IF(
  @v:=LEAST((SELECT 1 FROM t1 t2 LEFT JOIN t1 ON (@v) GROUP BY t1.a), a),
  count(*), 1) 
FROM t1 GROUP BY a LIMIT 1;
DROP TABLE t1;
select @v:=@v:=sum(1) from dual;
CREATE TABLE t1(a DECIMAL(31,21));
INSERT INTO t1 VALUES (0);
SELECT (@v:=a) <> (@v:=1) FROM t1;
DROP TABLE t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(f1 INT AUTO_INCREMENT, PRIMARY KEY(f1));
INSERT INTO t1 SET f1 = NULL;
INSERT INTO t1 SET f1 = @aux;
INSERT INTO t1 SET f1 = @aux1;
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(f1 VARCHAR(257) , f2 INT, PRIMARY KEY(f2));
INSERT INTO t1(f1, f2) VALUES (1, 3), (@aux, 4);
SELECT f1, f2 FROM t1 ORDER BY f2;
DROP TABLE t1;
SELECT GROUP_CONCAT(@bug12408412 ORDER BY 1) INTO @bug12408412;
CREATE TABLE t1(a int);
INSERT INTO t1 VALUES (1), (2);
SELECT DISTINCT @a:=MIN(t1.a) FROM t1, t1 AS t2
GROUP BY @b:=(SELECT COUNT(*) > t2.a);
DROP TABLE t1;
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
SELECT @var;
DROP TABLE t1, t2;
CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7), (8), (9), (10);
CREATE TABLE t2(a INT);
INSERT INTO t2 VALUES (1), (3), (5), (7), (9);
CREATE TABLE t3(a INT);
INSERT INTO t3 VALUES (1), (4), (7), (10);
SELECT t1.a, t2.a, t3.a, (@var1:= @var1+0) AS var
FROM t1
     LEFT JOIN t2 ON t1.a=t2.a AND t2.a < @var1
     LEFT JOIN t3 ON t1.a=t3.a AND t3.a < @var1;
DROP TABLE t1, t2, t3;
select @X234567890123456789012345678901234567890123456789012345678901234;
select @X2345678901234567890123456789012345678901234567890123456789012345;
select @``;
select @`endswithspace `;
CREATE TABLE t1(a INT,KEY(a))ENGINE=INNODB;
SELECT 1 NOT IN (SELECT 1 FROM t1 as t1 GROUP BY 1 LIKE (SELECT 1 FROM t1 as t2)) AS col;
SELECT 1 NOT IN (SELECT 1 FROM t1 as t1 ORDER BY 1 LIKE (SELECT 1 FROM t1 as t2)) AS col;
DROP TABLE t1;
CREATE TABLE t1(a INTEGER, b INTEGER);
INSERT INTO t1 VALUES (1,1), (1,2), (2,1);
DROP TABLE t1;
CREATE TABLE t1(a VARCHAR(10) CHARSET latin1, b VARCHAR(20) CHARSET utf16);
INSERT INTO t1 VALUES ('a', 'abcd');
SELECT (@x:=b) FROM t1;
SELECT * FROM t1 WHERE b = (SELECT (@x:=1) FROM t1) OR a = @x;
SELECT (@x:=a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (pk INTEGER PRIMARY KEY, d DATE);
INSERT INTO t1 VALUES(1, '2017-01-01');
SELECT d < 00010101000000.0 AS a FROM t1;
SELECT d < @tsn AS a FROM t1;
DROP TABLE t1;
CREATE TABLE numbers
(pk INTEGER PRIMARY KEY,
 ui BIGINT UNSIGNED,
 si BIGINT
);
INSERT INTO numbers VALUES
(0, 0, -9223372036854775808), (1, 18446744073709551615, 9223372036854775807);
PREPARE s1 FROM 'SELECT * FROM numbers WHERE ui=?';
PREPARE s2 FROM 'SELECT * FROM numbers WHERE si=?';
DEALLOCATE PREPARE s1;
DEALLOCATE PREPARE s2;
DROP TABLE numbers;
CREATE TABLE strings
(pk INTEGER PRIMARY KEY,
 vc_ascii VARCHAR(20) COLLATE ascii_general_ci,
 vc_latin1 VARCHAR(20) COLLATE latin1_general_ci,
 vc_utf8mb4 VARCHAR(20) COLLATE utf8mb4_0900_ai_ci,
 vc_utf16 VARCHAR(20) COLLATE utf16_general_ci,
 vc_utf32 VARCHAR(20) COLLATE utf32_general_ci
);
INSERT INTO strings VALUES
(0, @str_ascii, @str_ascii, @str_ascii, @str_ascii, @str_ascii),
(1, @str_ascii, @str_utf8mb4, @str_utf8mb4, @str_utf8mb4, @str_utf8mb4);
PREPARE s1 FROM 'SELECT HEX(vc_utf8mb4) FROM strings WHERE vc_ascii = ?';
PREPARE s2 FROM 'SELECT HEX(vc_utf8mb4) FROM strings WHERE vc_latin1 = ?';
PREPARE s3 FROM 'SELECT HEX(vc_utf8mb4) FROM strings WHERE vc_utf8mb4 = ?';
PREPARE s4 FROM 'SELECT HEX(vc_utf8mb4) FROM strings WHERE vc_utf16 = ?';
PREPARE s5 FROM 'SELECT HEX(vc_utf8mb4) FROM strings WHERE vc_utf32 = ?';
DEALLOCATE PREPARE s1;
DEALLOCATE PREPARE s2;
DEALLOCATE PREPARE s3;
DEALLOCATE PREPARE s4;
DEALLOCATE PREPARE s5;
DROP TABLE strings;
SELECT @maxint + 0e0;
SELECT 18446744073709551615 + 0e0;
SELECT @maxint + 0.0;
SELECT 18446744073709551615 + 0.0;
PREPARE s FROM 'SELECT 0e0 + ?';
DEALLOCATE PREPARE s;
PREPARE s FROM 'SELECT 0.0 + ?';
DEALLOCATE PREPARE s;
PREPARE s FROM 'SELECT 0 + ?';
DEALLOCATE PREPARE s;
PREPARE s FROM 'SELECT concat(?,"")';
DEALLOCATE PREPARE s;
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
