
-- This test takes rather long time so let us run it only in --big-test mode
--source include/big_test.inc
-- We use some debug-only features in this test
--source include/have_debug.inc

--disable_warnings
drop table if exists t1,t2,t3,t4,t5,t6;
CREATE TABLE t1 (c1 INT) ENGINE= MyISAM;
    --echo -- connection con1
    connect (con1,localhost,root,,);
    let $con1_id= `SELECT CONNECTION_ID()`;
    SET SESSION debug="+d,sleep_open_and_lock_after_open";
    send INSERT INTO t1 VALUES (1);
let $wait_condition= SELECT 1 FROM INFORMATION_SCHEMA.PROCESSLIST
    WHERE ID = $con1_id AND STATE = 'Waiting for table metadata lock';
let $wait_condition= SELECT 1 FROM INFORMATION_SCHEMA.PROCESSLIST
    WHERE ID = $con1_id AND STATE = 'Waiting for table metadata lock';
SELECT * FROM t1;
    --echo -- connection con1
    connection con1;
    reap;
    SET SESSION debug="-d,sleep_open_and_lock_after_open";
    disconnect con1;
DROP TABLE t1;
