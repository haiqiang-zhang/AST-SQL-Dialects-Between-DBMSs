
-- Test have expected differences in count of commit and prepare handlers
-- when run with and without binlog and/or with different binlog formats.
-- Test skips when log_bin is disabled OR binlog_format != ROW.
--source include/have_binlog_format_row.inc

-- Different page sizes gives different query plans
-- results based on default 16k.

--echo -- The results where created without innodb persistent stats.
SET @old_innodb_stats_persistent= @@global.innodb_stats_persistent;
SET @@global.innodb_stats_persistent= 0;

-- Helper statement

create table thread_to_monitor(thread_id int);

insert into thread_to_monitor(thread_id)
  SELECT THREAD_ID FROM performance_schema.threads
    WHERE PROCESSLIST_ID=CONNECTION_ID();

-- This query needs to be in a separate monitoring session,
-- so we do not polute the test session statistics.

let $get_handler_status_counts= SELECT VARIABLE_NAME, VARIABLE_VALUE
  FROM performance_schema.status_by_thread
  WHERE VARIABLE_NAME LIKE 'HANDLER_%' AND VARIABLE_VALUE > 0
    AND THREAD_ID IN (SELECT thread_id from test.thread_to_monitor);


CREATE TABLE t1 (a int PRIMARY KEY, b varchar(128), KEY (b))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 13;

CREATE TABLE t2 (a int PRIMARY KEY AUTO_INCREMENT, b varchar(128))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 13;
INSERT INTO t1 VALUES (1, 'First row, p1');
INSERT INTO t1 VALUES (1, 'First row, duplicate');
INSERT INTO t1 VALUES (0, 'First row, p0'), (2, 'First row, p2'),
                      (3, 'First row, p3'), (4, 'First row, p4');
INSERT INTO t1 VALUES (1 * 13, 'Second row, p0'), (2 * 13, 'Third row, p0'),
                      (3 * 13, 'Fourth row, p0'), (4 * 13, 'Fifth row, p0');
INSERT INTO t2 VALUES (NULL, 'First auto-inc row');
INSERT INTO t2 (b) VALUES ('Second auto-inc row');
INSERT INTO t2 VALUES (10, "First row, p10");
UPDATE t2 SET b = CONCAT(b, ", UPDATED") WHERE a = 10;
CREATE TABLE t3 (a INT, b CHAR(10)) PARTITION BY HASH (a) PARTITIONS 2;
INSERT INTO t3 VALUES (1, "Test 1");
INSERT INTO t3 VALUES (2, "Test 2"), (3, "Test 3"), (4, "Test 4");
INSERT INTO t3 VALUES (6, "Test 6"), (8, "Test 8"), (10, "Test 10");
INSERT INTO t3 VALUES (5, "Test 5"), (7, "Test 7"), (9, "Test 9");
INSERT INTO t3 VALUES (0, "Test 0");
INSERT INTO t3 (a, b) VALUES (1, "Test 1");
INSERT INTO t3 (a, b) VALUES (2, "Test 2"), (3, "Test 3"), (4, "Test 4");
INSERT INTO t3 (a, b) VALUES (6, "Test 6"), (8, "Test 8"), (10, "Test 10");
INSERT INTO t3 (a, b) VALUES (5, "Test 5"), (7, "Test 7"), (9, "Test 9");
INSERT INTO t3 (a, b) VALUES (0, "Test 0");
INSERT INTO t3 (a) VALUES (1);
INSERT INTO t3 (a) VALUES (2), (3), (4);
INSERT INTO t3 (a) VALUES (6), (8), (10);
INSERT INTO t3 (a) VALUES (5), (7), (9);
INSERT INTO t3 (b) VALUES ("Only b 1");
INSERT INTO t3 (b) VALUES ("Only b 2"), ("Only b 3");

SELECT * FROM t3 ORDER BY a, b;
DROP TABLE t3;
CREATE TABLE t3
(a int DEFAULT 10,
 b varchar(64) DEFAULT "Default",
 c varchar(64) DEFAULT "Default",
 d int unsigned DEFAULT 9,
 e varchar(255) DEFAULT "Default-filler.filler.filler.",
 PRIMARY KEY (a,b,c,d))
charset latin1
PARTITION BY RANGE COLUMNS (a, b)
SUBPARTITION BY LINEAR KEY (d, c)
SUBPARTITIONS 4
(PARTITION pNeg VALUES LESS THAN (0, ""),
 PARTITION `p0-9` VALUES LESS THAN (9, MAXVALUE),
 PARTITION p10 VALUES LESS THAN (10, MAXVALUE),
 PARTITION `p11-100` VALUES LESS THAN (99, MAXVALUE));
INSERT INTO t3 () VALUES ();
INSERT IGNORE INTO t3 VALUES (-1, "ZZZzzzz", "yyyYYY", -1, DEFAULT);
INSERT INTO t3 () VALUES (0, "", "", 0, NULL);
INSERT INTO t3 (a) VALUES (1);
INSERT INTO t3 (a, b) VALUES (1, "Part expr fulfilled"),
                             (10, "Part expr fulfilled");
