--

--echo -- Create the test database
CREATE DATABASE bug_test;
USE bug_test;
CREATE TABLE bug(n INT);
INSERT INTO bug VALUES(10);
INSERT INTO bug VALUES(20);
INSERT INTO bug VALUES(30);
CREATE USER test@localhost;
let $mysqldumpfile = $MYSQLTEST_VARDIR/tmp/bug35020512_dump.sql;

-- Cleanup
DROP USER test@localhost;
DROP DATABASE bug_test;
