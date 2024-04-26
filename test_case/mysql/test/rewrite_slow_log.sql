--

--source include/not_windows.inc

-- For Bug#16467055 and friends:

-- make sure we start with a clean slate. log_tables.test says this is OK.
TRUNCATE TABLE mysql.slow_log;

SET @old_log_output=          @@global.log_output;
SET @old_slow_query_log=      @@global.slow_query_log;
SET @old_slow_query_log_file= @@global.slow_query_log_file;
SET @old_long_query_time=     @@global.long_query_time;
SET GLOBAL log_output =       'FILE,TABLE';
SET GLOBAL slow_query_log=    'ON';

-- The answer is obvious: log everything!
SET SESSION long_query_time=  0;

-- Show that obfuscation applies to the slow log at all.
-- If one applies, they all do, and we've already demonstrated the individual
-- obfuscations above for the general log.

-- 1.1.1.1
CREATE USER test_user2 IDENTIFIED BY 'azundris2';
SET SESSION long_query_time = 0;
ALTER USER test_user2 IDENTIFIED BY 'azundris2' REPLACE 'azundris2';
SET PASSWORD='azundris2' REPLACE 'azundris2';
SET PASSWORD FOR test_user2='azundris2' REPLACE 'azundris2';

-- 1.1.1.2

--disable_warnings
CHANGE REPLICATION SOURCE TO SOURCE_PASSWORD='azundris3',
  SOURCE_BIND = 'eth4n',
  SOURCE_TLS_CIPHERSUITES = ''
  FOR CHANNEL 'chan_jackie';

-- 1.1.1.3
CREATE USER 'test_user4'@'localhost';
SET PASSWORD FOR 'test_user4'@'localhost' = 'azundris4';

-- clean-up
SET SESSION long_query_time=  @old_long_query_time;
SET GLOBAL slow_query_log='OFF';

DROP USER 'test_user4'@'localhost';
DROP USER test_user2;

let $wait_condition= SELECT sql_text FROM mysql.slow_log WHERE sql_text LIKE "%SET PASSWORD FOR `test_user4`@`localhost`%";

-- show slow-logging to file is correct
CREATE TABLE test_log (sql_text TEXT);
     INTO TABLE test_log FIELDS TERMINATED BY '\n' LINES TERMINATED BY '\n';

-- all passwords ('azundris%') must have been obfuscated -> empty result set
--echo This line should be followed by two SELECTs with empty result sets
SELECT sql_text FROM test_log WHERE sql_text LIKE CONCAT('%azun','dris%');

-- same for logging to table
SELECT sql_text FROM mysql.slow_log WHERE sql_text LIKE CONCAT('%azun','dris%');

-- WL#11544 verification : Replace clause should be seen in the log.
-- In case of ps-protocol, it will be seen twice.
SELECT count(*)=1 OR count(*)=2 FROM mysql.slow_log WHERE sql_text LIKE '%REPLACE%';
SELECT count(*)=1 OR count(*)=2 FROM test_log WHERE sql_text LIKE 'CREATE USER %' AND sql_text LIKE '%<secret>%';
SELECT sql_text FROM test_log WHERE sql_text LIKE 'CHANGE REPLICATION SOURCE TO SOURCE_BIND %';
SELECT count(*) FROM test_log WHERE sql_text LIKE 'SET PASSWORD %' AND sql_text LIKE '%<secret>%';
SELECT count(*)=1 OR count(*)=2 FROM mysql.slow_log WHERE sql_text LIKE 'CREATE USER %' AND sql_text LIKE '%<secret>%';
SELECT sql_text FROM test_log WHERE sql_text LIKE 'CHANGE REPLICATION SOURCE TO SOURCE_BIND %';
SELECT count(*) FROM test_log WHERE sql_text LIKE 'SET PASSWORD %' AND sql_text LIKE '%<secret>%';

DROP TABLE test_log;

SET SESSION long_query_time= 0;
SET GLOBAL slow_query_log  = 1;
SET GLOBAL log_output      = 'TABLE';
let $wait_condition= SELECT "slow -->", sql_text FROM mysql.slow_log WHERE sql_text LIKE "%USER 'u16467055'%";

DROP USER u16467055;

-- clean-up
SET SESSION long_query_time=    @old_long_query_time;
SET GLOBAL  slow_query_log_file=@old_slow_query_log_file;
SET GLOBAL  slow_query_log=     @old_slow_query_log;
SET GLOBAL  log_output=         @old_log_output;
