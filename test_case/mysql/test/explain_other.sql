
-- JSON format is different in hypergraph. And TRADITIONAL format does not work
-- with hypergraph.
--source include/not_hypergraph.inc

--
-- We need the Debug Sync Facility.
--
--source include/have_debug.inc
--source include/have_debug_sync.inc

CREATE DATABASE mysqltest1;
USE mysqltest1;
CREATE TABLE t1 (f1 int);
INSERT INTO t1 VALUES (1),(2);

let $QID= `SELECT CONNECTION_ID()`;

-- Kill explaining query
-- Test could be enabled when mysqltest will be able to 'send' two commands
-- at once. Meanwhile, one could use 3 command line clients to run this test
-- manually.
--connection ce;

-- Kill query being explained
-- Test could be enabled when mysqltest will be able to 'send' two commands
-- at once. Meanwhile, one could use 3 command line clients to run this test
-- manually.
--connection ce;
let $point= before_set_plan;
let $err=ER_EXPLAIN_NOT_SUPPORTED;
let $query= EXPLAIN SELECT f1 FROM t1;

-- Can''t explain statements not supported by regular EXPLAIN
let $point= before_join_exec;
let $query= SHOW FIELDS IN t1;

-- Can''t be used in prepared statement
--error 1295
PREPARE stmt FROM 'EXPLAIN FOR CONNECTION 1';

-- Can''t explain prepared statement
connection cq;
let $query= EXECUTE stmt;

-- Can''t be used from a procedure
--error 1235
CREATE PROCEDURE proc6369()
  EXPLAIN FOR CONNECTION 1;

-- Can''t explain a statement in a procedure
CREATE PROCEDURE proc6369()
  SELECT * FROM t1;
let $point= before_join_exec;
let $query= CALL proc6369();
let $err= ER_EXPLAIN_NOT_SUPPORTED;
DROP PROCEDURE proc6369;

-- Can''t explain itself
-- Connection id could vary, hide it.
--disable_query_log
let $qid= `SELECT CONNECTION_ID()`;

-- Explain for non-existing connection
--error ER_NO_SUCH_THREAD
EXPLAIN FOR CONNECTION 11111111;

let $err=0;
let $query= SELECT f1 FROM t1;

let $query= SELECT * FROM (SELECT * FROM t1) tt;

let $query= SELECT * FROM t1 WHERE f1 IN (SELECT * FROM t1);

let $query= SELECT * FROM t1 UNION ALL SELECT * FROM t1 ORDER BY 1;

let $format= json;
let $query= SELECT f1 FROM t1;

let $query= SELECT * FROM (SELECT * FROM t1) tt;

let $query= SELECT * FROM t1 WHERE f1 IN (SELECT * FROM t1);

let $query= SELECT * FROM t1 UNION ALL SELECT * FROM t1 ORDER BY 1;

-- Show zero result cause
let $query= SELECT * FROM t1 WHERE 1=0;

let $query= SELECT * FROM t1
GROUP BY f1 NOT IN
 (SELECT f1+10 AS f2 FROM t1 AS t2
  GROUP BY f2 NOT IN
  (SELECT f1+100 AS f3 FROM t1 AS t3));
let $point= planned_single_insert;
let $query= INSERT INTO t1 VALUES (3);

let $point= before_join_exec;
let $query= INSERT INTO t1 SELECT 4;

let $query= INSERT INTO t1 SELECT f1 + 4 FROM t1;

let $point= before_single_update;
let $query= UPDATE t1 SET f1=4 WHERE f1=4;

let $point= planned_single_update;
let $query= UPDATE t1 SET f1=4 WHERE f1=4;

CREATE TABLE t2 (f2 int);
let $query= UPDATE t1 SET f1=f1+0
ORDER BY f1 NOT IN
 (SELECT f1+10 AS f2 FROM t2
  GROUP BY f2 NOT IN
  (SELECT f1+100 AS f3 FROM t2 AS t3));

CREATE VIEW v1 AS SELECT t1.f1 FROM t1 JOIN t1 tt on t1.f1=tt.f1;
let $point= before_join_exec;
let $query= UPDATE v1 SET f1=5 WHERE f1=5;

