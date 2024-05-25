select (1,2,3) IN ((3,2,3), (1,2,3), (1,3,3));
select row(10,2,3) IN (row(3,2,3), row(1,2,3), row(1,3,3));
select row(1,2,3) IN (row(3,NULL,3), row(1,2,3), row(1,3,3));
select row(10,2,3) IN (row(3,NULL,3), row(1,2,3), row(1,3,3));
select row('a',1.5,3) IN (row(1,2,3), row('a',1.5,3), row('a','a','a'));
select row('a',0,3) IN (row(3,2,3), row('a','a','3'), row(1,3,3));
select row('a',0,3) IN (row(3,2,3), row('a','0','3'), row(1,3,3));
select row('a',1.5,3) IN (row(3,NULL,3), row('a',1.5,3), row(1,3,3));
select row('b',1.5,3) IN (row(3,NULL,3), row('a',1.5,3), row(1,3,3));
select row('b',1.5,3) IN (row('b',NULL,3), row('a',1.5,3), row(1,3,3));
select row('b',1.5,3) IN (row('b',NULL,4), row('a',1.5,3), row(1,3,3));
select (1,2,(3,4)) IN ((3,2,(3,4)), (1,2,(3,4)));
select row(1,2,row(3,4)) IN (row(3,2,row(3,4)), row(1,2,row(3,NULL)));
select row(1,2,row(3,null)) IN (row(3,2,row(3,4)), row(1,2,row(4,5)));
select row(1,2,row(3,null)) IN (row(3,2,row(3,4)), row(1,2,row(3,5)));
SELECT (1,2,3)=(0,NULL,3);
SELECT (1,2,3)=(1,NULL,3);
SELECT (1,2,3)=(1,NULL,0);
SELECT ROW(1,2,3)=ROW(1,2,3);
SELECT ROW(2,2,3)=ROW(1+1,2,3);
SELECT ROW(1,2,3)=ROW(1+1,2,3);
SELECT ROW(1,2,3)<ROW(1+1,2,3);
SELECT ROW(1,2,3)>ROW(1+1,2,3);
SELECT ROW(1,2,3)<=ROW(1+1,2,3);
SELECT ROW(1,2,3)>=ROW(1+1,2,3);
SELECT ROW(1,2,3)<>ROW(1+1,2,3);
SELECT ROW(NULL,2,3)=ROW(NULL,2,3);
SELECT ROW(NULL,2,3)<=>ROW(NULL,2,3);
SELECT ROW(1,2,ROW(3,4,5))=ROW(1,2,ROW(3,4,5));
SELECT ROW('test',2,3.33)=ROW('test',2,3.33);
SELECT ROW('test',2,ROW(3,33))=ROW('test',2,ROW(3,33));
SELECT ROW('test',2,ROW(3,33))=ROW('test',2,ROW(3,3));
SELECT ROW('test',2,ROW(3,33))=ROW('test',2,ROW(3,NULL));
create table t1 ( a int, b int, c int);
insert into t1 values (1,2,3), (2,3,1), (3,2,1), (1,2,NULL);
select * from t1 where ROW(1,2,3)=ROW(a,b,c);
select * from t1 where ROW(0,2,3)=ROW(a,b,c);
select * from t1 where ROW(1,2,3)<ROW(a,b,c);
select ROW(a,2,3) IN(row(1,b,c), row(2,3,1)) from t1;
select ROW(c,2,3) IN(row(1,b,a), row(2,3,1)) from t1;
select ROW(a,b,c) IN(row(1,2,3), row(3,2,1)) from t1;
select ROW(1,2,3) IN(row(a,b,c), row(1,2,3)) from t1;
drop table t1;
create table t1 (i int);
drop table t1;
create table t1 (a int, b int);
insert into t1 values (1, 4);
insert into t1 values (10, 40);
insert into t1 values (1, 4);
insert into t1 values (10, 43);
insert into t1 values (1, 4);
insert into t1 values (10, 41);
insert into t1 values (1, 4);
insert into t1 values (10, 43);
insert into t1 values (1, 4);
select a, MAX(b), (1, MAX(b)) = (1, 4) from t1 group by a;
drop table t1;
SELECT ROW(2,10) <=> ROW(3,4);
SELECT ROW(NULL,10) <=> ROW(3,NULL);
CREATE TABLE t1(a int, b int, c int);
INSERT INTO t1 VALUES (1, 2, 3),
  (NULL, 2, 3  ), (1, NULL, 3  ), (1, 2,   NULL),
  (NULL, 2, 3+1), (1, NULL, 3+1), (1, 2+1, NULL),
  (NULL, 2, 3-1), (1, NULL, 3-1), (1, 2-1, NULL);
