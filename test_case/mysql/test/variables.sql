drop table if exists t1,t2;

SET @default_table_open_cache = @@table_open_cache;

--
-- Bug#19263: variables.test does not clean up after itself (I/II -- save)
--
set @my_log_error_verbosity       =@@global.log_error_verbosity;
set @my_connect_timeout           =@@global.connect_timeout;
set @my_delayed_insert_timeout    =@@global.delayed_insert_timeout;
set @my_delayed_queue_size        =@@global.delayed_queue_size;
set @my_flush                     =@@global.flush;
set @my_flush_time                =@@global.flush_time;
set @my_key_buffer_size           =@@global.key_buffer_size;
set @my_max_binlog_cache_size     =@@global.max_binlog_cache_size;
set @my_binlog_cache_size         =@@global.binlog_cache_size;
set @my_max_binlog_size           =@@global.max_binlog_size;
set @my_max_connect_errors        =@@global.max_connect_errors;
set @my_max_connections           =@@global.max_connections;
set @my_max_delayed_threads       =@@global.max_delayed_threads;
set @my_max_heap_table_size       =@@global.max_heap_table_size;
set @my_max_insert_delayed_threads=@@global.max_insert_delayed_threads;
set @my_max_join_size             =@@global.max_join_size;
set @my_myisam_data_pointer_size  =@@global.myisam_data_pointer_size;
set @my_myisam_max_sort_file_size =@@global.myisam_max_sort_file_size;
set @my_net_buffer_length         =@@global.net_buffer_length;
set @my_net_write_timeout         =@@global.net_write_timeout;
set @my_net_read_timeout          =@@global.net_read_timeout;
set @my_server_id                 =@@global.server_id;
set @my_slow_launch_time          =@@global.slow_launch_time;
set @my_storage_engine            =@@global.default_storage_engine;
set @my_max_allowed_packet        =@@global.max_allowed_packet;
set @my_join_buffer_size          =@@global.join_buffer_size;
set @`test`=1;
select @test, @`test`, @TEST, @`TEST`, @"teSt";
set @TEST=2;
select @test, @`test`, @TEST, @`TEST`, @"teSt";
set @"tEST"=3;
select @test, @`test`, @TEST, @`TEST`, @"teSt";
set @`TeST`=4;
select @test, @`test`, @TEST, @`TEST`, @"teSt";
select @`teST`:=5;
select @test, @`test`, @TEST, @`TEST`, @"teSt";

set @select=2,@t5=1.23456;
select @`select`,@not_used;
set @test_int=10,@test_double=1e-10,@test_string="abcdeghi",@test_string2="abcdefghij",@select=NULL;
select @test_int,@test_double,@test_string,@test_string2,@select;
set @test_int="hello",@test_double="hello",@test_string="hello",@test_string2="hello";
select @test_int,@test_double,@test_string,@test_string2;
set @test_int="hellohello",@test_double="hellohello",@test_string="hellohello",@test_string2="hellohello";
select @test_int,@test_double,@test_string,@test_string2;
set @test_int=null,@test_double=null,@test_string=null,@test_string2=null;
select @test_int,@test_double,@test_string,@test_string2;
select @t1:=(@t2:=1)+@t3:=4,@t1,@t2,@t3;
select @t5;

--
-- Test problem with WHERE and variables
--

CREATE TABLE t1 (c_id INT(4) NOT NULL, c_name CHAR(20), c_country CHAR(3), PRIMARY KEY(c_id));
INSERT INTO t1 VALUES (1,'Bozo','USA'),(2,'Ronald','USA'),(3,'Kinko','IRE'),(4,'Mr. Floppy','GB');
SELECT @min_cid:=min(c_id), @max_cid:=max(c_id) from t1;
SELECT * FROM t1 WHERE c_id=@min_cid OR c_id=@max_cid;
SELECT * FROM t1 WHERE c_id=@min_cid OR c_id=@max_cid OR c_id=666;
ALTER TABLE t1 DROP PRIMARY KEY;
select * from t1 where c_id=@min_cid OR c_id=@max_cid;
drop table t1;

--
-- Test system variables
--
set GLOBAL max_join_size=10;
set max_join_size=100;
set max_join_size=1000;
set max_join_size=100;
SET SQL_BIG_SELECTS=1;

select * from performance_schema.session_variables where variable_name like 'max_join_size';
select * from performance_schema.global_variables where variable_name like 'max_join_size';
set GLOBAL max_join_size=2000;
select * from performance_schema.global_variables where variable_name like 'max_join_size';
set max_join_size=DEFAULT;
select * from performance_schema.session_variables where variable_name like 'max_join_size';
set GLOBAL max_join_size=DEFAULT;
select * from performance_schema.global_variables where variable_name like 'max_join_size';
set @@max_join_size=1000, @@global.max_join_size=2000;
select @@local.max_join_size, @@global.max_join_size;
select @@identity,  length(@@version)>0;
select @@VERSION=version();
select last_insert_id(345);
select @@IDENTITY,last_insert_id(), @@identity;

set big_tables=OFF, big_tables=ON, big_tables=0, big_tables=1, big_tables="OFF", big_tables="ON";

