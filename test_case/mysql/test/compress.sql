
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connect (comp_con,localhost,root,,,,,COMPRESS);

-- Source select test case
-- source include/common-tests.inc

connection default;

-- Check compression turned on
SHOW STATUS LIKE 'Compression%';
