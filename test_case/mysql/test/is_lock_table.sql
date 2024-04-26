
-- Note that we are going to hide DD tables from users
-- so that we avoid direct use of DD tables in user queries.
-- So the below test do not include such cases.

CREATE TABLE t1 (f1 int);
INSERT INTO t1 VALUES (1);
CREATE TABLE t2 AS SELECT * FROM t1;
CREATE TABLE t3 AS SELECT * FROM t1;
CREATE VIEW v1 AS SELECT * FROM t3;
SELECT COUNT(*) FROM information_schema.columns
                WHERE table_name='db';
SELECT COUNT(*) FROM t1;
SELECT COUNT(*) FROM v1;
SELECT COUNT(*) FROM information_schema.columns WHERE table_name='db';
SELECT COUNT(*) FROM information_schema.tables m
                     JOIN information_schema.columns n
                     ON m.table_name = n.table_name
                WHERE m.table_name='db';
SELECT COUNT(*) FROM information_schema.columns, t1
                WHERE table_name='db';
SELECT COUNT(*) FROM information_schema.columns, v1
                WHERE table_name='db';
SELECT COUNT(*) FROM information_schema.columns, t2
                WHERE table_name='db';
CREATE FUNCTION func1()
RETURNS INT DETERMINISTIC
BEGIN
  DECLARE a int;
  SELECT COUNT(*) INTO a
    FROM information_schema.columns
    WHERE table_name='db';
END $

CREATE PROCEDURE proc1()
BEGIN
  DECLARE i INT;
  SELECT (func1() + COUNT(*)) INTO i
    FROM information_schema.tables m
         JOIN information_schema.columns n
         ON m.table_name = n.table_name
    WHERE m.table_name='db';
  INSERT INTO t1 VALUES (i);
END $
DELIMITER ;
SELECT * FROM t1;
SELECT func1() as COUNT_FROM_SP FROM t3;
SELECT func1() as COUNT_FROM_SP, COUNT(*) FROM information_schema.tables m
                     JOIN information_schema.columns n
                     ON m.table_name = n.table_name
                     WHERE m.table_name='db';
SELECT * FROM t1 as X;

CREATE TRIGGER trig1 AFTER INSERT ON t1 FOR EACH ROW
  INSERT INTO t2 SELECT COUNT(*)>1 FROM information_schema.columns;
INSERT INTO t1 VALUES(1);
SELECT * FROM t2;
INSERT INTO t1 VALUES(1);
SELECT * FROM t2;
SET TRANSACTION_ISOLATION='SERIALIZABLE';
SET AUTOCOMMIT=0;
SELECT COUNT(*) > 0 FROM information_schema.tables;
DROP TABLE t2;
SET TRANSACTION_ISOLATION=default;
SET AUTOCOMMIT=default;

-- Cleanup
DROP TABLE t1, t3;
DROP VIEW v1;
DROP FUNCTION func1;
DROP PROCEDURE proc1;
