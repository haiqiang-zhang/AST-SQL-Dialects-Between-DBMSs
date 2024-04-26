
CREATE DATABASE db21235226;
USE db21235226;

CREATE TABLE t1(a INT);
INSERT INTO t1 VALUES (1), (2);
SELECT * FROM t1;

CREATE USER uplain@localhost IDENTIFIED WITH 'cleartext_plugin_server'
  AS 'cleartext_test';
let LIBMYSQL_ENABLE_CLEARTEXT_PLUGIN=N;
--             Should get CR_AUTH_PLUGIN_CANNOT_LOAD error
--error 2
--exec $MYSQL_DUMP --user=uplain --password=cleartext_test --tab=$MYSQLTEST_VARDIR/tmp/ db21235226 2>&1

--Scenario 2 : MYSQL_DUMP with --enable_cleartext_plugin
--exec $MYSQL_DUMP --enable_cleartext_plugin --user=uplain --password=cleartext_test --tab=$MYSQLTEST_VARDIR/tmp/ db21235226
--exec $MYSQL --enable_cleartext_plugin --user=uplain --password=cleartext_test db21235226 < $MYSQLTEST_VARDIR/tmp/t1.sql
SELECT * FROM t1;
--             Should get CR_AUTH_PLUGIN_CANNOT_LOAD error
--replace_regex /.*mysqlimport(\.exe)*/mysqlimport/
--error 1
--exec $MYSQL_IMPORT --user=uplain --password=cleartext_test --silent db21235226 $MYSQLTEST_VARDIR/tmp/t1.txt 2>&1

--Scenario 4 : MYSQL_IMPORT with --enable_cleartext_plugin
--exec $MYSQL_IMPORT --enable_cleartext_plugin --user=uplain --password=cleartext_test --silent db21235226 $MYSQLTEST_VARDIR/tmp/t1.txt
SELECT * FROM t1;
--             Should get CR_AUTH_PLUGIN_CANNOT_LOAD error
--replace_regex /.*mysqlshow(\.exe)*/mysqlshow/
--error 1
--exec $MYSQL_SHOW --user=uplain --password=cleartext_test db21235226 2>&1

--Scenario 6 : MYSQL_SHOW with --enable_cleartext_plugin
--exec $MYSQL_SHOW --enable_cleartext_plugin --user=uplain --password=cleartext_test db21235226

--Scenario 7 : MYSQL_CHECK without --enable_cleartext_plugin
--             Should get CR_AUTH_PLUGIN_CANNOT_LOAD error
--replace_regex /.*mysqlcheck(\.exe)*/mysqlcheck/
--error 2
--exec $MYSQL_CHECK --user=uplain --password=cleartext_test db21235226 t1 2>&1

--Scenario 8 : MYSQL_CHECK with --enable_cleartext_plugin
--exec $MYSQL_CHECK --enable_cleartext_plugin --user=uplain --password=cleartext_test db21235226 t1

--Cleanup
DROP TABLE t1;
DROP DATABASE db21235226;
DROP USER uplain@localhost;
