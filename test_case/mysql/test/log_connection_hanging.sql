SET DEBUG="+d,simulate_connection_thread_hang";
SET DEBUG="+d,simulate_connection_thread_hang";

let SEARCH_FILE= $MYSQLTEST_VARDIR/log/mysqld.1.err;
let SEARCH_PATTERN= Waiting for forceful disconnection of Thread;
let SEARCH_PATTERN= Waiting for forceful disconnection of;
