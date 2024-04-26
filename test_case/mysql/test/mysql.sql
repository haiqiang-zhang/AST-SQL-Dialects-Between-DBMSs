--

--disable_warnings
drop table if exists t1;

--
-- Test the "delimiter" functionality
-- Bug#9879
--
create table t1(a int);
insert into t1 values(1);

-- Test delimiters
--exec $MYSQL test 2>&1 < "./t/mysql_delimiter.sql"

--disable_query_log
-- Test delimiter : supplied on the command line
select "Test delimiter : from command line" as "_";
select "Test delimiter :;
select "Test 'go' command(vertical output) \G" as "_";
select "Test  'go' command \g" as "_";
drop table t1;

--
-- BUG9998 - MySQL client hangs on USE "database"
--
create table t1(a int);
drop table t1;

--
-- Bug#16859 -- NULLs in columns must not truncate data as if a C-language "string".
--
--exec $MYSQL -t test -e "create table t1 (col1 binary(4), col2 varchar(10), col3 int);

--
-- Bug#17939 Wrong table format when using utf8mb3 strings
--
--character_set utf8mb3
--execw $MYSQL --default-character-set=utf8mb3 --table -e "SELECT 'John Doe' as '__tañgè Ñãmé'" 2>&1
--execw $MYSQL --default-character-set=utf8mb3 --table -e "SELECT '__tañgè Ñãmé' as 'John Doe'" 2>&1

--
-- Bug#18265 -- mysql client: No longer right-justifies numeric columns
--
--execw $MYSQL -t --default-character-set utf8mb3 test -e "create table t1 (i int, j int, k char(25) charset utf8mb3);

--
-- "DESCRIBE" commands may return strange NULLness flags.
--
--exec $MYSQL --default-character-set utf8mb3 test -e "create table t1 (i int, j int not null, k int);

--
-- Bug#19564: mysql displays NULL instead of space
--
--exec $MYSQL test -e "create table b19564 (i int, s1 char(1));

--
-- Bug#21618: NULL shown as empty string in client
--
--exec $MYSQL test -e "select concat(null);

-- Bug#19265 describe command does not work from mysql prompt
--

create table t1(a int, b varchar(255), c int);
drop table t1;

--
-- Bug#21042  	mysql client segfaults on importing a mysqldump export
--
--error 1
--exec $MYSQL test -e "connect verylongdatabasenamethatshouldblowthe256byteslongbufferincom_connectfunctionxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxkxendcccccccdxxxxxxxxxxxxxxxxxkskskskskkskskskskskskskskskskkskskskskkskskskskskskskskskend" 2>&1

--
-- Bug #20432: mysql client interprets commands in comments
--

--let $file = $MYSQLTEST_VARDIR/tmp/bug20432.sql

-- if the client sees the 'use' within the comment, we haven't fixed
--exec echo "/*"          >  $file
--exec echo "use"         >> $file
--exec echo "*/"          >> $file
--exec $MYSQL              < $file 2>&1

-- SQL can have embedded comments => workie
--exec echo "select /*"   >  $file
--exec echo "use"         >> $file
--exec echo "*/ 1"        >> $file
--exec $MYSQL              < $file 2>&1

-- client commands on the other hand must be at BOL => error
--exec echo "/*"          >  $file
--exec echo "xxx"         >> $file
--exec echo "*/ use"      >> $file
--error 1
--exec $MYSQL              < $file 2>&1

-- client comment recognized, but parameter missing => error
--exec echo "use"         >  $file
--exec $MYSQL              < $file 2>&1

--remove_file $file

--
-- Bug #20328: mysql client interprets commands in comments
--
--let $file1 = $MYSQLTEST_VARDIR/tmp/bug20328_1.result
--let $file2 = $MYSQLTEST_VARDIR/tmp/bug20328_2.result
--exec $MYSQL -e "help" > $file1
--exec $MYSQL -e "help " > $file2
--diff_files $file1 $file2
--remove_file $file1
--remove_file $file2

--
-- Bug #19216: Client crashes on long SELECT
--
-- Create large SELECT
-- - 3400 * 20 makes 68000 columns that is more than the
--   max number that can fit in a 16 bit number.

--perl
open(FILE,">","$ENV{'MYSQLTEST_VARDIR'}/tmp/b19216.tmp") or die;
EOF

--disable_query_log
--exec $MYSQL < $MYSQLTEST_VARDIR/tmp/b19216.tmp >/dev/null
--enable_query_log

--remove_file $MYSQLTEST_VARDIR/tmp/b19216.tmp

--
-- Bug #20103: Escaping with backslash does not work
--
--let $file = $MYSQLTEST_VARDIR/tmp/bug20103.sql
--exec echo "SET SQL_MODE = 'NO_BACKSLASH_ESCAPES';

