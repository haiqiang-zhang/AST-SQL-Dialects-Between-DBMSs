--  0. Initial setup. Create two connections (applier_thread, xa_commit_thread).
--
--  1. Make a thread as "applier_thread" by setting pseudo_replica_mode and
--     by executing BINLOG'' query.
--
--  2. Prepare a XA transaction on applier_thread that involves FTS index.
--
--  3. A 'XA COMMIT' is pending on table t1 which is holding MDL lock.
--     Hence executing 'DROP TABLE' on t1 should be blocked by the server.
--
--  4. From a different thread, check that DROP TABLE is waiting for MDL
--     lock. Then execute XA COMMIT which releases the MDL lock.
--
--  5. After XA COMMIT (after releasing MDL lock on table t1),
--     Drop table should continue and be successful.
--
--  6. Cleanup (disconnect two connections).
--
-- References:
--    Bug 27995891: CRASH: SEGMENTATION FAULT IN FTS_COMMIT_TABLE() DUE TO NULL FTS.
--
--echo --
--echo -- 0. Initial setup. Create two connections (applier_thread, xa_commit_thread).
--echo --
connect (applier_thread,127.0.0.1,root,,test,,);
SET @@SESSION.pseudo_replica_mode=1;
CREATE TABLE t1(i TEXT, FULLTEXT INDEX tix (i)) ENGINE=InnoDB;
INSERT INTO t1 VALUES ('abc');
let $wait_condition= SELECT COUNT(*) = 1 FROM information_schema.processlist WHERE state = "Waiting for table metadata lock" AND INFO = "DROP TABLE t1";
