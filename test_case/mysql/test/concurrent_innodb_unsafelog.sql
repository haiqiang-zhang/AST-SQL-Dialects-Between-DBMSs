--               main code t/innodb_concurrent.test -> include/concurrent.inc
--               new wrapper t/concurrent_innodb.test
-- 2008-06-03 KP test refactored;
--               renamed wrapper t/concurrent_innodb.test ->
--                           t/concurrent_innodb_unsafelog.test
--               new wrapper t/concurrent_innodb_safelog.test
--


let $engine_type= InnoDB;

SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET @old_lock_wait_timeout= @@global.innodb_lock_wait_timeout;
SET GLOBAL innodb_lock_wait_timeout=1;

SET GLOBAL TRANSACTION ISOLATION LEVEL REPEATABLE READ;
SET GLOBAL innodb_lock_wait_timeout= @old_lock_wait_timeout;