set global concurrent_insert=2;
select * from performance_schema.session_variables where variable_name like 'concurrent_insert';
set global concurrent_insert=1;
select * from performance_schema.session_variables where variable_name like 'concurrent_insert';
set global concurrent_insert=0;
select * from performance_schema.session_variables where variable_name like 'concurrent_insert';
set global concurrent_insert=DEFAULT;
select @@concurrent_insert;

set default_storage_engine=MYISAM, default_storage_engine="HEAP", global default_storage_engine="MERGE";
select * from performance_schema.session_variables where variable_name like 'default_storage_engine';
select * from performance_schema.global_variables where variable_name like 'default_storage_engine';

set GLOBAL myisam_max_sort_file_size=2000000;
select * from performance_schema.global_variables where variable_name like 'myisam_max_sort_file_size';
set GLOBAL myisam_max_sort_file_size=default;
select * from performance_schema.global_variables where variable_name like 'myisam_max_sort_file_size';

-- bug#22891: modified to take read-only SESSION net_buffer_length into account
set global net_retry_count=10, session net_retry_count=10;
set global net_buffer_length=1024, net_write_timeout=200, net_read_timeout=300;
select * from performance_schema.global_variables where variable_name like 'net_%' order by 1;
select * from performance_schema.session_variables where variable_name like 'net_%' order by 1;
set global net_buffer_length=8000, global net_read_timeout=900, net_write_timeout=1000;
select * from performance_schema.global_variables where variable_name like 'net_%' order by 1;
set global net_buffer_length=1;
select * from performance_schema.global_variables where variable_name like 'net_buffer_length';
set global net_buffer_length=2000000000;
select * from performance_schema.global_variables where variable_name like 'net_buffer_length';

set character set cp1251_koi8;
select * from performance_schema.session_variables where variable_name like 'character_set_client';
select @@timestamp>0;

set @@rand_seed1=10000000,@@rand_seed2=1000000;
select ROUND(RAND(),5);
SELECT * FROM performance_schema.session_variables
WHERE variable_name IN ('range_alloc_block_size',
'query_alloc_block_size', 'query_prealloc_size',
'transaction_alloc_block_size', 'transaction_prealloc_size') ORDER BY 1;
set @@range_alloc_block_size=1024*15+1024;
set @@query_alloc_block_size=1024*15+1024*2;
set @@query_prealloc_size=1024*18-1024;
set @@transaction_alloc_block_size=1024*21-1024*1;
set @@transaction_prealloc_size=1024*21-2048;
select @@query_alloc_block_size;
SELECT * FROM performance_schema.session_variables
WHERE variable_name IN ('range_alloc_block_size',
'query_alloc_block_size', 'query_prealloc_size',
'transaction_alloc_block_size', 'transaction_prealloc_size') ORDER BY 1;
set @@range_alloc_block_size=1024*16+1023;
set @@query_alloc_block_size=1024*17+2;
set @@query_prealloc_size=1024*18-1023;
set @@transaction_alloc_block_size=1024*20-1;
set @@transaction_prealloc_size=1024*21-1;
SELECT * FROM performance_schema.session_variables
WHERE variable_name IN ('range_alloc_block_size',
'query_alloc_block_size', 'query_prealloc_size',
'transaction_alloc_block_size', 'transaction_prealloc_size') ORDER BY 1;
set @@range_alloc_block_size=default;
set @@query_alloc_block_size=default, @@query_prealloc_size=default;
set transaction_alloc_block_size=default, @@transaction_prealloc_size=default;

--
-- Bug #10904 Illegal mix of collations between
-- a system variable and a constant
--
SELECT @@version LIKE 'non-existent';
SELECT @@version_compile_os LIKE 'non-existent';

-- The following should give errors

--error ER_WRONG_VALUE_FOR_VAR
set big_tables=OFFF;
set big_tables="OFFF";
set unknown_variable=1;
set max_join_size="hello";
set default_storage_engine=UNKNOWN_TABLE_TYPE;
set default_storage_engine=MERGE, big_tables=2;
set character_set_client=UNKNOWN_CHARACTER_SET;
set collation_connection=UNKNOWN_COLLATION;
set character_set_client=NULL;
set collation_connection=NULL;
select @@global.timestamp;
set @@version='';
set @@concurrent_insert=1;
set myisam_max_sort_file_size=100;
set @@SQL_WARNINGS=NULL;

-- Test setting all variables

