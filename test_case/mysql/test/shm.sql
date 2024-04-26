
-- thread pool causes different results
-- source include/not_threadpool.inc

let $shm_name= query_get_value("SHOW GLOBAL VARIABLES LIKE 'shared_memory_base_name'", Value, 1);

-- Connect using SHM for testing
connect(shm_con,localhost,root,,,,$shm_name,SHM);

-- Source select test case
-- source include/common-tests.inc

connection default;

--
-- Bug #24924: shared-memory-base-name that is too long causes buffer overflow
--
--exec $MYSQLADMIN --no-defaults --user=root --host=127.0.0.1 --port=$MASTER_MYPORT --shared-memory-base-name=HeyMrBaseNameXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX ping

--
-- Bug #33899: Deadlock in mysql_real_query with shared memory connections
--

let $stmt= `SELECT REPEAT('a', 2048)`;

SET @max_allowed_packet= @@global.max_allowed_packet;
SET @net_buffer_length= @@global.net_buffer_length;

SET GLOBAL max_allowed_packet= 1024;
SET GLOBAL net_buffer_length= 1024;

SET GLOBAL max_allowed_packet= @max_allowed_packet;
SET GLOBAL net_buffer_length= @net_buffer_length;
