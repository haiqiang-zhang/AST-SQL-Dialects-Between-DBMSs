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
LOCK TABLES t3 WRITE;
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
UNLOCK TABLES;
DROP TABLE t3;
SELECT UNIX_TIMESTAMP('2011-01-01 00:00:00') as time_t,
       UNIX_TIMESTAMP('2011-01-01 00:00:00') % 3 as part,
       1234567890 % 3 as part2;
CREATE TABLE t3
(a timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
(a DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
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
INSERT INTO t1 VALUES (104, "No duplicate")
ON DUPLICATE KEY UPDATE a = a + 1;
INSERT INTO t1 VALUES (104, "No duplicate")
ON DUPLICATE KEY UPDATE a = a + 1;
INSERT INTO t1 VALUES (104, "No duplicate 104")
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
DROP TABLE t3;
DROP TABLE t4;
SELECT * FROM (SELECT * FROM t1 WHERE a IN (0,2,3,13,26)) t3;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0,2,3,13,26)) t3) t4;
SELECT * FROM t1 UNION SELECT * FROM t2;
SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26) UNION SELECT * FROM t2;
SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26)) t3 UNION SELECT * FROM t2;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26) UNION SELECT * FROM t2) t3) t4;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26)) t3 UNION SELECT * FROM t2) t4;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26)) t3) t4 UNION SELECT * FROM t2;
SELECT * FROM (SELECT * FROM (SELECT * FROM t1 WHERE a IN (0, 1, 13, 4, 26)) t3 UNION SELECT * FROM t2 WHERE a = 1) t4;
SELECT * FROM t1 ORDER BY a;
UPDATE t1 SET b = CONCAT(b, ", updated 1") WHERE a IN (13, 26, 39, 52);
UPDATE t1 SET a = 99, b = CONCAT(b, ", updated 2 -> p8") WHERE a = 13;
UPDATE t1 SET a = 13 + 99, b = CONCAT(b, ", updated 3") WHERE a = 99;
UPDATE t1 SET a = a + 1, b = CONCAT(b, ", updated 4 -> p9") WHERE a = 112;
UPDATE t1 SET b = CONCAT(b, ", same as min(a) + 2 in t2") WHERE a = (SELECT MIN(a) + 2 FROM t2);
UPDATE t1 SET b = CONCAT(b, ", max(a) in t2: ", (SELECT MAX(a) FROM t2)) WHERE a = 5;
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
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
INSERT IGNORE INTO v1_25 VALUES (17, "Insert ignore in v1_25");
INSERT INTO v1_25_check VALUES (31, "Insert in v1_25_check");
INSERT IGNORE INTO v1_25_check VALUES (30, "Insert ignore in v1_25_check");
INSERT INTO v1_9 VALUES (9, "Insert in v1_9");
INSERT INTO v1_9 VALUES (8, "Insert in v1_9 NO CHECK!");
SELECT * FROM t1 WHERE a = 8;
DELETE FROM v1_9_check WHERE a = 8;
SELECT * FROM t1 WHERE a = 8;
SELECT * FROM t1 WHERE a = 9;
DELETE FROM v1_9_check WHERE a = 9;
INSERT INTO v1_9_check VALUES (9, "Insert in v1_9_check");
SELECT * FROM v1_9;
SELECT * FROM v1_25;
SELECT * FROM v1_all;
DROP VIEW v1_all;
DROP VIEW v1_9, v1_9_check;
DROP VIEW v1_25, v1_25_check;
CREATE TABLE t3 SELECT a, b FROM t1 WHERE a IN (0, 1, 13, 113, 26);
SELECT * FROM t3 ORDER BY a;
DROP TABLE t3;
CREATE TABLE t3 SELECT a, b FROM t1 WHERE b LIKE 'First%';
SELECT * FROM t3 ORDER BY a;
DROP TABLE t3;
CREATE PROCEDURE sp_insert(a INT, b CHAR(16))
  INSERT INTO test.t1 VALUES (a, b);
CREATE PROCEDURE sp_select_all()
  SELECT * FROM test.t1;
CREATE PROCEDURE sp_select_exact(x INT)
  SELECT * FROM test.t1 WHERE a = x;