set autocommit=1;
set big_tables=1;
select @@autocommit, @@big_tables;
set global binlog_cache_size=100;
set bulk_insert_buffer_size=100;
set character set cp1251_koi8;
set character set default;
set @@global.concurrent_insert=1;
set global connect_timeout=100;
select @@delay_key_write;
set global delay_key_write="OFF";
select @@delay_key_write;
set global delay_key_write=ALL;
select @@delay_key_write;
set global delay_key_write=1;
select @@delay_key_write;
set global delayed_insert_limit=100;
set global delayed_insert_timeout=100;
set global delayed_queue_size=100;
set global flush=1;
set global flush_time=100;
set insert_id=1;
set interactive_timeout=100;
set join_buffer_size=100;
set last_insert_id=1;
set global local_infile=0;
set long_query_time=0.000001;
select @@long_query_time;
set long_query_time=100.000001;
select @@long_query_time;
set low_priority_updates=1;
set global max_allowed_packet=100;
set global max_binlog_cache_size=100;
set global max_binlog_size=100;
set global max_connect_errors=100;
set global max_connections=100;
set global max_delayed_threads=100;
set max_heap_table_size=100;
set max_join_size=100;
set max_sort_length=100;
set global max_user_connections=100;
select @@max_user_connections;
set global max_write_lock_count=100;
set myisam_sort_buffer_size=100;
set global net_buffer_length=100;
set net_read_timeout=100;
set net_write_timeout=100;
set read_buffer_size=100;
set read_rnd_buffer_size=100;
set global server_id=100;
set global slow_launch_time=100;
set sort_buffer_size=100;
set @@max_sp_recursion_depth=10;
select @@max_sp_recursion_depth;
set @@max_sp_recursion_depth=0;
select @@max_sp_recursion_depth;
set sql_auto_is_null=1;
select @@sql_auto_is_null;
set @@sql_auto_is_null=0;
select @@sql_auto_is_null;
set sql_big_selects=1;
set sql_buffer_result=1;
set sql_log_bin=1;
set sql_log_off=1;
set sql_quote_show_create=1;
set sql_safe_updates=1;
set sql_select_limit=1;
set sql_select_limit=default;
set sql_warnings=1;
set global table_open_cache=100;
set default_storage_engine=myisam;
set timestamp=1, timestamp=default;
set tmp_table_size=100;
set transaction_isolation="READ-COMMITTED";
set wait_timeout=100;
set global log_error_verbosity=2;
set sort_buffer_size=default;
set global max_allowed_packet        =@my_max_allowed_packet;
select @@session.insert_id;
set @save_insert_id=@@session.insert_id;
set session insert_id=20;
select @@session.insert_id;

set session last_insert_id=100;
select @@session.insert_id;
select @@session.last_insert_id;
select @@session.insert_id;

set @@session.insert_id=@save_insert_id;
select @@session.insert_id;

--
-- key buffer
--

create table t1 (a int not null auto_increment, primary key(a));
create table t2 (a int not null auto_increment, primary key(a));
insert into t1 values(null),(null),(null);
insert into t2 values(null),(null),(null);
set global key_buffer_size=100000;
select @@key_buffer_size;
select * from t1 where a=2;
select * from t2 where a=3;
select max(a) +1, max(a) +2 into @xx,@yy from t1;
drop table t1,t2;

--
-- error conditions
--

--error ER_UNKNOWN_SYSTEM_VARIABLE
select @@xxxxxxxxxx;
select 1;
select @@session.key_buffer_size;
set ft_boolean_syntax = @@init_connect;
set global ft_boolean_syntax = @@init_connect;
set init_connect = NULL;
set global init_connect = NULL;
set ft_boolean_syntax = @@init_connect;
set global ft_boolean_syntax = @@init_connect;

-- Bug#3754 SET GLOBAL myisam_max_sort_file_size doesn't work as
-- expected: check that there is no overflow when 64-bit unsigned
-- variables are set

set global myisam_max_sort_file_size=4294967296;
select * from performance_schema.global_variables where variable_name like 'myisam_max_sort_file_size';
set global myisam_max_sort_file_size=default;

--
-- swap
--
select @@global.max_user_connections,@@local.max_join_size;
set @svc=@@global.max_user_connections, @svj=@@local.max_join_size;
select @@global.max_user_connections,@@local.max_join_size;
set @@global.max_user_connections=111,@@local.max_join_size=222;
select @@global.max_user_connections,@@local.max_join_size;
set @@global.max_user_connections=@@local.max_join_size,@@local.max_join_size=@@global.max_user_connections;
select @@global.max_user_connections,@@local.max_join_size;
set @@global.max_user_connections=@svc, @@local.max_join_size=@svj;
select @@global.max_user_connections,@@local.max_join_size;
set @a=1, @b=2;
set @a=@b, @b=@a;
select @a, @b;

-- Reset max_join_size now. Otherwise, every test case below that
-- accesses more than 100 rows would fail. (This test is not for
-- testing max_join_size anyways. That is done in main.select_safe.)
SET max_join_size = @my_max_join_size;

--
-- Bug#2586:Disallow global/session/local as structured var. instance names
--
--error ER_PARSE_ERROR
set @@global.global.key_buffer_size= 1;
set GLOBAL global.key_buffer_size= 1;
SELECT @@global.global.key_buffer_size;
SELECT @@global.session.key_buffer_size;
SELECT @@global.local.key_buffer_size;


--
-- BUG#4788 show create table provides incorrect statement
--
-- What default width have numeric types?
create table t1 (
  c1 tinyint,
  c2 smallint,
  c3 mediumint,
  c4 int,
  c5 bigint);
drop table t1;
set @arg00= 8, @arg01= 8.8, @arg02= 'a string', @arg03= 0.2e0;
create table t1 as select @arg00 as c1, @arg01 as c2, @arg02 as c3, @arg03 as c4;
drop table t1;


--
-- Bug #6993: myisam_data_pointer_size
-- Wrong bug report, data pointer size must be restricted to 7,
-- setting to 8 will not work on all computers, myisamchk and
-- the server may see a wrong value, such as 0 or negative number
-- if 8 bytes is set.
--

SET GLOBAL MYISAM_DATA_POINTER_SIZE= 7;
SELECT * FROM performance_schema.session_variables WHERE VARIABLE_NAME LIKE 'MYISAM_DATA_POINTER_SIZE';

