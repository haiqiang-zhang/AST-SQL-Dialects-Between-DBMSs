
--
-- Init section
--
--disable_warnings
drop table if exists t1;

--
-- Simple IF tests
--

select IF(0,"ERROR","this"),IF(1,"is","ERROR"),IF(NULL,"ERROR","a"),IF(1,2,3)|0,IF(1,2.0,3.0)+0 ;

--
-- Test of IF and case-sensitiveness
--
CREATE TABLE t1 (st varchar(255) NOT NULL, u int(11) NOT NULL);
INSERT INTO t1 VALUES ('a',1),('A',1),('aa',1),('AA',1),('a',1),('aaa',0),('BBB',0);
select if(1,st,st) s from t1 order by s;
select if(u=1,st,st) s from t1 order by s;
select if(u=1,binary st,st) s from t1 order by s;
select if(u=1,st,binary st) s from t1 where st like "%a%" order by s;

--
-- NULLIF test
--
select nullif(u, 1) from t1;
drop table t1;
select nullif(1,'test');

--
-- Bug 2629
--
select NULLIF(NULL,NULL), NULLIF(NULL,1), NULLIF(NULL,1.0), NULLIF(NULL,"test");
select NULLIF(1,NULL), NULLIF(1.0, NULL), NULLIF("test", NULL);

--
-- Problem with IF()
--

create table t1 (num  double(12,2));
insert into t1 values (144.54);
select sum(if(num is null,0.00,num)) from t1;
drop table t1;
create table t1 (x int, y int);
insert into t1 values (0,6),(10,16),(20,26),(30,10),(40,46),(50,56);
select min(if(y -x > 5,y,NULL)), max(if(y - x > 5,y,NULL)) from t1;
drop table t1;

--
-- BUG#3987
--
create table t1 (a int);
insert t1 values (1),(2);
select if(1>2,a,avg(a)) from t1;
drop table t1;

--
-- Bug #5595  NULLIF() IS NULL returns false if NULLIF() returns NULL
--
SELECT NULLIF(5,5) IS NULL, NULLIF(5,5) IS NOT NULL;

--
-- Bug #9669 Ordering on IF function with FROM_UNIXTIME function fails
--
CREATE TABLE `t1` (
  `id` int(11) NOT NULL ,
  `date` int(10) default NULL,
  `text` varchar(32) NOT NULL
);
INSERT INTO t1 VALUES (1,1110000000,'Day 1'),(2,1111000000,'Day 2'),(3,1112000000,'Day 3');
SELECT id, IF(date IS NULL, '-', FROM_UNIXTIME(date, '%d-%m-%Y')) AS date_ord, text FROM t1 ORDER BY date_ord ASC;
SELECT id, IF(date IS NULL, '-', FROM_UNIXTIME(date, '%d-%m-%Y')) AS date_ord, text FROM t1 ORDER BY date_ord DESC;
DROP TABLE t1;


--
-- Test for bug #11142: evaluation of NULLIF when the first argument is NULL
--

CREATE TABLE t1 (a CHAR(10));
INSERT INTO t1 VALUES ('aaa'), (NULL), (''), ('bbb');

SELECT a, NULLIF(a,'') FROM t1;
SELECT a, NULLIF(a,'') FROM t1 WHERE NULLIF(a,'') IS NULL;

DROP TABLE t1;

-- End of 4.1 tests

--
-- Bug #16272 IF function with decimal args can produce wrong result
--
create table t1 (f1 int, f2 int);
insert into t1 values(1,1),(0,0);
select f1, f2, if(f1, 40.0, 5.00) from t1 group by f1 order by f2;
drop table t1;

--
-- Bug#24532 (The return data type of IS TRUE is different from similar
-- operations)
--
-- IF(x, unsigned, unsigned) should be unsigned.
--

select if(0, 18446744073709551610, 18446744073709551610);


--
-- Bug #37662: nested if() inside sum() is parsed in exponential time
--

CREATE TABLE t1(a DECIMAL(10,3));

-- check : should be fast. more than few secs means failure.
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

--
-- Bug #40761: Assert on sum func on IF(..., CAST(longtext AS UNSIGNED), signed)
--             (was: LEFT JOIN on inline view crashes server)
--

CREATE TABLE t1 (c LONGTEXT);
INSERT INTO t1 VALUES(1), (2), (3), (4), ('12345678901234567890');

SELECT * FROM (SELECT MAX(IF(1, CAST(c AS UNSIGNED), 0)) FROM t1) AS te;
SELECT * FROM (SELECT MAX(IFNULL(CAST(c AS UNSIGNED), 0)) FROM t1) AS te;

DROP TABLE t1;

CREATE TABLE t1 (a LONGBLOB, b DOUBLE);
INSERT INTO t1 VALUES (NULL, 0), (NULL, 1);
SELECT IF(b, (SELECT a FROM t1 LIMIT 1), b) c FROM t1 GROUP BY c;

DROP TABLE t1;

SELECT if(0, (SELECT min('hello')), NULL);
SELECT if(1, (SELECT min('hello')), NULL);
SELECT if(0, NULL, (SELECT min('hello')));
SELECT if(1, NULL, (SELECT min('hello')));

let $nines= 9999999999999999999999999999999999999;
                (select adddate(elt(convert($nines,decimal(64,0)),count(*)),
                                interval 1 day))
                , .1))) as foo;

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
ORDER BY 1
;

DROP TABLE test_grids_1, test_grid_dtl_1;

DO NULLIF(CAST(DATABASE() AS TIME), 1);

SELECT NULLIF(1,2);
SELECT JSON_ARRAYAGG(NULLIF(1,2));
SELECT JSON_ARRAYAGG(CASE WHEN 1 = 2 THEN NULL ELSE 1 END);
SELECT NULLIF(true,false);
SELECT JSON_ARRAYAGG(NULLIF(true,false));
SELECT JSON_ARRAYAGG(CASE WHEN true = false THEN NULL ELSE true END);

DO GROUP_CONCAT(NULLIF(ELT(1, @e), POINT(250,41)) ORDER BY 1);

CREATE TABLE t (t_date DATETIME NULL);
SET @t_date = NOW();
DROP TABLE t;

DO CAST(UNIX_TIMESTAMP(IF('',3,13339)) AS UNSIGNED);

SELECT AVG(NULLIF(YEAR('2001-01-01'),10));

CREATE TABLE t1(y YEAR);
INSERT INTO t1 VALUES(2001);

SELECT AVG(NULLIF(y, 10)) FROM t1;

DROP TABLE t1;
