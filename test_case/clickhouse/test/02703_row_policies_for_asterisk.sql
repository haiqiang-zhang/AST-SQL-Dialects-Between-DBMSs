SELECT 'Policy for table `*` does not affect other tables in the database';
CREATE DATABASE 02703_db_asterisk;
CREATE TABLE 02703_db_asterisk.`*` (x UInt8, y UInt8) ENGINE = MergeTree ORDER BY x AS SELECT 100, 20;
CREATE TABLE 02703_db_asterisk.`other` (x UInt8, y UInt8) ENGINE = MergeTree ORDER BY x AS SELECT 100, 20;
SELECT 'star', * FROM 02703_db_asterisk.`*`;
SELECT 'other', * FROM 02703_db_asterisk.other;
DROP DATABASE 02703_db_asterisk;
