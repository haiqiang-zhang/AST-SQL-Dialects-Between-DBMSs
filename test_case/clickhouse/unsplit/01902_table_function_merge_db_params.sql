DROP DATABASE IF EXISTS 01902_db_params;
CREATE DATABASE 01902_db_params;
CREATE TABLE 01902_db_params.t(n Int8) ENGINE=MergeTree ORDER BY n;
INSERT INTO 01902_db_params.t SELECT * FROM numbers(3);
SELECT _database, _table, n FROM merge(REGEXP('^01902_db_params'), '^t') ORDER BY _database, _table, n;
USE 01902_db_params;
DROP DATABASE 01902_db_params;