SELECT (1,2,3) = (1,   NULL, 3);
SELECT (1,2,3) = (1+1, NULL, 3);
SELECT (1,2,3) = (1,   NULL, 3+1);
SELECT * FROM t1 WHERE (a,b,c) = (1,2,3);
SELECT (1,2,3) <> (1,   NULL, 3);
SELECT (1,2,3) <> (1+1, NULL, 3);
SELECT (1,2,3) <> (1,   NULL, 3+1);
SELECT * FROM t1 WHERE (a,b,c) <> (1,2,3);
SELECT (1,2,3) < (NULL, 2,    3);
SELECT (1,2,3) < (1,    NULL, 3);
SELECT (1,2,3) < (1-1,  NULL, 3);
SELECT (1,2,3) < (1+1,  NULL, 3);
SELECT * FROM t1 WHERE (a,b,c) < (1,2,3);
SELECT (1,2,3) <= (NULL, 2,    3);
SELECT (1,2,3) <= (1,    NULL, 3);
SELECT (1,2,3) <= (1-1,  NULL, 3);
SELECT (1,2,3) <= (1+1,  NULL, 3);
SELECT * FROM t1 WHERE (a,b,c) <= (1,2,3);
SELECT (1,2,3) > (NULL, 2,    3);
SELECT (1,2,3) > (1,    NULL, 3);
SELECT (1,2,3) > (1-1,  NULL, 3);
SELECT (1,2,3) > (1+1,  NULL, 3);
SELECT * FROM t1 WHERE (a,b,c) > (1,2,3);
SELECT (1,2,3) >= (NULL, 2,    3);
SELECT (1,2,3) >= (1,    NULL, 3);
SELECT (1,2,3) >= (1-1,  NULL, 3);
SELECT (1,2,3) >= (1+1,  NULL, 3);
SELECT * FROM t1 WHERE (a,b,c) >= (1,2,3);
DROP TABLE t1;
SELECT ROW(1,1,1) = ROW(1,1,1) as `1`, ROW(1,1,1) = ROW(1,2,1) as `0`, ROW(1,NULL,1) = ROW(2,2,1) as `0`, ROW(1,NULL,1) = ROW(1,2,2) as `0`, ROW(1,NULL,1) = ROW(1,2,1) as `null`;
select row(NULL,1)=(2,0);
CREATE TABLE t1 (a int, b int, PRIMARY KEY (a,b));
INSERT INTO t1 VALUES (1,1), (2,1), (3,1), (1,2), (3,2), (3,3);
SELECT * FROM t1 WHERE a=3 and b=2;
SELECT * FROM t1 WHERE (a,b)=(3,2);
CREATE TABLE t2 (a int, b int, c int, PRIMARY KEY (a,b,c));
INSERT INTO t2 VALUES
  (1,1,2), (3,1,3), (1,2,2), (4,4,2),
  (1,1,1), (3,1,1), (1,2,1);
