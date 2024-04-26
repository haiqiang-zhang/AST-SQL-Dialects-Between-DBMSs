
SET @org_concurrent_insert= @@global.concurrent_insert;
SET @@global.concurrent_insert=1;

CREATE TABLE t1(a INT) ENGINE=MyISAM;
CREATE FUNCTION f1() RETURNS INT RETURN (SELECT MIN(a) FROM t1);
CREATE VIEW v1 AS (SELECT 1 FROM dual WHERE f1() = 1);
SET lock_wait_timeout=1;
INSERT INTO t1 VALUES (1);
SELECT * FROM v1;

-- Cleanup
disconnect con1;
SET @@global.concurrent_insert= @org_concurrent_insert;
DROP TABLE t1;
DROP VIEW v1;
DROP FUNCTION f1;