--
-- Bug#17583: mysql drops connection when stdout is not writable
--
create table t17583 (a int);
insert into t17583 (a) values (0),(1),(2),(3),(4),(5),(6),(7),(8),(9);
insert into t17583 select a from t17583;
insert into t17583 select a from t17583;
insert into t17583 select a from t17583;
insert into t17583 select a from t17583;
insert into t17583 select a from t17583;
insert into t17583 select a from t17583;
insert into t17583 select a from t17583;
select count(*) from t17583;
drop table t17583;

--
-- Bug#20984: Reproducible MySQL client segmentation fault
--  + additional tests for the "com_connect" function in mysql
--
--
--echo Test connect without db- or host-name => reconnect
--exec $MYSQL test -e "\r" 2>&1
--exec $MYSQL test -e "connect" 2>&1

--echo Test connect with dbname only => new dbname, old hostname
--exec $MYSQL test -e "\r test" 2>&1
--exec $MYSQL test -e "connect test" 2>&1
--exec $MYSQL test -e "\rtest" 2>&1
--error 1
--exec $MYSQL test -e "connecttest" 2>&1

--echo Test connect with _invalid_ dbname only => new invalid dbname, old hostname
--error 1
--exec $MYSQL test -e "\r invalid" 2>&1
--error 1
--exec $MYSQL test -e "connect invalid" 2>&1

--echo Test connect with dbname + hostname
--exec $MYSQL test -e "\r test localhost" 2>&1
--exec $MYSQL test -e "connect test localhost" 2>&1

--echo Test connect with dbname + _invalid_ hostname
-- Mask the errno of the error message
--replace_regex /\([-0-9]*\)/(errno)/
--error 1
--exec $MYSQL test -e "\r test invalid_hostname" 2>&1
--replace_regex /\([-0-9]*\)/(errno)/
--error 1
--exec $MYSQL test -e "connect test invalid_hostname" 2>&1

--echo The commands reported in the bug report
--replace_regex /\([-0-9]*\)/(errno)/
--error 1
--exec $MYSQL test -e "\r\r\n\r\n cyril\ has\ found\ a\ bug\ :)XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" 2>&1

----replace_regex /\([-0-9]*\)/(errno)/
----error 1
----exec echo '\r\r\n\r\n cyril\ has\ found\ a\ bug\ :)XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' | $MYSQL 2>&1

--echo Too long dbname
--error 1
--exec $MYSQL test -e "\r test_really_long_dbnamexxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx localhost" 2>&1

--echo Too long hostname
--replace_regex /\([-0-9]*\)/(errno)/
--error 1
--exec $MYSQL test -e "\r  test cyrils_superlonghostnameXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" 2>&1


--
-- Bug #21412: mysql cmdline client allows backslash(es) 
-- as delimiter but can't recognize them
--

-- This should work just fine...
--write_file $MYSQLTEST_VARDIR/tmp/bug21412.sql
DELIMITER /
SELECT 1/
EOF
--exec $MYSQL             < $MYSQLTEST_VARDIR/tmp/bug21412.sql 2>&1
remove_file $MYSQLTEST_VARDIR/tmp/bug21412.sql;

-- This should give an error...
--write_file $MYSQLTEST_VARDIR/tmp/bug21412.sql
DELIMITER \
EOF
--exec $MYSQL             < $MYSQLTEST_VARDIR/tmp/bug21412.sql 2>&1
remove_file $MYSQLTEST_VARDIR/tmp/bug21412.sql;

-- As should this...
--write_file $MYSQLTEST_VARDIR/tmp/bug21412.sql
DELIMITER \\
EOF
--exec $MYSQL             < $MYSQLTEST_VARDIR/tmp/bug21412.sql 2>&1
remove_file $MYSQLTEST_VARDIR/tmp/bug21412.sql;

--
-- Some coverage of not normally used parts
--

--disable_query_log
--exec $MYSQL test -e "show status" 2>&1 > /dev/null
--exec $MYSQL --help 2>&1 > /dev/null
--exec $MYSQL --version 2>&1 > /dev/null
--enable_query_log

--
-- bug #26851: Mysql Client --pager Buffer Overflow
--

-- allow error 7(invalid argument) since --pager does not always exist in mysql
--error 0,7
--exec $MYSQL --pager="540bytelengthstringxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" -e "select 1" > /dev/null 2>&1
--exec $MYSQL --character-sets-dir="540bytelengthstringxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" -e "select 1" 2>&1

--
-- bug #30164: Using client side macro inside server side comments generates broken queries
--
--exec $MYSQL test -e "/*! \C latin1 */ select 1;