INSERT INTO t3 (d) VALUES (1), (2);
INSERT INTO t3 (c, d) VALUES ("Subpart expr fulfilled", 1);
INSERT INTO t3 (a, b, d) VALUES (10, "Full part, half subpart", 1),
                                (12, "Full part, half subpart", 1),
                                (12, "Full part, half subpart", 2),
                                (12, "Full part, half subpart", 3),
                                (12, "Full part, half subpart", 4),
                                (12, "Full part, half subpart", 0);
INSERT INTO t3 (a, b, c) VALUES (1, "Full part", "Half subpart");
INSERT INTO t3 (a, c, d) VALUES (12, "Half part, full subpart", 1),
                                (12, "Half part, full subpartDefault", 1),
                                (12, "Half part, full subpart Default", 1);
INSERT INTO t3 (b, c, d) VALUES ("Half part", "Full subpart", 1);
INSERT INTO t3 (a, b, c, d) VALUES (1, "Full part", "Full subpart", 1);
DELETE FROM t3 WHERE a = 10 AND b = 'Default' AND c = 'Default' AND D = 9;
INSERT INTO t3 VALUES ();
SELECT * FROM t3;
SELECT d, c FROM t3 PARTITION(`p11-100sp0`);
SELECT d, c FROM t3 PARTITION(`p11-100sp1`);
SELECT d, c FROM t3 PARTITION(`p11-100sp2`);
SELECT d, c FROM t3 PARTITION(`p11-100sp3`);
DELETE FROM t3 WHERE a = 10 AND b = 'Default' AND c = 'Default' AND D = 9;
INSERT INTO t3 VALUES ();
DELETE FROM t3
WHERE a = 10 AND b = "Default" AND c = "Default" AND d = 9;
INSERT INTO t3 (b, d, e) VALUES (DEFAULT, DEFAULT, "All default!");
UPDATE t3
SET e = CONCAT(e, ", updated")
WHERE a = 10 AND b = "Default" AND c = "Default" AND d = 9;
UPDATE t3
SET a = DEFAULT, b = "Not DEFAULT!", e = CONCAT(e, ", updated2")
WHERE a = 10 AND b = "Default" AND c = "Default" AND d = 9;
SELECT * FROM t3
WHERE a = 10 AND b = "Default" AND c = "Default" AND d = 9;
SELECT * FROM t3 PARTITION (p10);

DROP TABLE t3;
SELECT UNIX_TIMESTAMP('2011-01-01 00:00:00') as time_t,
       UNIX_TIMESTAMP('2011-01-01 00:00:00') % 3 as part,
       1234567890 % 3 as part2;
SET sql_mode = 'NO_ENGINE_SUBSTITUTION';
CREATE TABLE t3
(a timestamp DEFAULT 0,
 b char(10),
 PRIMARY KEY (a))
PARTITION BY HASH (UNIX_TIMESTAMP(a)) PARTITIONS 3;
DROP TABLE t3;
CREATE TABLE t3
(a timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 b char(10),
 PRIMARY KEY (a))
PARTITION BY HASH (UNIX_TIMESTAMP(a)) PARTITIONS 3;
DROP TABLE t3;
CREATE TABLE t3
(a timestamp DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
 b char(10),
 PRIMARY KEY (a))
PARTITION BY HASH (UNIX_TIMESTAMP(a)) PARTITIONS 3;
DROP TABLE t3;
CREATE TABLE t3
(a timestamp DEFAULT CURRENT_TIMESTAMP,
 b char(10),
 PRIMARY KEY (a))
PARTITION BY HASH (UNIX_TIMESTAMP(a)) PARTITIONS 3;
DROP TABLE t3;
CREATE TABLE t3
(a DATETIME DEFAULT 0,
 b char(10),
 PRIMARY KEY (a))
PARTITION BY KEY (a) PARTITIONS 3;
DROP TABLE t3;
CREATE TABLE t3
(a DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
 b char(10),
 PRIMARY KEY (a))
PARTITION BY KEY (a) PARTITIONS 3;
DROP TABLE t3;
CREATE TABLE t3
(a DATETIME DEFAULT 0 ON UPDATE CURRENT_TIMESTAMP,
 b char(10),
 PRIMARY KEY (a))
PARTITION BY KEY (a) PARTITIONS 3;
DROP TABLE t3;
CREATE TABLE t3
(a DATETIME DEFAULT CURRENT_TIMESTAMP,
 b char(10),
 PRIMARY KEY (a))
