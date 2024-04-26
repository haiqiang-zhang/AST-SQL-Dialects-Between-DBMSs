
-- Warning is generated when default file (NULL) is used
CALL mtr.add_suppression("Could not parse key-value pairs in property string.*");

SET SESSION information_schema_stats_expiry=0;
SET SESSION debug= "+d,information_schema_fetch_table_stats";
CREATE TABLE t1 (a VARCHAR(200), b TEXT, FULLTEXT (a,b));
INSERT INTO t1 VALUES ('a','b');
SELECT table_name, cardinality  FROM INFORMATION_SCHEMA.STATISTICS
  WHERE cardinality > 0 and table_schema='test';
DROP TABLE t1;

SET SESSION debug= "-d,information_schema_fetch_table_stats";
SET SESSION information_schema_stats_expiry=default;

CREATE TABLE t1(i INT);

SET SESSION debug="+d,sim_acq_fail_in_store_ci";

SET SESSION debug="";
DROP TABLE t1;
CREATE TABLE t1(f1 INT, s VARCHAR(10));
SELECT TABLE_NAME, CREATE_OPTIONS FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_NAME='t1';
SET debug = '+d,skip_dd_table_access_check';
update mysql.tables set options=concat(options,"abc") where name='t1';
SET debug = '+d,continue_on_property_string_parse_failure';
SELECT TABLE_NAME, CREATE_OPTIONS FROM INFORMATION_SCHEMA.TABLES
  WHERE TABLE_NAME='t1';
SET debug = DEFAULT;
DROP TABLE t1;
let SEARCH_FILE= $MYSQLTEST_VARDIR/log/mysqld.1.err;
CREATE TABLE t1 (f1 INT );
SET DEBUG_SYNC="after_statement_reprepare SIGNAL flush_tables WAIT_FOR continue";
SET DEBUG_SYNC="now WAIT_FOR flush_tables";
SET DEBUG="+d,skip_dd_table_access_check";
SET DEBUG="-d,skip_dd_table_access_check";
SET DEBUG_SYNC="now SIGNAL continue";
SELECT * FROM INFORMATION_SCHEMA.EVENTS, t2;
SELECT * FROM INFORMATION_SCHEMA.EVENTS, t2;

-- Cleanup
DISCONNECT con1;
DROP TABLE t1;
DROP PREPARE stmt;
SET DEBUG_SYNC=RESET;

CREATE SCHEMA s;
SELECT SCHEMA_NAME, OPTIONS FROM INFORMATION_SCHEMA.SCHEMATA_EXTENSIONS
  WHERE SCHEMA_NAME = 's';

SET debug = '+d,skip_dd_table_access_check';
UPDATE mysql.schemata SET options = 'abc' WHERE name = 's';
SELECT options FROM mysql.schemata WHERE name = 's';

SET debug = '+d,continue_on_property_string_parse_failure';
SELECT SCHEMA_NAME, OPTIONS FROM INFORMATION_SCHEMA.SCHEMATA_EXTENSIONS
  WHERE SCHEMA_NAME = 's';

SET debug = DEFAULT;
DROP SCHEMA s;
let SEARCH_FILE= $MYSQLTEST_VARDIR/log/mysqld.1.err;