--
-- Bug#29323 mysql client only accetps ANSI encoded files
--
--write_file $MYSQLTEST_VARDIR/tmp/bug29323.sql
﻿select "This is a file starting with utf8mb3 BOM 0xEFBBBF";
EOF
--exec $MYSQL < $MYSQLTEST_VARDIR/tmp/bug29323.sql 2>&1
remove_file $MYSQLTEST_VARDIR/tmp/bug29323.sql;

--
-- Bug #33812: mysql client incorrectly parsing DELIMITER
--
-- The space and ;

--
-- Bug #38158: mysql client regression, can't read dump files
--
--write_file $MYSQLTEST_VARDIR/tmp/bug38158.sql
-- Testing
--
delimiter ||
select 2 ||
EOF
--exec $MYSQL < $MYSQLTEST_VARDIR/tmp/bug38158.sql 2>&1
--exec $MYSQL -c < $MYSQLTEST_VARDIR/tmp/bug38158.sql 2>&1
remove_file $MYSQLTEST_VARDIR/tmp/bug38158.sql;

--
-- Bug #41437: Value stored in 'case' lacks charset, causees segfault
--
--exec $MYSQL -e "select @z:='1',@z=database()"


--
-- Bug #31060: MySQL CLI parser bug 2
--

--write_file $MYSQLTEST_VARDIR/tmp/bug31060.sql
;
SELECT 1DELIMITER
DELIMITER ;
SELECT 1;
EOF

--exec $MYSQL < $MYSQLTEST_VARDIR/tmp/bug31060.sql 2>&1

remove_file $MYSQLTEST_VARDIR/tmp/bug31060.sql;

--
-- Bug #39101: client -i (--ignore-spaces) option does not seem to work
--
--exec $MYSQL -i -e "SELECT COUNT (*)"
--exec $MYSQL --ignore-spaces -e "SELECT COUNT (*)"
--exec $MYSQL -b -i -e "SELECT COUNT (*)"

--
-- Bug#37268 'binary' character set makes CLI-internal commands case sensitive
--
--replace_regex /\([-0-9]*\)/(errno)/
--error 1
--exec $MYSQL --default-character-set=binary test -e "CONNECT test invalid_hostname" 2>&1
--exec $MYSQL --default-character-set=binary test -e "DELIMITER //" 2>&1

--echo End of 5.0 tests

--
-- Bug#26780: patch to add auto vertical output option to the cli.
--
-- Make this wide enough that it will wrap almost everywhere.
--exec $MYSQL test --auto-vertical-output --table -e "SELECT 1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0,1,2,3,4,5,6,7,8,9,0;

--
-- Bug #25146: Some warnings/errors not shown when using --show-warnings
--

SET @@global.sql_mode='';

-- This one should succeed with no warnings
--exec $MYSQL --show-warnings test -e "create table t1 (id int)"

-- This should succeed, with warnings about conversion from nonexistent engine
--exec $MYSQL --show-warnings test -e "create table t2 (id int) engine=nonexistent"

-- This should fail, with warnings as well
--error 1
--exec $MYSQL --show-warnings test -e "create table t2 (id int) engine=nonexistent2"

drop tables t1, t2;

SET @@global.sql_mode=DEFAULT;

--
-- mysql client with 'init-command' and 'init-command-add' options
-- WL#15662: Add options to mysqldump to skip views and utilize read ahead
--
--echo "Only with --init-command ============================================="
--exec $MYSQL --init-command="SET lc_messages=ru_RU" -e "SHOW VARIABLES LIKE 'lc_messages';
DROP DATABASE init_command_db_2;

--
-- Bug #27884: mysql --html does not quote HTML special characters in output
--
--write_file $MYSQLTEST_VARDIR/tmp/bug27884.sql
SELECT '< & >' AS `<`;
EOF
--exec $MYSQL --html test < $MYSQLTEST_VARDIR/tmp/bug27884.sql

remove_file $MYSQLTEST_VARDIR/tmp/bug27884.sql;


--
-- Bug #28203: mysql client + null byte
-- 
create table t1 (a char(5));
insert into t1 values ('\0b\0');
drop table t1;

--
-- Bug#57450: mysql client enter in an infinite loop if the standard input is a directory
--
--error 1
--exec $MYSQL < .

--echo

--echo --
--echo -- Bug #54899: --one-database option cannot handle DROP/CREATE DATABASE 
--echo --             commands.
--echo --
--write_file $MYSQLTEST_VARDIR/tmp/bug54899.sql
DROP DATABASE connected_db;
CREATE DATABASE connected_db;
USE connected_db;
CREATE TABLE `table_in_connected_db`(a INT);
EOF

CREATE DATABASE connected_db;
USE connected_db;
DROP DATABASE connected_db;
CREATE TABLE t1 (i INT);
CREATE TABLE test.t1 (i INT);
USE test;
CREATE TABLE connected_db.t2 (i INT);
CREATE TABLE t2 (i INT);
EOF