PARTITION BY KEY (a) PARTITIONS 3;
DROP TABLE t3;
SET sql_mode = default;
INSERT INTO t2 SELECT a, b FROM t1 WHERE a IN (1,4);
ALTER TABLE t2 TRUNCATE PARTITION p1;
INSERT INTO t2 SELECT a, b FROM t1 WHERE a = 1;
INSERT INTO t1 VALUES (65, "No duplicate")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", INSERT_DUP_KEY_UPDATE");
INSERT INTO t1 VALUES (65, "No duplicate")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", INSERT_DUP_KEY_UPDATE");
INSERT INTO t1 VALUES (78, "No duplicate")
ON DUPLICATE KEY UPDATE a = a + 13, b = CONCAT(b, ", INSERT_DUP_KEY_UPDATE");
INSERT INTO t1 VALUES (78, "No duplicate")
ON DUPLICATE KEY UPDATE a = a + 13, b = CONCAT(b, ", INSERT_DUP_KEY_UPDATE");
INSERT INTO t1 VALUES (78, "No duplicate")
ON DUPLICATE KEY UPDATE a = a + 13,
                        b = CONCAT(b, ", INSERT_DUP_KEY_UPDATE third");
INSERT INTO t1 VALUES (78, "No duplicate")
ON DUPLICATE KEY UPDATE a = a + 13,
                        b = CONCAT(b, ", INSERT_DUP_KEY_UPDATE fail?");
INSERT INTO t1 VALUES (104, "No duplicate")
ON DUPLICATE KEY UPDATE a = a + 1;
INSERT INTO t1 VALUES (104, "No duplicate")
ON DUPLICATE KEY UPDATE a = a + 1;
INSERT INTO t1 VALUES (104, "No duplicate 104")
ON DUPLICATE KEY UPDATE a = a + 1;
INSERT INTO t1 VALUES (104, "No duplicate 104 + 1")
ON DUPLICATE KEY UPDATE a = a + 1;
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t1 WHERE a IN (0, 1, 4, 13, 26) ORDER BY a;
SELECT * FROM t1 WHERE a IN (13, 26, 39, 52);
SELECT * FROM t1 WHERE a = 3;
SELECT * FROM t1 WHERE b LIKE 'First%' ORDER BY a;
CREATE TABLE t3 (a INT);
INSERT INTO t3 VALUES (1);
SELECT * FROM t1 WHERE a = (SELECT a FROM t3);
SELECT t1.a FROM t1 INNER JOIN t3 ON t1.a = t3.a;
SELECT * FROM t1 WHERE a = 1;
SELECT * FROM t1 WHERE a = (SELECT COUNT(*) FROM t3);
CREATE TABLE t4 SELECT a, b FROM t1;
ALTER TABLE t4 PARTITION BY HASH (a) PARTITIONS 5;
SELECT * FROM t4 WHERE a = (SELECT a FROM t3);

INSERT INTO t3 VALUES (3);
SELECT * FROM t4 WHERE a = (SELECT a FROM t3);
DROP TABLE t3;
DROP TABLE t4;
set @optimizer_switch_saved=@@optimizer_switch;
set optimizer_switch='derived_merge=off';
SELECT * FROM (SELECT * FROM t1 WHERE a IN (0,2,3,13,26)) t3;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0,2,3,13,26)) t3) t4;
SELECT * FROM t1 UNION SELECT * FROM t2;
SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26) UNION SELECT * FROM t2;
SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26)) t3 UNION SELECT * FROM t2;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26) UNION SELECT * FROM t2) t3) t4;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26)) t3 UNION SELECT * FROM t2) t4;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26)) t3) t4 UNION SELECT * FROM t2;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26)) t3 UNION SELECT * FROM t2 WHERE a = 1) t4;


