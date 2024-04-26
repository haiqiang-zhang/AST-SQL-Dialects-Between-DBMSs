
-- 
-- Bug#23209797 SEGMENTATION FAULT WHILE GETTING GET_SCHEMA_TABLES_RESULT()
-- Make sure information_schema.tmp_tables_* tables are not
-- directly accessible to users, except for SHOW COMMANDS.
--

CREATE TEMPORARY TABLE t1 (f1 int, f2 int primary key, UNIQUE KEY (f1));
SELECT * FROM information_schema.tmp_tables_columns;
SELECT * FROM information_schema.tmp_tables_keys;
DROP TEMPORARY TABLE t1;


--
-- Bug#23210930 ASSERTION `THD->GET_TRANSACTION()->IS_EMPTY(TRANSACTION_CTX::STMT)' FAILED.
-- Make sure the INFORMATION_SCHEMA system views are usable in
-- prepared statement.
--

CREATE TABLE t1 (f1 int);
SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE
  FROM information_schema.tables WHERE table_name='t1';
SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_TYPE
   FROM information_schema.tables WHERE table_name='t1';

DROP TABLE t1;

--
-- Bug #28165060   MYSQL IS TRYING TO PERFORM A CONSISTENT READ BUT THE READ
-- VIEW IS NOT ASSIGNED!
--

CREATE DATABASE abc;
CREATE TABLE abc.memorytable (id INT NOT NULL) ENGINE=MEMORY;
SELECT * FROM information_schema.TABLES WHERE TABLE_SCHEMA = 'abc';
DROP DATABASE abc;

CREATE TABLE t0 (c0 INT);
INSERT INTO t0 VALUES (1),(2),(3),(4),(5);
INSERT INTO t0 SELECT * FROM t0;
INSERT INTO t0 SELECT * FROM t0;
INSERT INTO t0 SELECT * FROM t0;
INSERT INTO t0 SELECT * FROM t0;
SET DEBUG_SYNC='before_insert_into_dd SIGNAL parked WAIT_FOR cont1';
       INTO @v1, @v2, @v3
       FROM INFORMATION_SCHEMA.TABLES WHERE table_name='t0';
SET DEBUG_SYNC= 'now WAIT_FOR parked';
SELECT TABLE_NAME, ENGINE, TABLE_ROWS
  INTO @v1, @v2, @v3
  FROM INFORMATION_SCHEMA.TABLES WHERE table_name='t0';

SET DEBUG_SYNC= 'now SIGNAL cont1';

-- Verify that we have latest statistics stored.
SELECT TABLE_NAME, ENGINE, TABLE_ROWS
  INTO @v1, @v2, @v3
  FROM INFORMATION_SCHEMA.TABLES WHERE table_name='t0';
DROP TABLE t0;
SET GLOBAL DEBUG=DEFAULT;
SET DEBUG_SYNC = 'RESET';

CREATE TABLE t0 (c0 INT) ENGINE=MyISAM;
INSERT INTO t0 VALUES (1),(2),(3),(4),(5);
INSERT INTO t0 SELECT * FROM t0;
INSERT INTO t0 SELECT * FROM t0;
INSERT INTO t0 SELECT * FROM t0;
INSERT INTO t0 SELECT * FROM t0;
SET DEBUG_SYNC='before_insert_into_dd SIGNAL parked WAIT_FOR cont1';
       INTO @v1, @v2, @v3
       FROM INFORMATION_SCHEMA.TABLES WHERE table_name='t0';
SET DEBUG_SYNC= 'now WAIT_FOR parked';
SELECT TABLE_NAME, ENGINE, TABLE_ROWS
  INTO @v1, @v2, @v3
  FROM INFORMATION_SCHEMA.TABLES WHERE table_name='t0';

SET DEBUG_SYNC= 'now SIGNAL cont1';

-- Verify that we have latest statistics stored.
SELECT TABLE_NAME, ENGINE, TABLE_ROWS
  INTO @v1, @v2, @v3
  FROM INFORMATION_SCHEMA.TABLES WHERE table_name='t0';
DROP TABLE t0;
SET GLOBAL DEBUG=DEFAULT;
SET DEBUG_SYNC = 'RESET';

CREATE TABLE t0 (c0 INT);
INSERT INTO t0 VALUES (1),(2),(3),(4),(5);
INSERT INTO t0 SELECT * FROM t0;
INSERT INTO t0 SELECT * FROM t0;
INSERT INTO t0 SELECT * FROM t0;
INSERT INTO t0 SELECT * FROM t0;
SET DEBUG_SYNC='before_insert_into_dd SIGNAL parked WAIT_FOR cont1';
SET DEBUG_SYNC= 'now WAIT_FOR parked';
SELECT TABLE_NAME, ENGINE, TABLE_ROWS
  INTO @v1, @v2, @v3
  FROM INFORMATION_SCHEMA.TABLES WHERE table_name='t0';

SET DEBUG_SYNC= 'now SIGNAL cont1';

-- Verify that we have latest statistics stored.
SELECT TABLE_NAME, ENGINE, TABLE_ROWS
  INTO @v1, @v2, @v3
  FROM INFORMATION_SCHEMA.TABLES WHERE table_name='t0';
DROP TABLE t0;
SET GLOBAL DEBUG=DEFAULT;
SET DEBUG_SYNC = 'RESET';

CREATE TABLE t1 (
org_id INT NOT NULL AUTO_INCREMENT,
org_code VARCHAR(16) NOT NULL,
PRIMARY KEY (org_id));

INSERT INTO t1 VALUES (NULL, '1');
INSERT INTO t1 VALUES (NULL, '2');

SET SESSION information_schema_stats_expiry = 0;

CREATE FUNCTION f1(table_name VARCHAR(64)) RETURNS INT
BEGIN
DECLARE dbname VARCHAR(32) DEFAULT 'test';
SELECT DATABASE() INTO dbname;
SELECT MAX(AUTO_INCREMENT) INTO nextid FROM information_schema.tables t WHERE
table_schema = dbname AND t.table_name = table_name;
SELECT MAX(AUTO_INCREMENT) FROM information_schema.tables t WHERE
table_schema = 'test' AND t.table_name = 't1';

SELECT f1('t1') = 3;

SET @expected = 3;
SET @db = 'test';
SET @table = 't1';

INSERT INTO t1 VALUES (NULL, '1');
SELECT MAX(AUTO_INCREMENT) FROM information_schema.tables t WHERE
table_schema = 'test' AND t.table_name = 't1';
SELECT f1('t1') = 4;
SET @expected = 4;
CREATE TABLE t2 (b CHAR(250), c CHAR(250));
CREATE PROCEDURE p2(tablespace VARCHAR(64))
BEGIN
SELECT DATA_FREE, FREE_EXTENTS, TOTAL_EXTENTS FROM information_schema.files WHERE
TABLESPACE_NAME = tablespace;
CREATE PROCEDURE populate_t2()
BEGIN
DECLARE i INT DEFAULT 1;
  INSERT INTO t2 (b,c) VALUES (repeat('b', 250), repeat('c', 250));
  SET i = i + 1;
END WHILE;
SET @tablespace = 'test/t2';
SELECT DATA_FREE, FREE_EXTENTS, TOTAL_EXTENTS FROM information_schema.files WHERE
TABLESPACE_NAME = 'test/t2';
DROP PROCEDURE populate_t2;
DROP PROCEDURE p2;
DROP TABLE t2;
DROP FUNCTION f1;
DROP TABLE t1;
SET SESSION information_schema_stats_expiry = default;