--
-- Bug #6958: negative arguments to integer options wrap around
--

SET GLOBAL table_open_cache=-1;
SELECT * FROM performance_schema.session_variables WHERE VARIABLE_NAME LIKE 'table_open_cache';
SET GLOBAL table_open_cache= @default_table_open_cache;

--
-- Bugs12363: character_set_results is nullable,
-- but value_ptr returns string "NULL"
--
set character_set_results=NULL;
select ifnull(@@character_set_results,"really null");
set names latin1;

--
-- Tests for lc_time_names
-- Note, when adding new locales, please fix ID accordingly:
-- - to test the last ID (currently 108)
-- - and the next after the last (currently 109)
--
--echo *** Various tests with LC_TIME_NAMES
--echo *** LC_TIME_NAMES: testing case insensitivity
set @@lc_time_names='ru_ru';
select @@lc_time_names;
set @lc='JA_JP';
set @@lc_time_names=@lc;
select @@lc_time_names;
set lc_time_names=concat('de','_','DE');
select @@lc_time_names;
set lc_time_names=concat('de','+','DE');
select @@lc_time_names;
set @@lc_time_names=1+2;
select @@lc_time_names;
set @@lc_time_names=1/0;
select @@lc_time_names;
set lc_time_names=en_US;
set lc_time_names=NULL;
set lc_time_names=-1;
select @@lc_time_names;
set lc_time_names=110;
select @@lc_time_names;
set lc_time_names=111;
select @@lc_time_names;
set lc_time_names=0;
select @@lc_time_names;

--
-- Bug #22648 LC_TIME_NAMES: Setting GLOBAL has no effect
--
select @@global.lc_time_names, @@lc_time_names;
set @@global.lc_time_names=fr_FR;
select @@global.lc_time_names, @@lc_time_names;
select @@global.lc_time_names, @@lc_time_names;
set @@lc_time_names=ru_RU;
select @@global.lc_time_names, @@lc_time_names;
select @@global.lc_time_names, @@lc_time_names;
set lc_time_names=default;
select @@global.lc_time_names, @@lc_time_names;
set @@global.lc_time_names=default;
select @@global.lc_time_names, @@lc_time_names;
set @@lc_time_names=default;
select @@global.lc_time_names, @@lc_time_names;


--
-- Bug #13334: query_prealloc_size default less than minimum
--
set @test = @@query_prealloc_size;
set @@query_prealloc_size = @test;
select @@query_prealloc_size = @test;

--
-- Bug#31588 buffer overrun when setting variables
--
-- Buffer-size Off By One. Should throw valgrind-warning without fix #31588.
--error ER_WRONG_VALUE_FOR_VAR
set global sql_mode=repeat('a',80);

--
-- Bug#6282 Packet error with SELECT INTO
--

create table t1 (a int);
select a into @x from t1;
drop table t1;

--
-- Bug #10339: read only variables.
--

--error ER_INCORRECT_GLOBAL_LOCAL_VAR
set @@warning_count=1;
set @@global.error_count=1;

--
-- Bug #10351: Setting ulong variable to > MAX_ULONG fails on 32-bit platform
--

--disable_warnings
set @@max_heap_table_size= 4294967296;
select @@max_heap_table_size > 0;
set global max_heap_table_size= 4294967296;
select @@max_heap_table_size > 0;
set @@max_heap_table_size= 4294967296;
select @@max_heap_table_size > 0;

--
-- Bug #11775 Variable character_set_system does not exist (sometimes)
--
select @@character_set_system;
set global character_set_system = latin1;
set @@global.version_compile_os='234';

--
-- Check character_set_filesystem variable
--
set character_set_filesystem=latin1;
select @@character_set_filesystem;
set @@global.character_set_filesystem=latin2;
set character_set_filesystem=latin1;
select @@character_set_filesystem;
set @@global.character_set_filesystem=latin2;
set character_set_filesystem=default;
select @@character_set_filesystem;
set @@global.character_set_filesystem=default;
select @@global.character_set_filesystem;

--
-- Bug #17849: Show sql_big_selects in SHOW VARIABLES
--
set @old_sql_big_selects = @@sql_big_selects;
set @@sql_big_selects = 1;
select * from performance_schema.session_variables where variable_name like 'sql_big_selects';
set @@sql_big_selects = @old_sql_big_selects;

--
-- Bug #16195: SHOW VARIABLES doesn't report correctly sql_warnings and
-- sql_notes values
--
set @@sql_notes = 0, @@sql_warnings = 0;
select * from performance_schema.session_variables where variable_name like 'sql_notes';
select * from performance_schema.session_variables where variable_name like 'sql_warnings';
set @@sql_notes = 1, @@sql_warnings = 1;
select * from performance_schema.session_variables where variable_name like 'sql_notes';
select * from performance_schema.session_variables where variable_name like 'sql_warnings';

--
-- Bug #12792: @@system_time_zone is not SELECTable.
--
-- Don't actually output, since it depends on the system
--replace_column 1 --
select @@system_time_zone;

--
-- Bug #15684: system variables cannot be SELECTed (e.g. @@version_comment)
--
-- Don't actually output, since it depends on the system
--replace_column 1 -- 2 # 3 # 4 #
select @@version, @@version_comment, @@version_compile_machine,
       @@version_compile_os;

