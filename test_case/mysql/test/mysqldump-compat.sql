
--
-- Bug #30126: semicolon before closing */ in /*!... CREATE DATABASE ;
--

--let $file = $MYSQLTEST_VARDIR/tmp/bug30126.sql

CREATE DATABASE mysqldump_30126;
USE mysqldump_30126;
CREATE TABLE t1 (c1 int);
DROP DATABASE mysqldump_30126;