CREATE PROCEDURE sp_select_range(x INT, y INT)
  SELECT * FROM test.t1 WHERE a between x and y;
DROP PROCEDURE sp_insert;
DROP PROCEDURE sp_select_all;
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
INSERT INTO t1 VALUES (2, "First row, p2")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", duplicate key 2");
SELECT * FROM t1 WHERE a = 2;
SELECT * FROM t1 WHERE a = 0;
SELECT * FROM t1 WHERE a = 0;
SELECT * FROM t1 WHERE a = 0;
INSERT INTO t1 VALUES (2, "First row, p2")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", duplicate key 2");
SELECT * FROM t1 WHERE a = 2;
SELECT * FROM t1 WHERE a = 0;
SELECT * FROM t1 WHERE a = 3;
UPDATE t1 SET b = CONCAT(b, ", UPDATED2") WHERE a = 3;
SELECT * FROM t1 WHERE a = 3;
INSERT INTO t1 VALUES (12, "First row, p12");
INSERT INTO t1 VALUES (11, "First row, p11");
SELECT * FROM t1 ORDER BY a;
DELETE FROM t1 WHERE a = 98;
SELECT * FROM t1 ORDER BY a;
SELECT * FROM t2 ORDER BY a;
SELECT * FROM t3 ORDER BY new_a;
INSERT INTO t1 VALUES (0, "Second row, p0")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", duplicate key");
UPDATE t1 SET b = CONCAT(b, ", Updated") WHERE a = 0;
UPDATE t1 SET a = 1, b = CONCAT(b, ", a was 0") WHERE a = 0;
INSERT INTO t1 VALUES (0, "first row, p0");
INSERT INTO t1 VALUES (0, "Second row, p0")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", duplicate key");
UPDATE t1 SET b = CONCAT(b, ", Updated") WHERE a = 0;
INSERT INTO t1 VALUES (0, "2nd p0")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", dup key");
UPDATE t1 SET b = CONCAT(b, ", Updated") WHERE a = 0;
INSERT INTO t1 VALUES (0, "2nd p0")
ON DUPLICATE KEY UPDATE b = CONCAT(b, ", dup key");
UPDATE t1 SET b = CONCAT(b, ", Updated") WHERE a = 0;
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
UPDATE t1, t2
SET t1.b = CONCAT(t1.b, ",(1) t2.b:", t2.b),
    t2.b = CONCAT(t2.b, ",(1) t1.b:", t1.b)
WHERE t2.b = t1.b and t1.a = 1;
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
SELECT @x;
SELECT @x, @y;
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
PREPARE stmt FROM 'UPDATE t1 AS P1 INNER JOIN (SELECT N FROM t1 GROUP BY N HAVING COUNT(M) > 1) AS P2 ON P1.N = P2.N SET P1.M = 2';
SELECT * FROM t1 ORDER BY N, M;
DEALLOCATE PREPARE stmt;
PREPARE stmt FROM 'SELECT * FROM t1 WHERE N = 2';
DROP TABLE t1;
CREATE TABLE t1 ( a int NOT NULL) PARTITION BY HASH(a) PARTITIONS 2;
INSERT INTO t1 VALUES (1),(2),(3);
SELECT * FROM t1 WHERE a=5 AND a=6;
DROP TABLE t1;
CREATE TABLE t1 (a INT, b VARCHAR(64));
CREATE TABLE t2 (a INT, b VARCHAR(64)) PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (1, "test 1");
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
INSERT INTO t2 VALUES ((SELECT a FROM t1 WHERE a = 1),
                       (SELECT b FROM t1 WHERE a = 2));
SELECT * FROM t2 ORDER BY a, b;
DROP TABLE t1;
DROP TABLE t2;
CREATE TABLE t1 (a INT)
ENGINE = InnoDB;
CREATE TABLE t2 (a INT)
ENGINE = InnoDB;
DROP TABLE t2;
INSERT INTO t1 VALUES (1);
DROP TABLE t1;
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
SELECT * FROM t2;
LOCK TABLES t1 read, t2 write;
SELECT * FROM t2;
UNLOCK TABLES;
DROP TABLE tq, tsq, t1, t2;