--
-- Bug #1039: make tmpdir and datadir available as @@variables (also included
-- basedir)
--
-- Don't actually output, since it depends on the system
--replace_column 1 -- 2 # 3 #
select @@basedir, @@datadir, @@tmpdir;
select * from performance_schema.session_variables where variable_name like 'basedir';
select * from performance_schema.session_variables where variable_name like 'datadir';
select * from performance_schema.session_variables where variable_name like 'tmpdir';

--
-- Bug #19606: make ssl settings available via SHOW VARIABLES and @@variables
--
-- Don't actually output, since it depends on the system
--replace_column 1 -- 2 # 3 # 4 # 5 #
select @@ssl_ca, @@ssl_capath, @@ssl_cert, @@ssl_cipher, @@ssl_key;
select * from performance_schema.session_variables where variable_name like 'ssl%' order by 1;

--
-- Bug #19616: make log_queries_not_using_indexes available in SHOW VARIABLES
-- and as @@log_queries_not_using_indexes
--
select @@log_queries_not_using_indexes;
select * from performance_schema.session_variables where variable_name like 'log_queries_not_using_indexes';

--
-- Bug#20908: Crash if select @@""
--
--error ER_PARSE_ERROR
select @@"";
select @@&;
select @@@;

--
-- Bug#20166 mysql-test-run.pl does not test system privilege tables creation
--
-- Don't actually output, since it depends on the system
--replace_column 1 --
select @@hostname;
set @@hostname= "anothername";
SET @@myisam_mmap_size= 500M;
SET TIMESTAMP=2*1024*1024*1024;
SELECT UTC_DATE();
SET TIMESTAMP=DEFAULT;

--
-- Bug#36446: Attempt to set @@join_buffer_size to its minimum value
--            produces spurious warning
--

-- set to 1 so mysqld will correct to minimum (+ warn)
set join_buffer_size=1;
set @save_join_buffer_size=@@join_buffer_size;
set join_buffer_size=@save_join_buffer_size;

-- This is at the very after the versioned tests, since it involves doing
-- cleanup
--
-- Bug #19263: variables.test doesn't clean up after itself (II/II --
-- restore)
--
set global connect_timeout           =@my_connect_timeout;
set global delayed_insert_timeout    =@my_delayed_insert_timeout;
set global delayed_queue_size        =@my_delayed_queue_size;
set global flush                     =@my_flush;
set global flush_time                =@my_flush_time;
set global key_buffer_size           =@my_key_buffer_size;
set global max_binlog_cache_size     =@my_max_binlog_cache_size;
set global binlog_cache_size         =@my_binlog_cache_size;
set global max_binlog_size           =@my_max_binlog_size;
set global max_connect_errors        =@my_max_connect_errors;
set global max_connections           =@my_max_connections;
set global max_delayed_threads       =@my_max_delayed_threads;
set global max_heap_table_size       =@my_max_heap_table_size;
set global max_insert_delayed_threads=@my_max_insert_delayed_threads;
set global max_join_size             =@my_max_join_size;
set global max_user_connections      =default;
set global max_write_lock_count      =default;
set global myisam_data_pointer_size  =@my_myisam_data_pointer_size;
set global myisam_max_sort_file_size =@my_myisam_max_sort_file_size;
set global net_buffer_length         =@my_net_buffer_length;
set global net_write_timeout         =@my_net_write_timeout;
set global net_read_timeout          =@my_net_read_timeout;
set global server_id                 =@my_server_id;
set global slow_launch_time          =@my_slow_launch_time;
set global default_storage_engine            =@my_storage_engine;
set global max_allowed_packet        =@my_max_allowed_packet;
set global join_buffer_size          =@my_join_buffer_size;
set global log_error_verbosity       =@my_log_error_verbosity;

--
-- Bug#28580 Repeatation of status variables
--
--disable_warnings
--replace_column 2 --
show global variables where Variable_name='table_definition_cache';
SET GLOBAL log_output = '';
SET GLOBAL log_output = 0;

