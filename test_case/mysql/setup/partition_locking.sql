create table thread_to_monitor(thread_id int);
CREATE TABLE t1 (a int PRIMARY KEY, b varchar(128), KEY (b))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 13;
CREATE TABLE t2 (a int PRIMARY KEY AUTO_INCREMENT, b varchar(128))
ENGINE = InnoDB
PARTITION BY HASH (a) PARTITIONS 13;
INSERT INTO t1 VALUES (1, 'First row, p1');
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
