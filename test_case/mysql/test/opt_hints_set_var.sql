SELECT /*+ SET_VAR(foo = 10) */ 1;
SELECT /*+ SET_VAR(foo = 1K) */ 1;
SELECT /*+ SET_VAR(foo = 21M) */ 1;
SELECT /*+ SET_VAR(foo = 321G) */ 1;
SELECT /*+ SET_VAR(foo = 9000100500G) */ 1;
SELECT /*+ SET_VAR(foo = 'test') */ 1;
SELECT /*+ SET_VAR(foo = "test""test") */ 1;
SELECT /*+ SET_VAR(foo = 900010050018247362846826482468) */ 1;
SELECT /*+ QB_NAME(1KLMN) */ 1;
SELECT /*+ SET_VAR(foo = 900010050018247362846826482468000) */ 1;
SELECT /*+ SET_VAR(range_alloc_block_size=7000) */ 1;
DROP TABLE t1;
PREPARE stmt FROM "SELECT /*+ SET_VAR(big_tables=on) */ VARIABLE_VALUE FROM performance_schema.session_variables where VARIABLE_NAME = 'big_tables'";
SELECT VARIABLE_VALUE FROM performance_schema.session_variables where VARIABLE_NAME = 'big_tables';
SELECT VARIABLE_VALUE FROM performance_schema.session_variables where VARIABLE_NAME = 'big_tables';
SELECT VARIABLE_VALUE FROM performance_schema.session_variables where VARIABLE_NAME = 'big_tables';
DEALLOCATE PREPARE stmt;
CREATE TABLE t1 (col INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
INSERT /*+ SET_VAR(auto_increment_increment=10) */ INTO t1 VALUES (NULL), (NULL), (NULL), (NULL);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (col INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
INSERT /*+ SET_VAR(auto_increment_increment=10) SET_VAR(auto_increment_offset=5) */ INTO t1 VALUES (NULL), (NULL), (NULL), (NULL);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (a CHAR PRIMARY KEY);
INSERT INTO t1 VALUES (1),(2);
SELECT COUNT(DISTINCT t1.a) FROM t1,t1 t2 WHERE t1.a = 1;
DROP TABLE  t1;
CREATE TEMPORARY TABLE t1 SELECT 1;
CREATE TEMPORARY TABLE t2 SELECT /*+ SET_VAR(default_tmp_storage_engine=InnoDB)*/ 1;
DROP TABLE t1, t2;
SELECT /*+ SET_VAR(div_precision_increment=12) */ 1/2;
CREATE TABLE t1
(
 id INT PRIMARY KEY
) ENGINE=InnoDB;
CREATE TABLE t2
(
 v INT,
 CONSTRAINT c1 FOREIGN KEY (v) REFERENCES t1(id)
) ENGINE=InnoDB;
INSERT /*+ SET_VAR(foreign_key_checks=0) */INTO t2 VALUES(2);
DROP TABLE t2, t1;
CREATE TABLE t1( a VARCHAR( 10 ), b INT );
INSERT INTO t1 VALUES ( repeat( 'a', 10 ), 1),
                      ( repeat( 'b', 10 ), 2);
SELECT /*+ SET_VAR(group_concat_max_len=20) */ GROUP_CONCAT(a) FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (col INT NOT NULL AUTO_INCREMENT PRIMARY KEY);
INSERT /*+ SET_VAR(insert_id=10) */ INTO t1 VALUES (NULL), (NULL), (NULL), (NULL);
SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(i INT) ENGINE InnoDB;
LOCK TABLES t1 WRITE;
INSERT /*+ SET_VAR(lock_wait_timeout=1) */INTO t1 VALUES (1);
UNLOCK TABLES;
DROP TABLE t1;
CREATE TABLE t1(f1 INT);
DROP TABLE t1;
CREATE TABLE t1 (a INT, b VARCHAR(300));
INSERT INTO t1 VALUES (1, 'string');
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1(f1 CHAR(255) CHARSET utf8mb3);
INSERT INTO t1 VALUES('1'),('2'),('3'),('4'),('5'),('6'),('7'),('8'),('9'),('0');
SELECT /*+ SET_VAR(max_heap_table_size=16384) SET_VAR(internal_tmp_mem_storage_engine=MEMORY)*/ count(*)
FROM t1 JOIN (
  SELECT t1.f1 FROM t1 JOIN t1 AS t2 JOIN t1 AS t3) tt ON t1.f1 = tt.f1;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b INT, PRIMARY KEY (a));
CREATE TABLE t2 (a INT, INDEX a (a));
CREATE TABLE t3 (a INT, b INT, INDEX a (a,b));
INSERT INTO t1 VALUES (1,10), (2,20), (3,30),  (4,40);
INSERT INTO t2 VALUES (2), (3), (4), (5);
INSERT INTO t3 VALUES (10,3), (20,4), (30,5);
DROP TABLE t1, t2, t3;
CREATE TABLE t1
(
  f1 int NOT NULL DEFAULT '0',
  f2 int NOT NULL DEFAULT '0',
  f3 int NOT NULL DEFAULT '0',
  INDEX idx1(f2, f3), INDEX idx2(f3)
);
INSERT INTO t1(f1) VALUES (1), (2), (3), (4), (5), (6), (7), (8);
INSERT INTO t1(f2, f3) VALUES (3,4), (3,4);
SELECT * FROM t1 WHERE f2 <= 3 AND 3 <= f3;
SELECT /*+ SET_VAR(optimizer_switch='mrr=off') */ * FROM t1 WHERE f2 <= 3 AND 3 <= f3;
DROP TABLE t1;
CREATE TABLE t1 (f1 INT, KEY(f1));
INSERT INTO t1 VALUES (1), (2), (3), (4), (5), (6), (7);
SELECT /*+ SET_VAR(range_optimizer_max_mem_size=1) */ f1 FROM t1 WHERE f1 = 1 OR f1 = 2 OR f1 = 6;
DROP TABLE t1;
CREATE TABLE t1 (f1 CHAR(255));
INSERT INTO t1 VALUES ('aaa'), ('bbb'), ('ccc'), ('ddd'), ('eee');
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
SELECT /*+ SET_VAR(sort_buffer_size=32768) */f1 FROM t1 ORDER BY f1;
SELECT f1 FROM t1 ORDER BY f1;
DROP TABLE t1;
CREATE TABLE t1 (a INT AUTO_INCREMENT PRIMARY KEY);
INSERT INTO t1 VALUES (NULL);
SELECT /*+ SET_VAR(sql_auto_is_null=1) */ a FROM t1 WHERE a IS NULL;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b VARCHAR(300));
INSERT INTO t1 VALUES (1, 'string');
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
INSERT INTO t1 SELECT * FROM t1;
DROP TABLE t1;
CREATE TABLE t1 (
  a int,
  b varchar(1),
  KEY (b,a)
) charset utf8mb4;
INSERT INTO t1 VALUES (1,NULL),(0,'a'),(1,NULL),(0,'a');
INSERT INTO t1 VALUES (1,'a'),(0,'a'),(1,'a'),(0,'a');
DROP TABLE t1;
CREATE TABLE t1 (f1 DATE);
INSERT /*+ SET_VAR(sql_mode='ALLOW_INVALID_DATES') */ INTO t1 VALUES ('00-00-00');
DROP TABLE t1;
CREATE TABLE t1 ( a INT, KEY( a ) );
INSERT INTO t1 VALUES (0), (1);
CREATE VIEW v1 AS SELECT t11.a, t12.a AS b FROM t1 t11, t1 t12;
DROP TABLE t1;
DROP VIEW v1;
CREATE TABLE t1 (f1 INT);
INSERT INTO t1 VALUES (1), (2);
SELECT /*+ SET_VAR(sql_select_limit=1) */* FROM t1;
DROP TABLE t1;
SELECT /*+ SET_VAR(timestamp=1322115328) */ CAST(UNIX_TIMESTAMP() AS TIME);
CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1),(2),(3),(4),(5),(6),(7),(8);
INSERT INTO t1 SELECT a+8 FROM t1;
INSERT INTO t1 SELECT a+16 FROM t1;
INSERT INTO t1 SELECT a+32 FROM t1;
INSERT INTO t1 SELECT a+64 FROM t1;
INSERT INTO t1 VALUE(NULL);
DROP TABLE t1;
CREATE TABLE t1 (d DOUBLE, id INT, sex CHAR(1), n INT NOT NULL AUTO_INCREMENT, PRIMARY KEY(n));
INSERT INTO t1(d, id, sex) VALUES (1.0, 1, 'M'),
                                  (2.0, 2, 'F'),
                                  (3.0, 3, 'F'),
                                  (4.0, 4, 'F'),
                                  (5.0, 5, 'M'),
                                  (NULL, NULL, 'M'),
                                  (10.0, 10, NULL),
                                  (10.0, 10, NULL),
                                  (11.0, 11, NULL);
DROP TABLE t1;
SELECT /*+ SET_VAR(sql_select_limit = 18446744073709551616) */ 1;
SELECT /*+ SET_VAR(sql_select_limit = 18446744073709551615) */ 1;
SELECT TIMEDIFF(NOW(), UTC_TIMESTAMP);
SELECT @@time_zone;
SELECT @@time_zone;
CREATE TABLE t1(f1 VARCHAR(10));
INSERT INTO t1 VALUES (@@time_zone);
SELECT * FROM t1;
UPDATE /*+ SET_VAR(time_zone = 'UTC') */ t1 SET f1 = TIMEDIFF(NOW(), UTC_TIMESTAMP);
SELECT * FROM t1;
INSERT /*+ SET_VAR(time_zone = 'UTC') */ t1 VALUES (TIMEDIFF(NOW(), UTC_TIMESTAMP));
SELECT * FROM t1;
DELETE /*+ SET_VAR(time_zone = 'UTC') */ FROM t1 WHERE f1 = TIMEDIFF(NOW(), UTC_TIMESTAMP);
SELECT * FROM t1;
SELECT @@time_zone;
DROP TABLE t1;
CREATE TABLE t(c1 int);
DROP TABLE t;