--
-- Bug#28234 - global/session scope - documentation vs implementation
--
--echo
--echo --
SHOW VARIABLES like 'ft_max_word_len';
SELECT @@session.ft_max_word_len;
SELECT @@global.ft_max_word_len;
SET @@session.ft_max_word_len= 7;
SET @@global.ft_max_word_len= 7;
SELECT @@session.ft_min_word_len;
SELECT @@global.ft_min_word_len;
SET @@session.ft_min_word_len= 7;
SET @@global.ft_min_word_len= 7;
SELECT @@session.ft_query_expansion_limit;
SELECT @@global.ft_query_expansion_limit;
SET @@session.ft_query_expansion_limit= 7;
SET @@global.ft_query_expansion_limit= 7;
SELECT @@session.ft_stopword_file;
SELECT @@global.ft_stopword_file;
SET @@session.ft_stopword_file= 'x';
SET @@global.ft_stopword_file= 'x';
SELECT @@session.back_log;
SELECT @@global.back_log;
SET @@session.back_log= 7;
SET @@global.back_log= 7;
SELECT @@session.large_files_support;
SELECT @@global.large_files_support;
SET @@session.large_files_support= true;
SET @@global.large_files_support= true;
SELECT @@session.character_sets_dir;
SELECT @@global.character_sets_dir;
SET @@session.character_sets_dir= 'x';
SET @@global.character_sets_dir= 'x';
SELECT @@session.init_file;
SELECT @@global.init_file;
SET @@session.init_file= 'x';
SET @@global.init_file= 'x';
SELECT @@session.lc_messages_dir;
SELECT @@global.lc_messages_dir;
SET @@session.lc_messages_dir= 'x';
SET @@global.lc_messages_dir= 'x';
SELECT @@session.large_page_size;
SELECT @@global.large_page_size;
SET @@session.large_page_size= 7;
SET @@global.large_page_size= 7;
SELECT @@session.large_pages;
SELECT @@global.large_pages;
SET @@session.large_pages= true;
SET @@global.large_pages= true;
SELECT @@session.log_bin;
SELECT @@global.log_bin;
SET @@session.log_bin= true;
SET @@global.log_bin= true;
SELECT @@session.log_error;
SELECT @@global.log_error;
SET @@session.log_error= 'x';
SET @@global.log_error= 'x';
SELECT @@session.lower_case_file_system;
SELECT @@global.lower_case_file_system;
SET @@session.lower_case_file_system= true;
SET @@global.lower_case_file_system= true;
SELECT @@session.lower_case_table_names;
SELECT @@global.lower_case_table_names;
SET @@session.lower_case_table_names= 7;
SET @@global.lower_case_table_names= 7;
SELECT @@session.myisam_recover_options;
SELECT @@global.myisam_recover_options;
SET @@session.myisam_recover_options= 'x';
SET @@global.myisam_recover_options= 'x';
SELECT @@session.open_files_limit;
SELECT @@global.open_files_limit;
SET @@session.open_files_limit= 7;
SET @@global.open_files_limit= 7;
SELECT @@session.pid_file;
SELECT @@global.pid_file;
SET @@session.pid_file= 'x';
SET @@global.pid_file= 'x';
SELECT @@session.plugin_dir;
SELECT @@global.plugin_dir;
SET @@session.plugin_dir= 'x';
SET @@global.plugin_dir= 'x';
SELECT @@session.port;
SELECT @@global.port;
SET @@session.port= 7;
SET @@global.port= 7;
SELECT @@session.protocol_version;
SELECT @@global.protocol_version;
SET @@session.protocol_version= 7;
SET @@global.protocol_version= 7;
SELECT @@session.skip_external_locking;
SELECT @@global.skip_external_locking;
SET @@session.skip_external_locking= true;
SET @@global.skip_external_locking= true;
SELECT @@session.skip_networking;
SELECT @@global.skip_networking;
SET @@session.skip_networking= true;
SET @@global.skip_networking= true;
SELECT @@session.skip_show_database;
SELECT @@global.skip_show_database;
SET @@session.skip_show_database= true;
SET @@global.skip_show_database= true;
SELECT @@session.thread_stack;
SELECT @@global.thread_stack;
SET @@session.thread_stack= 7;
SET @@global.thread_stack= 7;

-- show that warning uses underscore (sysvar-name), not hyphens (option-name)
SET GLOBAL auto_increment_offset=-1;
SET GLOBAL auto_increment_offset=0;



--
-- Bug#41030 Wrong meta data (incorrect fieldlen)
--

--enable_metadata
select @@default_storage_engine;

--
-- Bug#36540: CREATE EVENT and ALTER EVENT statements fail with large server_id
--

SET @old_server_id = @@GLOBAL.server_id;
SET GLOBAL server_id = (1 << 32) - 1;
SELECT @@GLOBAL.server_id;
SET GLOBAL server_id = (1 << 32);
SELECT @@GLOBAL.server_id;
SET GLOBAL server_id = (1 << 60);
SELECT @@GLOBAL.server_id;
SET GLOBAL server_id = 0;
SELECT @@GLOBAL.server_id;
SET GLOBAL server_id = -1;
SELECT @@GLOBAL.server_id;
SET GLOBAL server_id = @old_server_id;

--
-- Bug #42778: delete order by null global variable causes
--             assertion .\filesort.cc, line 797
--

SELECT @@GLOBAL.INIT_FILE, @@GLOBAL.INIT_FILE IS NULL;

CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES ();
SET @bug42778= @@sql_safe_updates;
SET @@sql_safe_updates= 0;
DELETE FROM t1 ORDER BY (@@GLOBAL.INIT_FILE) ASC LIMIT 10;
SET @@sql_safe_updates= @bug42778;

DROP TABLE t1;

SET @old_max_binlog_cache_size = @@GLOBAL.max_binlog_cache_size;
SET GLOBAL max_binlog_cache_size = 5 * 1024 * 1024 * 1024;
SELECT @@GLOBAL.max_binlog_cache_size;
SET GLOBAL max_binlog_cache_size = @old_max_binlog_cache_size;

SELECT @@skip_name_resolve;

SET @kbs=@@global.key_buffer_size;
SET @kcbs=@@global.key_cache_block_size;
SET SQL_MODE=STRICT_ALL_TABLES;

-- sys_var_ulonglong_ptr: sys_max_binlog_cache_size
--error ER_WRONG_VALUE_FOR_VAR
SET @@global.max_binlog_cache_size=-1;

