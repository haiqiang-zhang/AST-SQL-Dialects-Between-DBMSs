SET @transaction_read_only_save = @@transaction_read_only;

SET @@global.transaction_read_only = ON;
SELECT @@transaction_read_only;
SET SESSION TRANSACTION READ WRITE;
SELECT @@transaction_read_only;
SELECT @@transaction_read_only;

SET SESSION TRANSACTION READ WRITE;
SET TRANSACTION READ ONLY;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
SET @@global.transaction_read_only = @transaction_read_only_save;
