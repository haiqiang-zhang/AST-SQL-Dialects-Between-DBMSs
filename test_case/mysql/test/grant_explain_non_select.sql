
--
-- Privilege-specific tests for WL#4897: Add EXPLAIN INSERT/UPDATE/DELETE
--

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

CREATE DATABASE privtest_db;

CREATE TABLE privtest_db.t1 (a INT);
CREATE TABLE privtest_db.t2 (a INT);
INSERT INTO privtest_db.t2 VALUES (1), (2), (3);

CREATE USER 'privtest'@'localhost';

USE privtest_db;
        INSERT INTO t1 VALUES (10);
        INSERT INTO t1 SELECT * FROM t2;
        INSERT INTO t1 VALUES (10);
        INSERT INTO t1 SELECT * FROM t2;
        REPLACE INTO t1 VALUES (10);
        REPLACE INTO t1 SELECT * FROM t2;
        REPLACE INTO t1 VALUES (10);
        REPLACE INTO t1 SELECT * FROM t2;
        REPLACE INTO t1 VALUES (10);
        REPLACE INTO t1 SELECT * FROM t2;
        REPLACE INTO t1 VALUES (10);
        REPLACE INTO t1 SELECT * FROM t2;
        UPDATE t1 SET a = a + 1;
        UPDATE t1, t2 SET t1.a = t1.a + 1 WHERE t1.a = t2.a;
        UPDATE t1 SET a = a + 1;
        UPDATE t1, t2 SET t1.a = t1.a + 1 WHERE t1.a = t2.a;
        UPDATE t1 SET a = a + 1;
        UPDATE t1, t2 SET t1.a = t1.a + 1 WHERE t1.a = t2.a;
        UPDATE t1 SET a = a + 1;
        UPDATE t1, t2 SET t1.a = t1.a + 1 WHERE t1.a = t2.a;
        DELETE FROM t1 WHERE a = 10;
        DELETE FROM t1 USING t1, t2 WHERE t1.a = t2.a;
        DELETE FROM t1 WHERE a = 10;
        DELETE FROM t1 USING t1, t2 WHERE t1.a = t2.a;
        DELETE FROM t1 WHERE a = 10;
        DELETE FROM t1 USING t1, t2 WHERE t1.a = t2.a;
        DELETE FROM t1 WHERE a = 10;
        DELETE FROM t1 USING t1, t2 WHERE t1.a = t2.a;

-- Views

connection default;
CREATE VIEW privtest_db.v1 (a) AS SELECT a FROM privtest_db.t1;
        SELECT * FROM v1;
        INSERT INTO v1 VALUES (10);
        INSERT INTO v1 SELECT * FROM t2;
        REPLACE  INTO v1 VALUES (10);
        REPLACE INTO v1 SELECT * FROM t2;
        UPDATE v1 SET a = a + 1;
        UPDATE v1, t2 SET v1.a = v1.a + 1 WHERE v1.a = t2.a;
        DELETE FROM v1 WHERE a = 10;
        DELETE FROM v1 USING v1, t2 WHERE v1.a = t2.a;

DROP USER 'privtest'@localhost;
USE test;
DROP DATABASE privtest_db;
