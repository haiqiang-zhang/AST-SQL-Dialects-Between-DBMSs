
let SEARCH_FILE= $MYSQLTEST_VARDIR/log/my_restart.err;
let SEARCH_PATTERN= \[ERROR\] \[[^]]*\] \[[^]]*\] The server option \'lower_case_table_names\' is configured to use case sensitive table names but the data directory is on a case-insensitive file system which is an unsupported combination\. Please consider either using a case sensitive file system for your data directory or switching to a case-insensitive table name mode\.;
