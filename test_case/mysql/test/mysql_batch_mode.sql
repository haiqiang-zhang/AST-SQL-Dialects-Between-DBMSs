create database test1;
create database test2;
use `test1`;
DROP DATABASE IF EXISTS test1;
use `test2`;
DROP DATABASE IF EXISTS test2;
EOF
--exec $MYSQL < $MYSQLTEST_VARDIR/tmp/mysqltest.sql 2>&1
remove_file $MYSQLTEST_VARDIR/tmp/mysqltest.sql;