set @@optimizer_switch=@optimizer_switch_saved;
SELECT * FROM t1 ORDER BY a;
UPDATE t1 SET b = CONCAT(b, ", updated 1") WHERE a IN (13, 26, 39, 52);
UPDATE t1 SET a = 99, b = CONCAT(b, ", updated 2 -> p8") WHERE a = 13;
UPDATE t1 SET a = 13 + 99, b = CONCAT(b, ", updated 3") WHERE a = 99;
UPDATE t1 SET a = a + 1, b = CONCAT(b, ", updated 4 -> p9") WHERE a = 112;
UPDATE t1 SET b = CONCAT(b, ", same as min(a) + 2 in t2") WHERE a = (SELECT MIN(a) + 2 FROM t2);
UPDATE t1 SET b = CONCAT(b, ", max(a) in t2: ", (SELECT MAX(a) FROM t2)) WHERE a = 5;
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
SET t1.b = CONCAT(t1.b, ", t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ", t1.b:", t1.b)
WHERE t2.b = t1.b and t2.a = 4;
SET t1.b = CONCAT(t1.b, ", t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ", t1.b:", t1.b)
WHERE t2.b = t1.b and t2.a = 4;
UPDATE t1, t2
SET t1.b = CONCAT(t1.b, ", t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ", t1.b:", t1.b)
WHERE t2.b = t1.b and t2.a = 4;
CREATE VIEW v1_25 AS SELECT a, b FROM t1 PARTITION (p2, p5);
CREATE VIEW v1_25_check AS SELECT a, b FROM t1 PARTITION (p2, p5) t1_alias WITH CHECK OPTION;
CREATE VIEW v1_9 AS SELECT a, b FROM t1 WHERE a = 9;
CREATE VIEW v1_9_check AS SELECT a, b FROM t1 WHERE a = 9 WITH CHECK OPTION;
CREATE VIEW v1_all AS SELECT a, b FROM t1;
SELECT TABLE_NAME, CHECK_OPTION, IS_UPDATABLE, VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_SCHEMA = 'test' AND TABLE_NAME LIKE 'v1_%';
INSERT INTO v1_all VALUES (23, "Insert in v1_all");
INSERT INTO v1_25 VALUES (18, "Insert in v1_25");
INSERT INTO v1_25 VALUES (17, "Insert in v1_25 fail");
INSERT IGNORE INTO v1_25 VALUES (17, "Insert ignore in v1_25");
INSERT INTO v1_25_check VALUES (31, "Insert in v1_25_check");
INSERT INTO v1_25_check VALUES (30, "Insert in v1_25_check fail");
INSERT IGNORE INTO v1_25_check VALUES (30, "Insert ignore in v1_25_check");
INSERT INTO v1_9 VALUES (9, "Insert in v1_9");
INSERT INTO v1_9 VALUES (8, "Insert in v1_9 NO CHECK!");


SELECT * FROM t1 WHERE a = 8;
DELETE FROM v1_9_check WHERE a = 8;
SELECT * FROM t1 WHERE a = 8;
INSERT INTO v1_9_check VALUES (10, "Insert in v1_9_check fail");


SELECT * FROM t1 WHERE a = 9;
DELETE FROM v1_9_check WHERE a = 9;
INSERT INTO v1_9_check VALUES (9, "Insert in v1_9_check");
SELECT * FROM v1_9;
SELECT * FROM v1_25;
SELECT * FROM v1_all;

DROP VIEW v1_all;
DROP VIEW v1_9, v1_9_check;
DROP VIEW v1_25, v1_25_check;

-- CREATE SELECT result in different values for HANDLER_COMMIT,
-- HANDLER_READ_KEY and HANDLER_EXTERNAL_LOCK when run --ps option.
--disable_ps_protocol
--echo --
--echo -- Test CREATE SELECT
--echo --
FLUSH STATUS;
CREATE TABLE t3 SELECT a, b FROM t1 WHERE a IN (0, 1, 13, 113, 26);

SELECT * FROM t3 ORDER BY a;
DROP TABLE t3;
CREATE TABLE t3 SELECT a, b FROM t1 WHERE b LIKE 'First%';

SELECT * FROM t3 ORDER BY a;
DROP TABLE t3;
CREATE PROCEDURE sp_insert(a INT, b CHAR(16))
  INSERT INTO test.t1 VALUES (a, b);
CREATE PROCEDURE sp_insert_partition(p CHAR(16), a INT, b CHAR(16))
BEGIN
  SET @str = CONCAT("INSERT INTO test.t1 PARTITION(", p, ") VALUES (?, ?)");
  SET @x = a, @y = b;

CREATE PROCEDURE sp_select_all()
  SELECT * FROM test.t1;

CREATE PROCEDURE sp_select_exact(x INT)
  SELECT * FROM test.t1 WHERE a = x;
CREATE PROCEDURE sp_select_partition(p CHAR(16))
BEGIN
  SET @str = CONCAT("SELECT * FROM test.t1 PARTITION(", p, ")");

CREATE PROCEDURE sp_select_range(x INT, y INT)
  SELECT * FROM test.t1 WHERE a between x and y;

DROP PROCEDURE sp_insert;
DROP PROCEDURE sp_insert_partition;
DROP PROCEDURE sp_select_all;
DROP PROCEDURE sp_select_partition;
DROP PROCEDURE sp_select_range;
DROP PROCEDURE sp_select_exact;
SELECT * FROM t1 ORDER BY a;
DELETE FROM t1 WHERE a = 105;
DELETE FROM t1 WHERE b = "No duplicate";
DELETE FROM t1 WHERE a = (SELECT a + 90 FROM t2 WHERE a = 1);
DELETE FROM t1 PARTITION (p0)
WHERE a = (SELECT a + 2 FROM t2 WHERE a = 1);
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
DELETE t1, t2 FROM t1, t2
WHERE t1.a = t2.a AND t1.b = 'First row, p1';
DELETE FROM t2, t1 USING t2, t1
WHERE t1.b = t2.b AND t2.a = 4;


SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
CREATE TABLE t3
(old_a int,
 new_a int,
 old_b varchar(255),
 new_b varchar(255),
 key (new_a, new_b),
 key(new_b))
PARTITION BY HASH (new_a) PARTITIONS 5;

CREATE TRIGGER t1_after_insert AFTER INSERT
ON t1 FOR EACH ROW
INSERT INTO t3 VALUES (2, NEW.a, NULL, CONCAT("AI: ", NEW.b));

CREATE TRIGGER t1_after_update AFTER UPDATE
ON t1 FOR EACH ROW
INSERT INTO t3 VALUES (OLD.a, NEW.a, CONCAT("AU: ", OLD.b), CONCAT("AU: ", NEW.b));
INSERT INTO t1 VALUES (2, "First row, p2")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", duplicate key 2");
SELECT * FROM t1 WHERE a = 2;
SELECT * FROM t1 WHERE a = 0;

CREATE TRIGGER t1_after_delete AFTER DELETE
ON t1 FOR EACH ROW
INSERT INTO t3 VALUES (OLD.a, NULL, CONCAT("AD: ", OLD.b), NULL);
SELECT * FROM t1 WHERE a = 0;

CREATE TRIGGER t1_before_delete BEFORE DELETE
ON t1 FOR EACH ROW
INSERT INTO t3 VALUES (OLD.a, NULL, CONCAT("BD: ", OLD.b), NULL);
SELECT * FROM t1 WHERE a = 0;

CREATE TRIGGER t1_before_update BEFORE UPDATE
ON t1 FOR EACH ROW
INSERT INTO t3 VALUES (OLD.a, NEW.a, CONCAT("BU: ", OLD.b), CONCAT("BU: ", NEW.b));
INSERT INTO t1 VALUES (2, "First row, p2")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", duplicate key 2");
SELECT * FROM t1 WHERE a = 2;
SELECT * FROM t1 WHERE a = 0;
SELECT * FROM t1 WHERE a = 3;
UPDATE t1 SET b = CONCAT(b, ", UPDATED2") WHERE a = 3;
SELECT * FROM t1 WHERE a = 3;
INSERT INTO t1 VALUES (12, "First row, p12");

CREATE TRIGGER t1_before_insert BEFORE INSERT
ON t1 FOR EACH ROW
INSERT INTO t3 VALUES (1, NEW.a, NULL, CONCAT("BI: ", NEW.b));
INSERT INTO t1 VALUES (11, "First row, p11");
SELECT * FROM t1 ORDER BY a;
DELETE FROM t1 WHERE a = 98;

SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
SELECT * FROM t3 ORDER BY new_a;

DROP TRIGGER t1_before_insert;
DROP TRIGGER t1_before_update;
DROP TRIGGER t1_before_delete;
DROP TRIGGER t1_after_insert;
DROP TRIGGER t1_after_update;
DROP TRIGGER t1_after_delete;
CREATE TRIGGER t1_before_insert BEFORE INSERT
ON t1 FOR EACH ROW
SET NEW.b = CONCAT("b: ", NEW.b, " a: ", NEW.a);
INSERT INTO t1 VALUES (0, "first row, p0");
INSERT INTO t1 VALUES (0, "Second row, p0")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", duplicate key");
UPDATE t1 SET b = CONCAT(b, ", Updated") WHERE a = 0;
UPDATE t1 SET a = 1, b = CONCAT(b, ", a was 0") WHERE a = 0;
DROP TRIGGER t1_before_insert;

