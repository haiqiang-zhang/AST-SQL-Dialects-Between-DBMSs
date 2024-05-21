SET send_logs_level = 'fatal';
SET allow_ddl = 0;
CREATE TABLE some_table(a Int32) ENGINE = Memory;
ALTER TABLE some_table DELETE WHERE 1;
RENAME TABLE some_table TO some_table1;
SET allow_ddl = 1;