CREATE DATABASE connected_db;
USE test;
DROP TABLE t1;
DROP DATABASE connected_db;
CREATE DATABASE test1;
USE test1;
USE test1;
CREATE TABLE connected_db.t1 (i INT);
EOF

--exec $MYSQL --one-database test < $MYSQLTEST_VARDIR/tmp/one_db.sql
SHOW TABLES IN test;
DROP DATABASE test1;
CREATE TABLE t1 (i INT);
CREATE TABLE test.t1 (i INT);
CREATE TABLE connected_db.t2 (i INT);
CREATE TABLE t2 (i INT);
USE connected_db;
CREATE TABLE connected_db.t3 (i INT);
CREATE TABLE t3 (i INT);
EOF

CREATE DATABASE connected_db;
DROP TABLE test.t1;
DROP TABLE test.t2;
DROP DATABASE connected_db;
CREATE TABLE t1 (i INT);
CREATE TABLE test.t1 (i INT);
USE test;
CREATE TABLE test.t2 (i INT);
CREATE TABLE t2 (i INT);
EOF

--exec $MYSQL --one-database < $MYSQLTEST_VARDIR/tmp/one_db.sql
SHOW TABLES IN test;

-- CASE 1 : When 'connected_db' database exists and passed at commandline.
--write_file $MYSQLTEST_VARDIR/tmp/one_db_1.sql
CREATE TABLE `table_in_connected_db`(i INT);
USE non_existent_db;
CREATE TABLE `table_in_non_existent_db`(i INT);
EOF

-- CASE 2 : When 'connected_db' database exists but dropped and recreated in
-- load file.
--write_file $MYSQLTEST_VARDIR/tmp/one_db_2.sql
DROP DATABASE connected_db;
CREATE DATABASE connected_db;
USE non_existent_db;
CREATE TABLE `table_in_non_existent_db`(i INT);
USE connected_db;
CREATE TABLE `table_in_connected_db`(i INT);
EOF

CREATE DATABASE connected_db;
DROP DATABASE connected_db;

--
-- WL#3126 TCP address binding for mysql client library;

--
-- WL#6797 Method for clearing session state
--

--write_file $MYSQLTEST_VARDIR/tmp/WL6797.sql

-- this case is added for code coverage
-- clean session state
resetconnection;
CREATE DATABASE wl6797;
USE wl6797;
CREATE TABLE t1 (a int);
SELECT * FROM t1 ORDER BY 1;
EOF

--write_file $MYSQLTEST_VARDIR/tmp/WL6797_cleanup.sql
DROP TABLE wl6797.t1;
DROP DATABASE wl6797;
EOF

--error 1
--exec $MYSQL < $MYSQLTEST_VARDIR/tmp/WL6797.sql 2>&1
--remove_file $MYSQLTEST_VARDIR/tmp/WL6797.sql
--exec $MYSQL < $MYSQLTEST_VARDIR/tmp/WL6797_cleanup.sql 2>&1
--remove_file $MYSQLTEST_VARDIR/tmp/WL6797_cleanup.sql


--echo --
--echo -- Bug #16102788: INDETERMINATE BEHAVIOR DUE TO EMPTY OPTION VALUES
--echo --

--replace_regex /mysql: .ERROR. [^ ]*: Empty value for 'port' specified/mysql: [ERROR] mysql: Empty value for 'port' specified/
--error 5
--exec $MYSQL --port= -e "SELECT 1" 2>&1

--replace_regex /mysql: .ERROR. [^ ]*: Empty value for 'port' specified/mysql: [ERROR] mysql: Empty value for 'port' specified/
--error 5
--exec $MYSQL -P "" -e "SELECT 1" 2>&1

--echo --
--echo -- Bug #21464621: MYSQL CLI SHOULD SUGGEST CONNECT-EXPIRED-PASSWORD WHEN ERROR 1862 OCCURS
--echo --

CREATE USER bug21464621 IDENTIFIED BY 'password' PASSWORD EXPIRE;
DROP USER bug21464621;
SELECT "1comment prev line prior to delimiter no end" AS "what"//
delimiter ;
SELECT "2check if delimiter is restored" AS "what";
SELECT "3ml comment same line as delimier no end" AS "what"//
delimiter ;
SELECT "4check if delimiter is restored" AS "what";
SELECT "5single line comment prior to delimiter no end" AS "what"//
delimiter ;
SELECT "6check if delimiter is restored" AS "what";
SELECT "7two comments back to back" AS "what"o
delimiter ;
select "8check if delimiter is restored" AS "what";
EOF

--echo -- Test: must pass without an error
exec $MYSQL < $MYSQLTEST_VARDIR/tmp/bug35290350.sql;
