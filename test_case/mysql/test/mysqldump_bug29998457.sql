
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE = '';
let $mysqldumpfile = $MYSQLTEST_VARDIR/tmp/bug29998457.sql;
CREATE DATABASE test_bug29998457;
USE test_bug29998457;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (
pk INT,
v1 VARCHAR(255),
v2 VARCHAR(255),
v3 VARCHAR(255),
v4 VARCHAR(128),
v5 VARCHAR(64),
v6 VARCHAR(16),
v7 VARCHAR(16),
v8 VARCHAR(8),
v9 VARBINARY(32),
v10 VARBINARY(32));

SELECT '12345678901234567890123456789012345678901234567890' INTO @s;

SELECT CONCAT(@s, @s, @s, @s, @s) INTO @s1;

INSERT INTO t1 VALUES (1, @s1, @s1, @s1, @s1, @s1, @s1, @s1, @s1, '','NULL');

SELECT * FROM test_bug29998457.t1;

-- Ensure that there were no invalid insert statements generated in the mysqldump
-- output and the dump was restored properly.
SELECT * FROM test_bug29998457.t1;
DROP DATABASE test_bug29998457;
SET SQL_MODE = @OLD_SQL_MODE;
