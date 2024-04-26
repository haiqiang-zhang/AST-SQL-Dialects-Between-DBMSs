 
-- Uses /dev/null
--source include/not_windows.inc
 
--source include/master-slave.inc
 
--echo ==== Case 1: slave connection ====
 
-- Get thread id of dump thread.
--let $thread_id= `SELECT PROCESSLIST_ID FROM performance_schema.threads WHERE PROCESSLIST_COMMAND = 'Binlog Dump'`
 
-- Show connection attributes
--replace_result $thread_id <thread_id>
eval SELECT ATTR_NAME, ATTR_VALUE FROM performance_schema.session_connect_attrs
   WHERE PROCESSLIST_ID = $thread_id AND
   ATTR_NAME IN ('program_name', '_client_replication_channel_name', '_client_role');
 
-- Stop slave so as not to mix client attrs from slave with client
-- attrs from mysqlbinlog.
--source include/rpl_connection_slave.inc
--source include/stop_slave.inc
--source include/rpl_connection_master.inc
--source include/stop_dump_threads.inc
 
--echo -- Start mysqlbinlog
--let BINLOG_FILE= query_get_value(SHOW BINARY LOG STATUS, File, 1)
perl;
  my $mysqlbinlog= $ENV{'MYSQL_BINLOG'};
  my $port= $ENV{'MASTER_MYPORT'};
  my $binlog_file= $ENV{'BINLOG_FILE'};
EOF
 
-- Wait for master threads to start
--let $wait_condition= SELECT COUNT(*) > 0 FROM performance_schema.threads WHERE PROCESSLIST_COMMAND LIKE 'Binlog Dump' AND PROCESSLIST_STATE LIKE '%Source has sent%';
 
-- Get thread id of dump thread.
--let $thread_id= `SELECT PROCESSLIST_ID FROM performance_schema.threads WHERE PROCESSLIST_COMMAND = 'Binlog Dump'`
 
-- Show connection attributes
--replace_result $thread_id <thread_id>
eval SELECT ATTR_NAME, ATTR_VALUE FROM performance_schema.session_connect_attrs
   WHERE PROCESSLIST_ID = $thread_id AND
   ATTR_NAME IN ('program_name', '_client_replication_channel_name', '_client_role');
 
-- Clean up. This will cause mysqlbinlog to exit.
--replace_result $thread_id <thread_id>
eval KILL $thread_id;
