
CREATE DATABASE db1;
CREATE DATABASE db2;
CREATE TABLE db1.t1 (a INT) ENGINE=MYISAM;
EOF

--replace_result $MYSQLD_LOG MYSQLD_LOG $MYSQLD MYSQLD
--let $restart_parameters = restart: --upgrade=FORCE --debug="+d,force_fix_user_schemas" --log-error=$MYSQLD_LOG
--let $wait_counter=10000
--source include/restart_mysqld.inc

--let SEARCH_FILE= $MYSQLD_LOG

--let SEARCH_PATTERN= Table 'db1.t1' requires repair.
--source include/search_pattern.inc

--let SEARCH_PATTERN= Table 'db1.t1' repair failed.
--source include/search_pattern.inc

--remove_file $MYSQLD_LOG

DROP DATABASE db1;
DROP DATABASE db2;