-- sys_var_thd_ha_rows: "max_join_size" et al.
--error ER_WRONG_VALUE_FOR_VAR
SET @@global.max_join_size=0;

-- sys_var_key_buffer_size: "key_buffer_size"
--error ER_WARN_CANT_DROP_DEFAULT_KEYCACHE
SET @@global.key_buffer_size=0;

-- sys_var_key_cache_long: "key_cache_block_size" et al.
--error ER_WRONG_VALUE_FOR_VAR
SET @@global.key_cache_block_size=0;
SET SQL_MODE=DEFAULT;

SET @@global.max_binlog_cache_size=-1;
SET @@global.max_join_size=0;
SET @@global.key_buffer_size=0;
SET @@global.key_cache_block_size=0;

CREATE TABLE t1(f1 DECIMAL(1,1) UNSIGNED);
INSERT INTO t1 VALUES (0.2),(0.1);
SELECT 1 FROM t1 GROUP BY @a:= (SELECT ROUND(f1) FROM t1 WHERE @a=f1);
DROP TABLE t1;

CREATE TABLE t1 AS SELECT @a:= CAST(1 AS UNSIGNED) AS a;
DROP TABLE t1;

-- cleanup
SET @@global.max_binlog_cache_size=DEFAULT;
SET @@global.binlog_cache_size=DEFAULT;
SET @@global.max_join_size=DEFAULT;
SET @@global.key_buffer_size=@kbs;
SET @@global.key_cache_block_size=@kcbs;
SET @sql_notes_saved = @@sql_notes;
SET @@sql_notes = ON;
SELECT @@sql_notes;
SET @@sql_notes = OF;
SELECT @@sql_notes;
SET @@sql_notes = OFF;
SELECT @@sql_notes;
SET @@sql_notes = @sql_notes_saved;
SET @delay_key_write_saved = @@delay_key_write;
SET GLOBAL delay_key_write = ON;
SELECT @@delay_key_write;
SET GLOBAL delay_key_write = OF;
SELECT @@delay_key_write;
SET GLOBAL delay_key_write = AL;
SELECT @@delay_key_write;
SET GLOBAL delay_key_write = OFF;
SELECT @@delay_key_write;
SET GLOBAL delay_key_write = ALL;
SELECT @@delay_key_write;
SET GLOBAL delay_key_write = @delay_key_write_saved;
SET @sql_safe_updates_saved = @@sql_safe_updates;
SET @@sql_safe_updates = ON;
SELECT @@sql_safe_updates;
SET @@sql_safe_updates = OF;
SELECT @@sql_safe_updates;
SET @@sql_safe_updates = OFF;
SELECT @@sql_safe_updates;
SET @@sql_safe_updates = @sql_safe_updates_saved;
SET @foreign_key_checks_saved = @@foreign_key_checks;
SET @@foreign_key_checks = ON;
SELECT @@foreign_key_checks;
SET @@foreign_key_checks = OF;
SELECT @@foreign_key_checks;
SET @@foreign_key_checks = OFF;
SELECT @@foreign_key_checks;
SET @@foreign_key_checks = @foreign_key_checks_saved;
SET @unique_checks_saved = @@unique_checks;
SET @@unique_checks = ON;
SELECT @@unique_checks;
SET @@unique_checks = OF;
SELECT @@unique_checks;
SET @@unique_checks = OFF;
SELECT @@unique_checks;
SET @@unique_checks = @unique_checks_saved;
SET @sql_buffer_result_saved = @@sql_buffer_result;
SET @@sql_buffer_result = ON;
SELECT @@sql_buffer_result;
SET @@sql_buffer_result = OF;
SELECT @@sql_buffer_result;
SET @@sql_buffer_result = OFF;
SELECT @@sql_buffer_result;
SET @@sql_buffer_result = @sql_buffer_result_saved;
SET @sql_quote_show_create_saved = @@sql_quote_show_create;
SET @@sql_quote_show_create = ON;
SELECT @@sql_quote_show_create;
SET @@sql_quote_show_create = OF;
SELECT @@sql_quote_show_create;
SET @@sql_quote_show_create = OFF;
SELECT @@sql_quote_show_create;
SET @@sql_quote_show_create = @sql_quote_show_create_saved;
drop table if exists t1;
drop function if exists t1_max;
drop function if exists t1_min;

create table t1 (a int) engine=innodb;
insert into t1(a) values (0), (1);
create function t1_max() returns int return (select max(a) from t1);
create function t1_min() returns int return (select min(a) from t1);
select t1_min();
select t1_max();
set @@session.autocommit=t1_min(), @@session.autocommit=t1_max(),
    @@session.autocommit=t1_min(), @@session.autocommit=t1_max(),
    @@session.autocommit=t1_min(), @@session.autocommit=t1_max();
drop table t1;
drop function t1_min;
drop function t1_max;
set session character_set_results = 2048;
set session character_set_client=2048;
set session character_set_connection=2048;
set session character_set_server=2048;
set session collation_server=2048;
set session character_set_filesystem=2048;
set session character_set_database=2048;
set session collation_connection=2048;
set session collation_database=2048;

-- Several tests currently use "@@sql_mode= cast(pow(2,32)-1"
-- to activate all SQL modes. This will stop working once
-- someone adds a new flag. The test below is designed to break
-- once this happens to indicate that other tests will have to
-- be updated.
--
-- The test does this by trying to set sql_mode to the next
-- currently unused flag value and check that this currently fails.
-- Once a new flag is added, this value will become valid and
-- the statement below will succeed.