CREATE TRIGGER t1_before_insert BEFORE INSERT
ON t1 FOR EACH ROW
SET NEW.b = CONCAT("b: ", NEW.b);
INSERT INTO t1 VALUES (0, "first row, p0");
INSERT INTO t1 VALUES (0, "Second row, p0")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", duplicate key");
UPDATE t1 SET b = CONCAT(b, ", Updated") WHERE a = 0;
UPDATE t1 SET a = 2, b = CONCAT(b, ", a was 0") WHERE a = 0;
CREATE TRIGGER t1_before_update BEFORE UPDATE
ON t1 FOR EACH ROW
SET NEW.b = CONCAT("old a: ", OLD.a, " new b: ", NEW.b);
INSERT INTO t1 VALUES (0, "1st p0");
INSERT INTO t1 VALUES (0, "2nd p0")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", dup key");
UPDATE t1 SET b = CONCAT(b, ", Updated") WHERE a = 0;
UPDATE t1 SET a = 3, b = CONCAT(b, ", a was 0") WHERE a = 0;
DROP TRIGGER t1_before_update;

CREATE TRIGGER t1_before_update BEFORE UPDATE
ON t1 FOR EACH ROW
SET NEW.b = CONCAT("new a: ", NEW.a, " new b: ", NEW.b);
INSERT INTO t1 VALUES (0, "1st p0");
INSERT INTO t1 VALUES (0, "2nd p0")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", dup key");
UPDATE t1 SET b = CONCAT(b, ", Updated") WHERE a = 0;
UPDATE t1 SET a = 4, b = CONCAT(b, ", a was 0") WHERE a = 0;
DROP TRIGGER t1_before_update;

CREATE TRIGGER t1_before_update BEFORE UPDATE
ON t1 FOR EACH ROW
SET NEW.b = CONCAT("new b: ", NEW.b);
INSERT INTO t1 VALUES (0, "1st p0");
INSERT INTO t1 VALUES (0, "2nd p0")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", dup key");
UPDATE t1 SET b = CONCAT(b, ", Updated") WHERE a = 0;
UPDATE t1 SET a = 5, b = CONCAT(b, ", a was 0") WHERE a = 0;