let $point= planned_single_delete;
let $query= DELETE FROM t1 WHERE f1=4;

let $format= traditional;
let $point= planned_single_insert;
let $query= INSERT INTO t1 VALUES (3);

let $point= before_join_exec;
let $query= INSERT INTO t1 SELECT 4;

let $query= INSERT INTO t1 SELECT f1 + 4 FROM t1;

let $point= planned_single_update;
let $query= UPDATE t1 SET f1=4 WHERE f1=4;

let $point= before_join_exec;
let $query= UPDATE v1 SET f1=5 WHERE f1=5;

let $point= planned_single_delete;
let $query= DELETE FROM t1 WHERE f1=4;
let $point= after_join_optimize;
let $format= traditional;
let $query= SELECT * FROM (SELECT * FROM t1 GROUP BY 1) tt;

let $query= SELECT * FROM t1 UNION ALL SELECT * FROM t1 ORDER BY
  (SELECT * FROM t1 LIMIT 1);

let $format= json;
let $query= SELECT * FROM (SELECT * FROM t1 GROUP BY 1) tt;

let $query= SELECT * FROM t1 UNION ALL SELECT * FROM t1 ORDER BY
  (SELECT * FROM t1 LIMIT 1);
set @optimizer_switch_saved= @@optimizer_switch;
set optimizer_switch='derived_merge=off';
let $point= after_materialize_derived;
let $format= traditional;
let $query= SELECT * FROM (SELECT * FROM t1) tt;

let $format= json;
set optimizer_switch= @optimizer_switch_saved;
let $point= before_set_plan;
let $err=0;
let $query= SELECT t2.f1 FROM t1 STRAIGHT_JOIN t1 AS t2
WHERE t1.f1>(SELECT t3.f1 FROM t1 AS t3 LIMIT 1);
let $point= after_join_optimize;
let $err=0;
let $query= SELECT t2.f1 FROM t1 STRAIGHT_JOIN t1 AS t2
WHERE t1.f1>(SELECT t3.f1 FROM t1 AS t3 LIMIT 1);
let $point= before_reset_query_plan;
let $err=0;
let $query= SELECT t2.f1 FROM t1 STRAIGHT_JOIN t1 AS t2
WHERE t1.f1>(SELECT t3.f1 FROM t1 AS t3 LIMIT 1);

let $query= SELECT 1 FROM t1 WHERE
ROW(f1,f1) >= ROW('1', (SELECT 1 FROM t1 WHERE f1 > 1234));

CREATE TABLE t3 (pk INT PRIMARY KEY);
INSERT INTO t3 SELECT DISTINCT * FROM t1;
let $query= SELECT * FROM t3 WHERE pk=(SELECT f1 FROM t1 limit 1);
CREATE USER 'privtest'@'localhost';
CREATE VIEW v2 AS SELECT * FROM t2;

-- Show ACCESS DENIED for queries of other users

let $point= before_join_exec;
let $format= traditional;
let $query= SELECT f1 FROM t1;
let $err= 1045;

SELECT f2 FROM v2;
let $query= SELECT f2 FROM v2;
let $err=1045;

-- Show EXPLAIN CAN''T BE ISSUED if user lacks EXPLAIN rights, but can
-- execute statement. 

UPDATE v2 SET f2=1;
let $query= UPDATE v2 SET f2=1;
let $point= planned_single_update;
let $err=1345;

INSERT INTO v2 VALUES(1);
let $query= INSERT INTO v2 VALUES(1);
let $point= planned_single_insert;
let $err=1345;

INSERT INTO v2 SELECT 3 FROM t2;
let $query= INSERT INTO v2 SELECT 3 FROM t2;
let $point= before_join_exec;
let $err=1345;

SELECT f2 FROM v2;

DROP USER 'privtest'@localhost;
DROP VIEW v1, v2;
DROP TABLE t1, t2, t3;

-- Reconnect as root for non-priv bugs tests
connect (ce, localhost, root,, mysqltest1);

