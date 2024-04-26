
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc


--disable_query_log
--disable_result_log

let $only_test = 0;
let $start_from = 1;
let $max_tests = 1000;

CREATE TABLE t1(f1 INT, f2 INT, KEY(f1), KEY(f2));
INSERT INTO t1 VALUES
(1,1), (2,2), (3,3), (4,4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
INSERT INTO t1 VALUES
(1,1), (2,2), (3,3), (4,4), (5, 5), (6, 6), (7, 7), (8, 8), (9, 9), (10, 10);
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT f1 + 10, f2 + 10 FROM t1;
INSERT INTO t1 SELECT f1 + 20, f2 + 20 FROM t1;
let $memory_key = memory/sql/THD::main_mem_root;
let $test_query = EXPLAIN SELECT f1 FROM t1 WHERE f1 BETWEEN 2 AND 4;
let $memory_key = Testing memory/sql/Prepared_statement::infrastructure;
let $test_query = PREPARE stmt FROM "SELECT * FROM t1";
let $memory_key = memory/sql/Prepared_statement::main_mem_root;
let $test_query = PREPARE stmt FROM "SELECT * FROM t1";
CREATE PROCEDURE p1 () SELECT GROUP_CONCAT(f1) FROM t1;
let $memory_key = memory/sql/THD::sp_cache;
let $test_query = CALL p1;
let $memory_key = memory/sql/sp_head::execute_mem_root;
let $test_query = CALL p1;
CREATE TABLE t2( a TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP );
CREATE TRIGGER trigger_for_normal_replace BEFORE INSERT ON t2 FOR EACH ROW SET @x:= NEW.a;
let $memory_key = memory/sql/sp_head::call_mem_root;
let $test_query = REPLACE INTO t2() VALUES();
DROP TABLE t2;
let $memory_key = memory/sql/test_quick_select;
let $test_query = EXPLAIN SELECT f1 FROM t1 WHERE f1 BETWEEN 2 AND 4;
CREATE TABLE t2 (a int) PARTITION BY RANGE (a)
  (PARTITION p0 VALUES LESS THAN (100),
   PARTITION p1 VALUES LESS THAN (200),
   PARTITION p2 VALUES LESS THAN (300),
   PARTITION p3 VALUES LESS THAN MAXVALUE);
INSERT INTO t2 VALUES (10), (100), (200), (300), (400);
let $memory_key = memory/sql/Partition::prune_exec;
let $test_query = EXPLAIN SELECT * FROM t2 WHERE a>=200;
DROP TABLE t2;
CREATE TABLE t2 (f1 LONGTEXT , f2  INTEGER);
INSERT INTO t2 VALUES
(REPEAT('abcdeabcdeabcdeabcde', 30000), 0),
(REPEAT('bcdefbcdefbcdefbcdef', 30000), 1),
(REPEAT('cdefgcdefgcdefgcdefg', 30000), 2);
let $memory_key = memory/sql/Blob_mem_storage::storage;
let $test_query = SELECT LENGTH(GROUP_CONCAT(f1 ORDER BY f2)) FROM t2;
DROP TABLE t2;
CREATE TABLE t2(a CHAR(0), b CHAR(0) NOT NULL DEFAULT '', c INT);
INSERT INTO t2(c) VALUES
(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0);
INSERT INTO t2(c)VALUES
(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0);
INSERT INTO t2(c)  SELECT a as b FROM t2;
let $memory_key = memory/sql/Filesort_info::merge;
let $test_query = SELECT /*+ SET_VAR(sort_buffer_size= 32768)*/ COUNT(DISTINCT a) FROM t2 GROUP BY b;
DROP TABLE t2;
CREATE TABLE t2 (a INT);
INSERT INTO t2 VALUES(0), (1), (2), (3), (4), (5), (6), (7), (8), (9);
let $memory_key = memory/sql/Filesort_info::record_pointers;
let $test_query = SELECT /*+SET_VAR(max_sort_length=4)*/ * FROM t2 ORDER BY a + 1111111111.1111111111 LIMIT 1;
DROP TABLE t2;
let $memory_key = memory/sql/Filesort_buffer::sort_keys;
let $test_query = SELECT * FROM t1 ORDER BY f1;
CREATE TABLE t2 (
  FieldKey varchar(36) NOT NULL default '',
  LongVal bigint(20) default NULL,
  StringVal mediumtext,
  KEY FieldKey (FieldKey),
  KEY LongField (FieldKey,LongVal),
  KEY StringField (FieldKey,StringVal(32))
) charset utf8mb4;
INSERT INTO t2 VALUES ('0',3,'0'),('0',2,'1'),('0',1,'2'),('1',2,'1'),('1',1,'3'), ('1',0,'2'),('2',3,'0'),('2',2,'1'),('2',1,'2'),
('2',3,'0'),('2',2,'1'),('2',1,'2'),('3',2,'1'),('3',1,'2'),('3','3','3');
let $memory_key = memory/sql/IndexRangeScanIterator::mrr_buf_desc;
let $test_query = SELECT /*+SET_VAR(optimizer_switch='mrr_cost_based=off')*/* FROM t2 WHERE FieldKey > '2' ORDER BY LongVal;
DROP TABLE t2;
SELECT 1 INTO OUTFILE '../../tmp/f1.txt';
CREATE TABLE t2(a BLOB, b INT);
let $memory_key = memory/sql/READ_INFO;
let $test_query = LOAD DATA INFILE '../../tmp/f1.txt' REPLACE INTO TABLE t2 FIELDS TERMINATED BY '' (b) SET b:= 1;
DROP TABLE t2;
let $memory_key = memory/sql/TABLE::sort_io_cache;
let $test_query = SELECT * FROM t1 ORDER BY f1;
CREATE TABLE t3 (
  id int NOT NULL auto_increment PRIMARY KEY,
  b int NOT NULL,
  c datetime NOT NULL,
  INDEX idx_b(b),
  INDEX idx_c(c)
) ENGINE=InnoDB;

CREATE TABLE t2 (
  b int NOT NULL auto_increment PRIMARY KEY,
  c datetime NOT NULL
) ENGINE= InnoDB;

INSERT INTO t2(c) VALUES ('2007-01-01');
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t2(c) SELECT c FROM t2;
INSERT INTO t3(b,c) SELECT b,c FROM t2;
UPDATE t2 SET c='2007-01-02';
INSERT INTO t3(b,c) SELECT b,c FROM t2;
UPDATE t2 SET c='2007-01-03';
INSERT INTO t3(b,c) SELECT b,c FROM t2;
let $memory_key = memory/sql/Unique::sort_buffer;
let $test_query = SELECT /*+SET_VAR(sort_buffer_size=8192)*/ COUNT(*) FROM t3 FORCE INDEX(idx_b, idx_c) WHERE (c >= '2007-01-02' AND c <= '2007-01-03') OR b >= 1;
DROP TABLE t3,t2;
CREATE TABLE t2 (a INT);
INSERT INTO t2 VALUES (1),(2),(3),(4),(5),(6),(7),(8);
INSERT INTO t2 SELECT a+8 FROM t2;
INSERT INTO t2 SELECT a+16 FROM t2;
INSERT INTO t2 SELECT a+32 FROM t2;
INSERT INTO t2 SELECT a+64 FROM t2;
INSERT INTO t2 VALUE(NULL);
let $memory_key = memory/sql/Unique::merge_buffer;
let $test_query = SELECT /*+ SET_VAR(tmp_table_size=1024) */ COUNT(DISTINCT a) FROM t2;
DROP TABLE t2;
let $memory_key = memory/sql/bison_stack;
let $test_query = SELECT ((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((((1))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
CREATE TABLE t0(c0 INT);
CREATE TABLE t3(c0 DOUBLE);
CREATE TABLE t2(c0 DOUBLE);
INSERT INTO t0 VALUES(0);
INSERT INTO t3 VALUES('-0');
INSERT INTO t2 VALUES('+0');
let $memory_key = memory/sql/hashed_operation;
let $test_query = SELECT * FROM t0, t3 WHERE t0.c0 = t3.c0;
DROP TABLE t0, t3, t2;

DROP PROCEDURE p1;
DROP TABLE t1;
CREATE TABLE t1 (i BIGINT);
CREATE TABLE t2 (i BIGINT);
INSERT INTO t1 VALUES (1), (2), (3);
INSERT INTO t2 VALUES (2), (3);

let $count=9;
{
  eval INSERT INTO t1 SELECT * FROM t1;
  dec $count;

SET GLOBAL join_buffer_size = 2048;
let $memory_key = memory/sql/hash_join;
let $test_query = SELECT /*+ SET_VAR(optimizer_switch='materialization=off,firstmatch=off') */
                  COUNT(*) FROM t2 WHERE (t2.i) IN (SELECT t1.i FROM t1);
SET GLOBAL join_buffer_size = default;
DROP TABLE t1, t2;
