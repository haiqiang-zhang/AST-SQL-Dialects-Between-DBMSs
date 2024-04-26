 
--  Mixed SE in a single statement will need to call ha_records from execute
--  phase only.

--source include/force_myisam_default.inc
--source include/have_myisam.inc

CREATE TABLE t_innodb(c1 INT NOT NULL PRIMARY KEY,
                      c2 INT NOT NULL,
                      c3 char(20),
                      KEY c3_idx(c3))ENGINE=INNODB;

INSERT INTO t_innodb VALUES (1, 1, 'a'), (2,2,'a'), (3,3,'a');

CREATE TABLE t_myisam(c1 INT NOT NULL PRIMARY KEY,
                      c2 INT NOT NULL DEFAULT 1,
                      c3 char(20),
                      KEY c3_idx(c3)) ENGINE=MYISAM;

INSERT INTO t_myisam(c1) VALUES (1), (2);

-- ha_records is called from execution phase.
let query1= SELECT COUNT(*) FROM t_innodb;

-- Tables are optimized away because there is HA_COUNT_ROWS_INSTANT
let query2= SELECT COUNT(*) FROM t_myisam;

-- Neither table is optimized away. ha_records is called from execution phase
-- for both tables.
let query3= SELECT COUNT(*) FROM t_myisam, t_innodb;

-- Uses table scan for MIN(c2) because there is no index on c2.
let query4= SELECT MIN(c2), COUNT(*), MAX(c1) FROM t_innodb;

-- Uses c3_idx for MIN -> direct call from opt_sum_query (optimization phase).
-- Uses c3_idx for COUNT(*) from end_send_count (execution phase).
let query5= SELECT MIN(c3), COUNT(*) FROM t_innodb;

-- This WL should affect a table with no primary key only to the extent that
-- call to records happens in execution phase now. 

CREATE TABLE t_nopk(c1 INT NOT NULL , c2 INT NOT NULL)ENGINE=INNODB;
INSERT INTO t_nopk SELECT c1, c2 FROM t_innodb;

let query6= SELECT COUNT(*) FROM t_nopk;

-- Add a secondary index and notice the difference in the plan. 
CREATE INDEX c2_idx on t_nopk(c2);

DROP TABLE t_nopk;

-- Set of tests to check if records / records_from_index are called correctly.

CREATE TABLE t_innodb_nopk_sk(c1 INT NOT NULL,
                              c2 INT NOT NULL, KEY c2_idx(c2))ENGINE=INNODB;
CREATE TABLE t_innodb_pk_nosk(c1 INT NOT NULL PRIMARY KEY,
                              c2 INT NOT NULL)ENGINE=INNODB;
CREATE TABLE t_innodb_nopk_nosk(c1 INT NOT NULL,
                                c2 INT NOT NULL)ENGINE=INNODB;
INSERT INTO t_innodb_nopk_sk(c1,c2) VALUES (1, 1), (2,2), (3,3);
INSERT INTO t_innodb_pk_nosk(c1,c2) SELECT * FROM t_innodb_nopk_sk;
INSERT INTO t_innodb_nopk_nosk(c1,c2) SELECT * FROM t_innodb_nopk_sk;
let query7= SELECT COUNT(*) FROM t_innodb_nopk_sk;
let query8= SELECT COUNT(*) FROM t_innodb_pk_nosk;
let query9= SELECT COUNT(*) FROM t_innodb_nopk_nosk;

DROP TABLE t_innodb_pk_nosk, t_innodb_nopk_sk, t_innodb_nopk_nosk;
CREATE TABLE t_heap(c1 INT NOT NULL PRIMARY KEY,
                      c2 INT NOT NULL,
                      c3 char(20)) ENGINE=HEAP;
CREATE TABLE t_archive(c1 INT NOT NULL, c2 char(20)) ENGINE=ARCHIVE;

INSERT INTO t_heap SELECT * FROM t_innodb WHERE c1 > 1;
INSERT INTO t_archive SELECT c1, c3 FROM t_innodb WHERE c1 > 1;

let query10= SELECT COUNT(*) FROM t_heap;
let query11= SELECT COUNT(*) FROM t_innodb, t_heap;
let query12= SELECT COUNT(*) FROM t_archive;
let query13= SELECT COUNT(*) FROM t_innodb, t_archive;
DROP TABLE t_archive, t_heap;
let query14= SELECT COUNT(*) FROM t_innodb FORCE INDEX(c3_idx);

-- Tables aren't optimized away here because of force index.
let query15= SELECT COUNT(*) FROM t_myisam FORCE INDEX(c3_idx);

-- tests opt_sum_query(): tables_filled &= !(...). Without the "&" we access
-- the temptable SE's temptable::Handler::records
SELECT COUNT(*) FROM (SELECT DISTINCT c1 FROM t_myisam) dt, t_myisam;

-- Tests end_send_count: if (copy_fields(....))
SET @s =1;
SELECT @s, COUNT(*) FROM t_innodb;

set sql_mode='';
SELECT 1 AS c1, (SELECT COUNT(*) FROM t_innodb HAVING c1 > 0) FROM DUAL;
SELECT 1 FROM t_innodb HAVING COUNT(*) > 1;

SELECT COUNT(*) c FROM t_innodb HAVING c > 1;
SELECT COUNT(*) c FROM t_innodb HAVING c > 7;

-- Tests FORMAT=tree printing of COUNT(*).
--skip_if_hypergraph  -- Does not optimize COUNT(*) specially yet.
EXPLAIN FORMAT=tree SELECT COUNT(*) c FROM t_innodb HAVING c > 7;

-- Should be empty.
SELECT COUNT(*) c FROM t_innodb LIMIT 10 OFFSET 5;

set sql_mode=default;

-- Bug #28056133: Requires a fix in get_exact_record_count to avoid dummy temp
-- tables.
SELECT SQL_BIG_RESULT COUNT(*) FROM t_innodb;
SELECT SQL_BIG_RESULT COUNT(*) FROM t_innodb, t_myisam;

-- Unqualified COUNT(*) (running in the iterator executor) combined with BNL
-- (running in the pre-iterator executor).
-- TODO(sgunders): Remove when BNL enters the iterator executor.
--sorted_result
SELECT /*+ BNL(t2) */ -(t1.c1 + t2.c1) FROM t_innodb t1, t_innodb t2
UNION ALL SELECT COUNT(*) FROM t_innodb;

DROP TABLE t_innodb, t_myisam;