--error ER_WRONG_VALUE_FOR_VAR
SET @@sql_mode= 8589934592;

-- Basic testing to check that each variable shows up and can be
-- altered.
--
-- Functional testing of log_slow_admin_statements is within
-- suites/sys_vars/t/log_slow_admin_statements_basic.test
-- suites/sys_vars/t/log_slow_admin_statements_func.test
--
-- Functional testing of log_slow_replica_statements is within
-- suites/sys_vars/t/log_slow_replica_statements_basic.test
-- suites/rpl/t/rpl_slow_query_log.test

show variables like 'log_slow%';
set global log_slow_admin_statements = on;
select * from performance_schema.global_variables where variable_name like 'log_slow_admin_statements';
set global log_slow_replica_statements = on;
select * from performance_schema.global_variables where variable_name like 'log_slow_replica_statements';
set global log_slow_admin_statements = default;
set global log_slow_replica_statements = default;

-- Tests that variables work correctly (setting and showing).

-- When log-bin, skip-log-bin and binlog-format options are specified, mask the warning
--disable_query_log
call mtr.add_suppression("\\[Warning\\] .*MY-\\d+.* You need to use --log-bin to make --binlog-format work.");
set @my_replica_net_timeout         =@@global.replica_net_timeout;
set global replica_net_timeout=100;
set global sql_replica_skip_counter=100;

-- End of 4.1 tests

-- BUG #7800: Add various-slave related variables to SHOW VARIABLES
show variables like 'replica_compressed_protocol';

set global replica_net_timeout=default;
set global sql_replica_skip_counter= 0;
set @@global.replica_net_timeout= @my_replica_net_timeout;

--
-- Bug#28234 - global/session scope - documentation vs implementation
--
--echo
--
-- Additional variables fixed from sql_repl.cc.
--
--echo --
SHOW VARIABLES like 'log_replica_updates';
SELECT @@session.log_replica_updates;
SELECT @@global.log_replica_updates;
SET @@session.log_replica_updates= true;
SET @@global.log_replica_updates= true;
SELECT @@session.relay_log;
SELECT @@global.relay_log;
SET @@session.relay_log= 'x';
SET @@global.relay_log= 'x';
SELECT @@session.relay_log_basename;
SELECT @@global.relay_log_basename;
SET @@session.relay_log_basename= 'x';
SET @@global.relay_log_basename= 'x';
SELECT @@session.log_bin_basename;
SELECT @@global.log_bin_basename;
SET @@session.log_bin_basename= 'x';
SET @@global.log_bin_basename= 'x';
SELECT @@session.relay_log_index;
SELECT @@global.relay_log_index;
SET @@session.relay_log_index= 'x';
SET @@global.relay_log_index= 'x';
SELECT @@session.log_bin_index;
SELECT @@global.log_bin_index;
SET @@session.log_bin_index= 'x';
SET @@global.log_bin_index= 'x';
SELECT @@session.relay_log_space_limit;
SELECT @@global.relay_log_space_limit;
SET @@session.relay_log_space_limit= 7;
SET @@global.relay_log_space_limit= 7;
SELECT @@session.replica_load_tmpdir;
SELECT @@global.replica_load_tmpdir;
SET @@session.replica_load_tmpdir= 'x';
SET @@global.replica_load_tmpdir= 'x';
SELECT @@session.replica_skip_errors;
SELECT @@global.replica_skip_errors;
SET @@session.replica_skip_errors= 7;
SET @@global.replica_skip_errors= 7;
--

--echo --
--echo -- Bug #11766769 : 59959: SMALL VALUES OF --MAX-ALLOWED-PACKET
--echo --   ARE NOT BEING HONORED
--echo --

CREATE TABLE t1 (a MEDIUMTEXT);

SET GLOBAL max_allowed_packet=2048;
SET GLOBAL net_buffer_length=4096;
INSERT INTO t1 VALUES ('123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890');
SELECT LENGTH(a) FROM t1;

SET GLOBAL max_allowed_packet=default;
SET GLOBAL net_buffer_length=default;
DROP TABLE t1;

--
-- Bug#43835: SHOW VARIABLES does not include 0 for replica_skip_errors
--

SHOW VARIABLES like 'replica_skip_errors';

--
-- Verify that SESSION only variables present in performance_schema.session_variables
-- are actually settable using SET SESSION
--
SET @sql_big_selects_save=@@sql_big_selects;
SET @@sql_big_selects=1;
CREATE TABLE all_vars (id INT PRIMARY KEY AUTO_INCREMENT, var_name VARCHAR(64), var_value VARCHAR(1024));

INSERT INTO all_vars (var_name, var_value)
SELECT a.variable_name,a.variable_value
FROM performance_schema.session_variables a
LEFT JOIN performance_schema.global_variables b
ON a.variable_name=b.variable_name
WHERE b.variable_name IS NULL
AND a.variable_name NOT IN ('debug_sync')
ORDER BY a.variable_name;
SET @@sql_big_selects=@sql_big_selects_save;
DROP TABLE all_vars;
SET character_set_client = @undefined_var;
SET @x = NULL;
