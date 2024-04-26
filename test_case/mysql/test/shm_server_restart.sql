
let $shm_name= query_get_value("SHOW GLOBAL VARIABLES LIKE 'shared_memory_base_name'", Value, 1);

-- Connect using SHM for testing
connect(shm_con,localhost,root,,,,$shm_name,SHM);

-- Disconnect shared memory connection prior to restarting server to avoid
-- shared memory reconnect bug.
disconnect shm_con;

-- Restart server
--exec echo "restart" >$MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

-- Restarting server above will fail when Bug #22646779 is not fixed

-- Connect using SHM for testing
connect(shm_con,localhost,root,,,,$shm_name,SHM);

SELECT 100;
