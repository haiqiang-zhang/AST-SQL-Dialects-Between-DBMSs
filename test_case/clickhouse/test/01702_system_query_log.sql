-- fire all kinds of queries and then check if those are present in the system.query_log
SET log_comment='system.query_log logging test';
SELECT 'DROP queries and also a cleanup before the test';
DROP DATABASE IF EXISTS sqllt SYNC;
DROP USER IF EXISTS sqllt_user;
DROP ROLE IF EXISTS sqllt_role;
DROP POLICY IF EXISTS sqllt_policy ON sqllt.table, sqllt.view, sqllt.dictionary;
DROP ROW POLICY IF EXISTS sqllt_row_policy ON sqllt.table, sqllt.view, sqllt.dictionary;
DROP QUOTA IF EXISTS sqllt_quota;
DROP SETTINGS PROFILE IF EXISTS sqllt_settings_profile;
SELECT 'CREATE queries';
CREATE DATABASE sqllt;
CREATE TABLE sqllt.table
(
    i UInt8, s String
)
ENGINE = MergeTree PARTITION BY tuple() ORDER BY tuple();
CREATE VIEW sqllt.view AS SELECT i, s FROM sqllt.table;
CREATE DICTIONARY sqllt.dictionary (key UInt64, value UInt64) PRIMARY KEY key SOURCE(CLICKHOUSE(DB 'sqllt' TABLE 'table' HOST 'localhost' PORT 9001)) LIFETIME(0) LAYOUT(FLAT());
SELECT 'SET queries';
SET log_profile_events=false;
SELECT 'ALTER TABLE queries';
ALTER TABLE sqllt.table ADD COLUMN new_col UInt32 DEFAULT 123456789;
ALTER TABLE sqllt.table COMMENT COLUMN new_col 'dummy column with a comment';
ALTER TABLE sqllt.table CLEAR COLUMN new_col;
ALTER TABLE sqllt.table MODIFY COLUMN new_col DateTime DEFAULT '2015-05-18 07:40:13';
ALTER TABLE sqllt.table MODIFY COLUMN new_col REMOVE COMMENT;
ALTER TABLE sqllt.table RENAME COLUMN new_col TO the_new_col;
ALTER TABLE sqllt.table DROP COLUMN the_new_col;
ALTER TABLE sqllt.table UPDATE i = i + 1 WHERE 1;
ALTER TABLE sqllt.table DELETE WHERE i > 65535;
-- PARTITION
-- ORDER BY
-- SAMPLE BY
-- INDEX
-- CONSTRAINT
-- TTL
-- USER
-- QUOTA
-- ROLE
-- ROW POLICY
-- SETTINGS PROFILE

SELECT 'SYSTEM queries';
SYSTEM FLUSH LOGS;
SYSTEM STOP MERGES sqllt.table;
SYSTEM START MERGES sqllt.table;
SYSTEM STOP TTL MERGES sqllt.table;
SYSTEM START TTL MERGES sqllt.table;
SYSTEM STOP MOVES sqllt.table;
SYSTEM START MOVES sqllt.table;
SYSTEM STOP FETCHES sqllt.table;
SYSTEM START FETCHES sqllt.table;
SYSTEM STOP REPLICATED SENDS sqllt.table;
SYSTEM START REPLICATED SENDS sqllt.table;
SELECT 'GRANT queries';
SELECT 'REVOKE queries';
SELECT 'Misc queries';
DETACH TABLE sqllt.table;
ATTACH TABLE sqllt.table;
RENAME TABLE sqllt.table TO sqllt.table_new;
RENAME TABLE sqllt.table_new TO sqllt.table;
TRUNCATE TABLE sqllt.table;
DROP TABLE sqllt.table SYNC;
SET log_comment='';
-- Now get all logs related to this test
---------------------------------------------------------------------------------------------------

SYSTEM FLUSH LOGS;
SELECT 'ACTUAL LOG CONTENT:';
SELECT 'DROP queries and also a cleanup after the test';
DROP DATABASE IF EXISTS sqllt;
DROP USER IF EXISTS sqllt_user;
DROP ROLE IF EXISTS sqllt_role;
DROP POLICY IF EXISTS sqllt_policy ON sqllt.table, sqllt.view, sqllt.dictionary;
DROP ROW POLICY IF EXISTS sqllt_row_policy ON sqllt.table, sqllt.view, sqllt.dictionary;
DROP QUOTA IF EXISTS sqllt_quota;
DROP SETTINGS PROFILE IF EXISTS sqllt_settings_profile;
