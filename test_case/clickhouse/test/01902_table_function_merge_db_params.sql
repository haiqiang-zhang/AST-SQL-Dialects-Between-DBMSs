SELECT _database, _table, n FROM merge(REGEXP('^01902_db_params'), '^t') ORDER BY _database, _table, n;
USE 01902_db_params;
DROP DATABASE 01902_db_params;
