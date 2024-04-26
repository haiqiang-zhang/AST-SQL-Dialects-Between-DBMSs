SELECT mysql_query_attribute_string('a');
SELECT mysql_query_attribute_string('a');
SELECT mysql_query_attribute_string('a');
SELECT mysql_query_attribute_string('a'), mysql_query_attribute_string('c');
SELECT mysql_query_attribute_string('a');
SELECT mysql_query_attribute_string('');
SELECT mysql_query_attribute_string('a');
SELECT mysql_query_attribute_string('a'),  mysql_query_attribute_string('c');
SELECT mysql_query_attribute_string('a');
EOF
exec $MYSQL < $MYSQLTEST_VARDIR/tmp/wl12542.sql;
SELECT mysql_query_attribute_string('a');
EOF
exec $MYSQL < $MYSQLTEST_VARDIR/tmp/wl12542.sql;
SELECT mysql_query_attribute_string('a');
EOF
--error 1
exec $MYSQL < $MYSQLTEST_VARDIR/tmp/wl12542.sql;
SELECT mysql_query_attribute_string('a'), mysql_query_attribute_string('c');
EOF
exec $MYSQL < $MYSQLTEST_VARDIR/tmp/wl12542.sql;
SELECT mysql_query_attribute_string('a');
EOF
exec $MYSQL < $MYSQLTEST_VARDIR/tmp/wl12542.sql;
SELECT mysql_query_attribute_string('a');
EOF
exec $MYSQL < $MYSQLTEST_VARDIR/tmp/wl12542.sql;
SELECT mysql_query_attribute_string('a');
