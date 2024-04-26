
-- BUG#50780: 'show binary logs' debug assertion when binary logging is disabled

-- error ER_NO_BINARY_LOGGING
SHOW BINARY LOGS;
SELECT @@GLOBAL.log_bin;
SELECT @@GLOBAL.log_replica_updates;

CREATE TABLE t1(a INT);
ALTER TABLE t1 MODIFY COLUMN a DECIMAL DEFAULT '4648-04-10';
DROP TABLE t1;
