select IF(0,"ERROR","this"),IF(1,"is","ERROR"),IF(NULL,"ERROR","a"),IF(1,2,3)|0,IF(1,2.0,3.0)+0;
CREATE TABLE t1 (st varchar(255) NOT NULL, u int(11) NOT NULL);
INSERT INTO t1 VALUES ('a',1),('A',1),('aa',1),('AA',1),('a',1),('aaa',0),('BBB',0);
select if(1,st,st) s from t1 order by s;
select if(u=1,st,st) s from t1 order by s;
select if(u=1,binary st,st) s from t1 order by s;
select if(u=1,st,binary st) s from t1 where st like "%a%" order by s;
select nullif(u, 1) from t1;
drop table t1;
select NULLIF(NULL,NULL), NULLIF(NULL,1), NULLIF(NULL,1.0), NULLIF(NULL,"test");
create table t1 (num  double(12,2));
insert into t1 values (144.54);
select sum(if(num is null,0.00,num)) from t1;
drop table t1;
create table t1 (x int, y int);
insert into t1 values (0,6),(10,16),(20,26),(30,10),(40,46),(50,56);
select min(if(y -x > 5,y,NULL)), max(if(y - x > 5,y,NULL)) from t1;
drop table t1;
create table t1 (a int);
insert t1 values (1),(2);
drop table t1;
CREATE TABLE `t1` (
  `id` int(11) NOT NULL ,
  `date` int(10) default NULL,
  `text` varchar(32) NOT NULL
);
INSERT INTO t1 VALUES (1,1110000000,'Day 1'),(2,1111000000,'Day 2'),(3,1112000000,'Day 3');
SELECT id, IF(date IS NULL, '-', FROM_UNIXTIME(date, '%d-%m-%Y')) AS date_ord, text FROM t1 ORDER BY date_ord ASC;
SELECT id, IF(date IS NULL, '-', FROM_UNIXTIME(date, '%d-%m-%Y')) AS date_ord, text FROM t1 ORDER BY date_ord DESC;
DROP TABLE t1;
CREATE TABLE t1 (a CHAR(10));
INSERT INTO t1 VALUES ('aaa'), (NULL), (''), ('bbb');
DROP TABLE t1;
create table t1 (f1 int, f2 int);
insert into t1 values(1,1),(0,0);
drop table t1;
select if(0, 18446744073709551610, 18446744073709551610);
CREATE TABLE t1(a DECIMAL(10,3));
SELECT t1.a,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,
 IF((ROUND(t1.a,2)=1), 2,0)))))))))))))))))))))))))))))) + 1
FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (c LONGTEXT);
INSERT INTO t1 VALUES(1), (2), (3), (4), ('12345678901234567890');
SELECT * FROM (SELECT MAX(IF(1, CAST(c AS UNSIGNED), 0)) FROM t1) AS te;
SELECT * FROM (SELECT MAX(IFNULL(CAST(c AS UNSIGNED), 0)) FROM t1) AS te;
DROP TABLE t1;
CREATE TABLE t1 (a LONGBLOB, b DOUBLE);
INSERT INTO t1 VALUES (NULL, 0), (NULL, 1);
SELECT IF(b, (SELECT a FROM t1 LIMIT 1), b) c FROM t1 GROUP BY c;
DROP TABLE t1;
CREATE TABLE t1(c1 INT);
INSERT INTO t1 VALUES(1);
UPDATE t1 SET c1 = 2 WHERE IF(true, '2015-01-01', '2015-01-01') IS NOT NULL;
DROP TABLE t1;
CREATE TABLE test_grids_1 (
  unq_id int(11) NOT NULL DEFAULT '0',
  var_fld int(11) DEFAULT '0'
);
INSERT INTO test_grids_1 VALUES
  (1,4500),
  (2,6000);
CREATE TABLE test_grid_dtl_1 (
  dtl_id int(11) NOT NULL DEFAULT '0',
  unq_id int(11) DEFAULT '0'
);
INSERT INTO test_grid_dtl_1 VALUES
  (1,1),
  (2,1),
  (3,2);
SELECT g.calc_var, g.if_var, g.case_var
FROM
  (
  SELECT unq_id,
    IF ( var_fld  > 5000, (     1 / var_fld ) , 5000 ) calc_var,
    IF ( var_fld  > 5000, ( 00001 / var_fld ) , 5000 ) if_var,
    CASE  var_fld  > 5000 WHEN TRUE THEN ( 1 / var_fld ) ELSE 5000 END case_var
  FROM
    test_grids_1
  ) g
  JOIN
    test_grid_dtl_1 d USING (unq_id)
ORDER BY 1;
DROP TABLE test_grids_1, test_grid_dtl_1;
SELECT JSON_ARRAYAGG(NULLIF(1,2));
CREATE TABLE t (t_date DATETIME NULL);
PREPARE ps FROM 'INSERT INTO t SET t_date = NULLIF(?, '''')';
DEALLOCATE PREPARE ps;
DROP TABLE t;
SELECT AVG(NULLIF(YEAR('2001-01-01'),10));
CREATE TABLE t1(y YEAR);
INSERT INTO t1 VALUES(2001);
DROP TABLE t1;
