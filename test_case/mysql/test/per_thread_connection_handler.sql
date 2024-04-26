
-- save the initial number of concurrent sessions.
--source include/count_sessions.inc

-- Save global variables that are going to be used in this connection.
SET @old_debug= @@GLOBAL.debug;
SET @orig_max_connections= @@global.max_connections;

--  Make 3 connects and issue SELECT 1 and then test error
--  ER_CANT_CREATE_THREAD and the do disconnects of the three connections.
connect (con1, localhost, root,,mysql);
SELECT 1;
SELECT 1;
SELECT 1;

-- Test ER_CANT_CREATE_THREAD
SET GLOBAL debug= '+d,fail_thread_create';
SET GLOBAL debug="-d,fail_thread_create";

-- Test various error conditions.

-- Test ER_CON_COUNT_ERROR.
SET GLOBAL max_connections= 3;

-- Test resource allocation failure like out of memory.
SET GLOBAL debug= '+d,simulate_resource_failure';
SET GLOBAL debug= '-d,simulate_resource_failure';
SET GLOBAL debug= @old_debug;
SET GLOBAL max_connections= @orig_max_connections;