SELECT * FROM t1,t2 WHERE t1.a=t2.a and t1.b=t2.b;
SELECT * FROM t1,t2 WHERE (t1.a,t1.b)=(t2.a,t2.b);
SELECT * FROM t1,t2 WHERE t1.a=1 and t1.b=t2.b;
SELECT * FROM t1,t2 WHERE (t1.a,t1.b)=(t2.a,2);
SELECT * FROM t1,t2 WHERE (t1.a,t1.b)=(t2.a,t2.b+1);
SELECT * FROM t1,t2 WHERE (t1.a-1,t1.b)=(t2.a-1,t2.b+1);
SELECT * FROM t2 WHERE a=3 and b=2;
SELECT * FROM t2 WHERE (a,b)=(3,2);
SELECT * FROM t1,t2 WHERE (t2.a,(t2.b,t2.c))=(t1.a,(2,1));
SELECT * FROM t1,t2 WHERE t2.a=t1.a AND (t2.b,t2.c)=(2,1);
DROP TABLE t1,t2;
CREATE TABLE t1(
 a int, b int, c int, d int, e int, f int, g int, h int,
 PRIMARY KEY (a,b,c,d,e,f,g)
);
INSERT INTO t1 VALUES (1,2,3,4,5,6,7,99);
SELECT h FROM t1 WHERE (a,b,c,d,e,f,g)=(1,2,3,4,5,6,7);
SELECT @x;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT);
INSERT INTO t1 VALUES (1,1);
SELECT ROW(a, 1) IN (SELECT SUM(b), 1) FROM t1 GROUP BY a;
SELECT ROW(a, 1) IN (SELECT SUM(b), 3) FROM t1 GROUP BY a;
DROP TABLE t1;
create table t1 (a varchar(200),
                 b int unsigned not null primary key auto_increment)
default character set 'utf8mb3';
create table t2 (c varchar(200),
                 d int unsigned not null primary key auto_increment)
default character set 'latin1';
insert into t1 (a) values('abc');
insert into t2 (c) values('abc');
select * from t1,t2 where (a,b) = (c,d);
drop table t1,t2;
CREATE TABLE t1 (a TIME NOT NULL, b TINYINT);
INSERT IGNORE INTO t1 VALUES (0, 0),(0, 0);
SELECT 1 FROM t1 WHERE ROW(a, b) >=
ROW('1', (SELECT 1 FROM t1 WHERE a > '1234abc'));
DROP TABLE t1;
SELECT ROW(1,2) = (SELECT 1,2 FROM DUAL WHERE 1 = 0);
SELECT ROW(1,2) = (SELECT 1,3 FROM DUAL WHERE 1 = 0);
CREATE TABLE t1 (i INT);
INSERT INTO t1 () VALUES (1), (2), (3);
SELECT ROW(1,2) = (SELECT 1,2 FROM t1 WHERE 1 = 0);
SELECT ROW(1,2) = (SELECT 1,3 FROM t1 WHERE 1 = 0);
SELECT i FROM t1 WHERE ROW(1,2) = (SELECT 1,2 FROM DUAL WHERE 1 = 0);
SELECT i FROM t1 WHERE ROW(1,2) = (SELECT 1,3 FROM DUAL WHERE 1 = 0);
DROP TABLE t1;
CREATE TABLE t1 ( a INT ) ENGINE = INNODB;
INSERT INTO t1 VALUES ( 1 );
SELECT row( min(a), 1 ) = row( a, 1 ) AS al FROM t1 GROUP BY a;
SELECT row( min(a), 1 ) <> row( a, 1 ) AS al FROM t1 GROUP BY a;
SELECT row( min(a), 1 ) <=> row( a, 1 ) AS al FROM t1 GROUP BY a;
SELECT row( min(a), 1 ) > row( a, 1 ) AS al FROM t1 GROUP BY a;
SELECT row( min(a), 1 ) >= row( a, 1 ) AS al FROM t1 GROUP BY a;
SELECT row( min(a), 1 ) < row( a, 1 ) AS al FROM t1 GROUP BY a;
SELECT row( min(a), 1 ) <= row( a, 1 ) AS al FROM t1 GROUP BY a;
SELECT row( row( min(a), 1 ), 1 ) = row( row( a, 1 ), 1 ) AS al
FROM t1 GROUP BY a;
DROP TABLE t1;
CREATE TABLE v0(v1 DEC, v2 INT);
INSERT INTO v0 VALUES (64, 93);
CREATE ALGORITHM = TEMPTABLE VIEW v3 AS
SELECT *
FROM v0
WHERE (v1, FALSE) IN
 ((-1, EXISTS (SELECT (-128, 'x', 72) <= (76, 'x', -1))), (-1, 'x'));
DROP VIEW v3;
DROP TABLE v0;