SELECT * FROM t1 ORDER BY a;

DROP TABLE t1, t2, t3;
CREATE TABLE t1 (a int, b varchar(128), KEY (b))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 13;

CREATE TABLE t2 (a int PRIMARY KEY, b varchar(128))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 13;

INSERT INTO t1 VALUES (1, "MultiUpdate1");
INSERT INTO t1 VALUES (2, "MultiUpdate2");
INSERT INTO t2 VALUES (1, "MultiUpdate1");
INSERT INTO t2 VALUES (2, "MultiUpdate2");

CREATE TRIGGER t1_before_update BEFORE UPDATE
ON t1 FOR EACH ROW
SET NEW.b = CONCAT("new1 b: ", NEW.b);

CREATE TRIGGER t2_before_update BEFORE UPDATE
ON t2 FOR EACH ROW
SET NEW.b = CONCAT("new2 a: ", NEW.a, " new2 b: ", NEW.b);
SET t1.b = CONCAT(t1.b, ",(1) t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ",(1) t1.b:", t1.b)
WHERE t2.b = t1.b and t1.a = 1;
SET t1.b = CONCAT(t1.b, ",(1) t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ",(1) t1.b:", t1.b)
WHERE t2.b = t1.b and t1.a = 1;
UPDATE t1, t2
SET t1.b = CONCAT(t1.b, ",(1) t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ",(1) t1.b:", t1.b)
WHERE t2.b = t1.b and t1.a = 1;
SET t1.b = CONCAT(t1.b, ",(2) t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ",(2) t1.b:", t1.b)
WHERE t1.b = t2.b and t2.a = 2;
SET t1.b = CONCAT(t1.b, ",(2) t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ",(2) t1.b:", t1.b)
WHERE t1.b = t2.b and t2.a = 2;
UPDATE t1, t2
SET t1.b = CONCAT(t1.b, ",(2) t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ",(2) t1.b:", t1.b)
WHERE t1.b = t2.b and t2.a = 2;

SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
DROP TABLE t1, t2;
CREATE TABLE t1 (a int, b varchar(128), KEY (b))
ENGINE = InnoDB
PARTITION BY RANGE (a)
(PARTITION pNeg VALUES LESS THAN (0),
 PARTITION p0 VALUES LESS THAN (1),
 PARTITION p1 VALUES LESS THAN (2),
 PARTITION p2 VALUES LESS THAN (3),
 PARTITION p3 VALUES LESS THAN (4),
 PARTITION pMax VALUES LESS THAN MAXVALUE);

CREATE TABLE t2 (a int PRIMARY KEY, b varchar(128))
ENGINE = InnoDB
PARTITION BY RANGE (a)
(PARTITION pNeg VALUES LESS THAN (0),
 PARTITION p0 VALUES LESS THAN (1),
 PARTITION p1 VALUES LESS THAN (2),
 PARTITION p2 VALUES LESS THAN (3),
 PARTITION p3 VALUES LESS THAN (4),
 PARTITION pMax VALUES LESS THAN MAXVALUE);

INSERT INTO t1 VALUES (1, "Const1");
INSERT INTO t2 VALUES (1, "Const1");
INSERT INTO t1 VALUES (2, "Const2");
INSERT INTO t2 VALUES (2, "Const2");
INSERT INTO t1 VALUES (3, "Const3");
INSERT INTO t2 VALUES (3, "Const3");
SELECT * FROM t1, t2
WHERE t1.a = t2.a AND t2.a = 1;
SELECT * FROM t1, t2
WHERE t1.a = t2.a AND t1.a = 1;
SELECT * FROM t1, t2
WHERE t1.a = t2.a AND (t2.a = 1 OR t2.a = 2);
SELECT * FROM t1, t2
WHERE t1.a = t2.a AND t1.a >= 1 AND t1.a <=3;
SELECT * FROM t1, t2
WHERE t1.a = t2.a AND t2.a >= 1;
SELECT * FROM t1, t2
WHERE t1.a = t2.a AND t2.a <= 1;
SELECT * FROM t1, t2
WHERE t1.a = t2.a and t2.a IN (1, 3);
UPDATE t1, t2
SET t1.b = CONCAT(t1.b, ", t2.b:", t2.b)
WHERE t1.a = t2.a and t2.a IN (2, 3);
SET t1.b = CONCAT(t1.b, ", t2.b:", t2.b)
WHERE t1.a = t2.a and t2.a IN (2, 3);
UPDATE t1, t2
SET t1.b = CONCAT(t1.b, ", t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ", t1.b:", t1.b)
WHERE t1.a = t2.a and t2.a = 1;
UPDATE t1, t2
SET t1.b = CONCAT(t1.b, ", t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ", t1.b:", t1.b)
WHERE t1.a = t2.a and t1.a = 2;


SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
DELETE t1 FROM t1, t2
WHERE t1.a = t2.a AND t2.a IN (1, 9);

SELECT * FROM t1 ORDER BY a;
DELETE t1 FROM t1, t2
WHERE t1.a = t2.a and t2.a = 2;
DELETE t1 FROM t1, t2
WHERE t1.a = t2.a and t1.a = 1;


SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
DELETE t1, t2 FROM t1, t2
WHERE t1.a = t2.a and t2.a = 3;


SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT, b VARCHAR(66))
PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (1, "One"), (2, "Two"), (3, "Three"), (4, "Four"), (5, "Five"), (6, "Six"), (0, "Zero");

SELECT @x;

SELECT @x;
SET @x = (SELECT a FROM t1 WHERE a = 5);

SELECT @x;
SET @y = (SELECT @x:= b FROM t1 WHERE a = 5);

SELECT @x, @y;
SET @y = (SELECT @x:= b FROM t1 WHERE a = 5 or a = 1 ORDER BY b LIMIT 1);

SELECT @x, @y;

DELETE FROM t1 WHERE a IN (1, 4);
SELECT * FROM t1 ORDER BY a, b;

SELECT * FROM t1 ORDER BY a, b;
DELETE FROM t1 WHERE a IN (1, 4);
SELECT * FROM t1 ORDER BY a, b;

SELECT * FROM t1 ORDER BY a, b;

DROP TABLE t1;
CREATE TABLE t1 (a INT, b VARCHAR(44));
CREATE TABLE t2 (a INT, b VARCHAR(44))
PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (10, "Ten"), (13, "Thirteen"), (16, "Sixteen");
INSERT INTO t2 VALUES (0, "Zero"), (1, "One"), (2, "Two"),
                      (3, "Three"), (4, "Four"), (5, "Five"),
                      (6, "Six"), (7, "Seven"), (8, "Eight");
ALTER TABLE t2 EXCHANGE PARTITION p1 WITH TABLE t1;

SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
DROP TABLE t1, t2;
CREATE TABLE t1 (N int, M tinyint)
PARTITION BY HASH (N) PARTITIONS 3;
INSERT INTO t1 VALUES (1,0),(1,0),(2,0),(2,0),(3,0);

SELECT * FROM t1 ORDER BY N, M;

DROP TABLE t1;
CREATE TABLE t1 ( a int NOT NULL) PARTITION BY HASH(a) PARTITIONS 2;
INSERT INTO t1 VALUES (1),(2),(3);
SELECT * FROM t1 WHERE a=5 AND a=6;

DROP TABLE t1;
CREATE TABLE t1 (a INT, b VARCHAR(64));
CREATE TABLE t2 (a INT, b VARCHAR(64)) PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (1, "test 1");
INSERT INTO t2 VALUES (SELECT * FROM t1);
INSERT INTO t2 VALUES ((SELECT a FROM t1), (SELECT b FROM t1));
INSERT INTO t2 VALUES (1 + (SELECT a FROM t1),
                       CONCAT("subq: ", (SELECT b FROM t1)));
SELECT * FROM t2;
DROP TABLE t1, t2;
CREATE TABLE t1 (a INT, b INT) PARTITION BY HASH (a) PARTITIONS 3;
CREATE TABLE t2 (a INT, b INT) PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (1, 1), (2, 0), (4, -1), (5, 2), (7, -3), (8, -9),
                      (10, 5), (11, 9);
INSERT INTO t2 VALUES ((SELECT max(a) FROM t1), (SELECT min(a) FROM t1));
                                          (SELECT min(a) FROM t1));
INSERT INTO t2 VALUES ((SELECT a FROM t1 WHERE a = 1),
                       (SELECT b FROM t1 WHERE a = 2));
                                          (SELECT b FROM t1 WHERE a = 2));
SELECT * FROM t2 ORDER BY a, b;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (a INT)
ENGINE = InnoDB;
CREATE TABLE t2 (a INT)
ENGINE = InnoDB;
CREATE TRIGGER tr1_1_N  BEFORE INSERT ON t1
FOR EACH ROW BEGIN
  UPDATE t2 SET a = 8 WHERE a > 3 LIMIT 0;
DROP TABLE t2;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;

-- CREATE SELECT result in different values for HANDLER_COMMIT,
-- HANDLER_READ_KEY and HANDLER_EXTERNAL_LOCK when run --ps option.
--disable_ps_protocol
CREATE TABLE t1 (a INT) PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (1), (3), (9), (2), (8), (7);
CREATE TABLE t2 SELECT * FROM t1 PARTITION (p1, p2);
SELECT * FROM t2;
DROP TABLE t2;
CREATE TABLE t2 SELECT * FROM t1 WHERE a IN (1, 3, 9);
SELECT * FROM t2;

DROP TABLE t1, t2;
CREATE TABLE tq (id int PRIMARY KEY auto_increment, query varchar(255), not_select tinyint);
CREATE TABLE tsq (id int PRIMARY KEY auto_increment, subquery varchar(255), can_be_locked tinyint);
CREATE TABLE t1 (a int, b varchar(255), PRIMARY KEY (a), KEY (b))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 3;
CREATE TABLE t2 (a int, b varchar(255), PRIMARY KEY (a), KEY (b))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (1, "1");
INSERT INTO t1 VALUES (2, "2");
INSERT INTO t1 VALUES (8, "8");
INSERT INTO t2 VALUES (1, "1");
INSERT INTO t2 VALUES (2, "2");
INSERT INTO t2 VALUES (8, "8");

CREATE FUNCTION sf_add_hello(s VARCHAR(240))
  RETURNS VARCHAR(246) DETERMINISTIC
  RETURN CONCAT('hello ', s);
CREATE FUNCTION sf_add_1(i INT)
  RETURNS INT DETERMINISTIC
  RETURN i + 1;
CREATE FUNCTION sf_a_from_t1b_d(s varchar(128))
  RETURNS INT DETERMINISTIC
  BEGIN
  DECLARE i INT;
    SELECT a INTO i FROM t1 where b = s;
    RETURN i;
CREATE FUNCTION sf_a_from_t1b(s varchar(128))
  RETURNS INT
  BEGIN
  DECLARE i INT;
    SELECT a INTO i FROM t1 where b = s;
    RETURN i;

INSERT INTO tq (query, not_select) VALUES
  ("SELECT * FROM t2", 0),
  ("SELECT sf_add_1(a) - 1, sf_add_hello(b) FROM t2", 0),
  ("UPDATE t2 SET b = CONCAT('+', b)", 1),
  ("UPDATE t2 SET b = sf_add_hello(b)", 1),
  ("UPDATE t2 SET a = sf_add_1(a) + 4", 1),
  ("DELETE FROM t2", 1);
INSERT INTO tsq (subquery, can_be_locked) VALUES
  ("(SELECT a FROM t1 WHERE b = '1')", 1),
  ("7 + (SELECT a FROM t1 WHERE b = '1')", 1),
  ("sf_a_from_t1b('1')", 1),
  ("sf_a_from_t1b_d('1')", 1),
  ("7 + sf_a_from_t1b('1')", 1),
  ("7 + sf_a_from_t1b_d('1')", 1),
  ("sf_a_from_t1b('1') AND a = 2", 1),
  ("sf_a_from_t1b_d('1') AND a = 2", 1),
  ("(SELECT a FROM t1 WHERE b = '1') AND a = 2", 1),
  ("(SELECT a FROM t1 WHERE b = '1') OR a = 2", 1),
  ("(SELECT a FROM t1 WHERE b = '1') AND a = 2 OR a = 8 AND sf_a_from_t1b('2')", 0);

set @old_autocommit= @@autocommit;
let $subnr= 1;
let $qnr= 1;

let $query = `SELECT query FROM tq WHERE id = $qnr`;
let $not_select = `SELECT not_select FROM tq WHERE id = $qnr`;
let $subq = `SELECT subquery FROM tsq WHERE id = $subnr`;
let $can_be_locked = `SELECT can_be_locked FROM tsq WHERE id = $subnr`;
{
  while ($subq != '')
  {
    --replace_column 10 --
    eval EXPLAIN $query WHERE a = $subq;
    FLUSH STATUS;
    START TRANSACTION;
    eval $query WHERE a = $subq;
    --source include/get_handler_status_counts.inc
connection default;

    if ($not_select)
    {
      --sorted_result
      SELECT * FROM t2;
      ROLLBACK;
    }
    if ($can_be_locked)
    {
      FLUSH STATUS;
      -- Cannot use START TRANSACTION with LOCK TABLES
      SET autocommit = 0;
      LOCK TABLES t1 read, t2 write;
      eval $query WHERE a = $subq;
      --source include/get_handler_status_counts.inc
connection default;

      if ($not_select)
      {
        --sorted_result
        SELECT * FROM t2;
        ROLLBACK;
      }
      UNLOCK TABLES;
    }
    inc $subnr;
    let $subq = `SELECT subquery FROM tsq WHERE id = $subnr`;
    let $can_be_locked = `SELECT can_be_locked FROM tsq WHERE id = $subnr`;
  }
  let $subnr= 1;
  let $subq = `SELECT subquery FROM tsq WHERE id = $subnr`;
  let $can_be_locked = `SELECT can_be_locked FROM tsq WHERE id = $subnr`;
  inc $qnr;
  let $query = `SELECT query FROM tq WHERE id = $qnr`;
  let $not_select = `SELECT not_select FROM tq WHERE id = $qnr`;

set @@autocommit= @old_autocommit;
DROP FUNCTION sf_add_hello;
DROP FUNCTION sf_add_1;
DROP FUNCTION sf_a_from_t1b_d;
DROP FUNCTION sf_a_from_t1b;

DROP TABLE tq, tsq, t1, t2;

DROP TABLE test.thread_to_monitor;

SET @@global.innodb_stats_persistent= @old_innodb_stats_persistent;
