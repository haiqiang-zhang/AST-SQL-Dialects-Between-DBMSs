--     --transaction-isolation=READ-COMMITTED
--     innodb_lock_timeout = 5
--
-- Last update:
-- 2006-08-02 ML test refactored
--               old name was innodb_unsafe_binlog.test
--               main code went into include/unsafe_binlog.inc
--

let $engine_type= InnoDB;

SET @old_lock_wait_timeout= @@global.innodb_lock_wait_timeout;
SET GLOBAL innodb_lock_wait_timeout=1;

SET GLOBAL innodb_lock_wait_timeout= @old_lock_wait_timeout;