CREATE TABLE h2 (
pk int(11) NOT NULL AUTO_INCREMENT,
PRIMARY KEY (pk)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

insert into h2 values (1),(2),(3),(4),(5),(6),(7),(8),(9);

CREATE TABLE aa3 (
  col_int_key int(11) DEFAULT NULL,
  KEY col_int_key (col_int_key)
 ) ENGINE=InnoDB DEFAULT CHARSET=latin1;

let $point= before_join_exec;
let $err= 0;
let $query= SELECT alias1.pk AS field1 FROM h2 AS alias1 LEFT JOIN aa3 AS alias2 ON  alias1.pk =  alias2.col_int_key WHERE alias1.pk <> 9 GROUP BY field1 ORDER BY field1 LIMIT 1 OFFSET 3;

DROP TABLE h2, aa3;

CREATE TABLE t1 (
  pk int(11),
  col_int_key int(11) DEFAULT NULL,
  KEY col_int_key (col_int_key)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO t1 VALUES (NULL,NULL);
INSERT INTO t1 VALUES (6,NULL);
INSERT INTO t1 VALUES (8,-1131610112);
INSERT INTO t1 VALUES (2,-1009057792);
INSERT INTO t1 VALUES (-1220345856,1);
INSERT INTO t1 VALUES (NULL,-185204736);

let $query= SELECT pk FROM t1 WHERE col_int_key= 8;

DROP TABLE t1;

CREATE TABLE tbl1 (
  login int(11) NOT NULL,
  numb decimal(15,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (login),
  KEY numb (numb)
)  ;

CREATE TABLE tbl2 (
  login int(11) NOT NULL,
  cmd tinyint(4) NOT NULL,
  nump decimal(15,2) NOT NULL DEFAULT '0.00',
  KEY cmd (cmd),
  KEY login (login)
) ;

insert into tbl1 (login) values(1),(2);
insert ignore into tbl2 (login) values(1),(2);

-- disable_query_log
-- disable_result_log
ANALYZE TABLE tbl1, tbl2;

let $point= before_reset_query_plan;
let $query= 
SELECT 
  t1.login AS tlogin, 
  numb - 
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) -
  IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0) as sp
FROM tbl1 t1, tbl2 t2 
WHERE t1.login=t2.login 
GROUP BY t1.login 
ORDER BY numb - IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0)
              - IFNULL((SELECT sum(nump) FROM tbl2 WHERE login=t1.login), 0)
;

let $format= json;

DROP TABLE tbl1, tbl2;

create table t1(a char(10) charset latin1, key(a)) engine=innodb;
create table t2(a binary(10), key(a)) engine=innodb;

insert into t1 values('1'),('2'),('3'),('4');
insert into t2 values('1'),('2'),('s');

let $query= select 1 from  t1 inner join t2 using(a);
let $QID= `SELECT CONNECTION_ID()`;
SET DEBUG_SYNC= 'quick_not_created SIGNAL ready_for_explain WAIT_FOR explained';
SET DEBUG_SYNC= 'now WAIT_FOR ready_for_explain';
SET DEBUG_SYNC= 'after_explain_other SIGNAL explained';
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'quick_created_before_mutex SIGNAL ready_for_explain WAIT_FOR explained';
SET DEBUG_SYNC= 'now WAIT_FOR ready_for_explain';
SET DEBUG_SYNC= 'after_explain_other SIGNAL explained';
SET DEBUG_SYNC= 'RESET';
SET DEBUG_SYNC= 'quick_droped_after_mutex SIGNAL ready_for_explain WAIT_FOR explained';
SET DEBUG_SYNC= 'now WAIT_FOR ready_for_explain';
SET DEBUG_SYNC= 'after_explain_other SIGNAL explained';
DROP TABLE t1, t2;
create table t1(a int);
insert into t1 values(1),(2);
let $query= select * from (select * from t1) dt;
let $point= derived_not_set;
let $format= traditional;
let $err= ER_EXPLAIN_NOT_SUPPORTED;
let $err=0;
DROP TABLE t1;

SET DEBUG_SYNC= 'RESET';
USE test;
DROP DATABASE mysqltest1;
