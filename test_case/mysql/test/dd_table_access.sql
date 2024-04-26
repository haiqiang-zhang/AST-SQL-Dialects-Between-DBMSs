{
  --echo --
  --echo -- WL#6391: Hide DD tables.
  --echo --
  --echo -- Prohibit access to the DD tables from user submitted
  --echo -- SQL statements, but allow DD initialization to execute
  --echo -- such statements.
  --echo --

  --source include/have_debug.inc

  --echo -- DD schema DDL
  --error ER_NO_SYSTEM_SCHEMA_ACCESS
  DROP SCHEMA mysql;
  CREATE SCHEMA mysql;
  ALTER SCHEMA mysql DEFAULT COLLATE utf8mb3_general_ci;
  DROP TABLESPACE mysql;
  CREATE TABLESPACE mysql ADD DATAFILE 'new_file.ibd';
  ALTER TABLESPACE mysql ADD DATAFILE 'new_file.ibd';
  CREATE TABLE table_not_white_listed (pk INTEGER PRIMARY KEY) TABLESPACE mysql;

  USE mysql;
  CREATE TABLE t (pk BIGINT UNSIGNED PRIMARY KEY);
  SET @@global.innodb_stats_auto_recalc= OFF;
  SELECT @old_description:= stat_description FROM  mysql.innodb_index_stats
    WHERE database_name= 'mysql' AND table_name= 't' AND
          index_name= 'PRIMARY' AND stat_name= 'size';
  UPDATE mysql.innodb_index_stats SET stat_description= 'Updated'
    WHERE database_name= 'mysql' AND table_name= 't' AND
          index_name= 'PRIMARY' AND stat_name= 'size';
  SELECT stat_description FROM mysql.innodb_index_stats
    WHERE database_name= 'mysql' AND table_name= 't' AND
          index_name= 'PRIMARY' AND stat_name= 'size';
  UPDATE mysql.innodb_index_stats SET stat_description= @old_description
    WHERE database_name= 'mysql' AND table_name= 't' AND
          index_name= 'PRIMARY' AND stat_name= 'size';
  DROP TABLE mysql.innodb_index_stats;
  CREATE TABLE mysql.innodb_index_stats(i INTEGER);
  CREATE TABLE t1 SELECT * FROM mysql.innodb_index_stats;
  DROP TABLE t1;
  CREATE TABLE t1 LIKE mysql.innodb_index_stats;
  CREATE PROCEDURE ddse_access() CREATE TABLE mysql.innodb_index_stats(i INTEGER);
  CREATE PROCEDURE ddse_access() DROP TABLE mysql.innodb_index_stats(i INTEGER);
  ALTER TABLE mysql.innodb_index_stats COMMENT 'Altered';
  SELECT TABLE_NAME, TABLE_COMMENT FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='innodb_index_stats';
  ALTER TABLE mysql.innodb_index_stats COMMENT '';
  SET @@global.innodb_stats_auto_recalc= default;

  DROP TABLE t;
}


--echo --
--echo -- DD table access in LOAD statements.
--echo --
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval LOAD DATA INFILE 'no_such_file' INTO TABLE $TABLE

--echo --
--echo -- DD table access in HANDLER statements.
--echo --
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval HANDLER $TABLE OPEN

--echo --
--echo -- DD table visibility in I_S.
--echo --
--echo -- A SELECT statement will not fail, since the table names are submitted as strings in WHERE clauses.
--eval SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = '$TABLE' AND TABLE_SCHEMA = 'mysql'
--echo -- A SHOW statement will fail because the table name is interpreted as a table name, not as a string.
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval SHOW CREATE TABLE $TABLE

--echo --
--echo -- DD table access in DDL.
--echo --
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval DROP TABLE $TABLE
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval CREATE TABLE $TABLE (i INTEGER)
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval CREATE TABLE new_tab LIKE $TABLE
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval CREATE TABLE new_tab SELECT * FROM $TABLE
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval ALTER TABLE $TABLE ADD COLUMN (new_col INTEGER)
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval TRUNCATE TABLE $TABLE
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval RENAME TABLE $TABLE TO new_tab
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval RENAME TABLE t TO $TABLE

--echo --
--echo -- DD table access in DML.
--echo --
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval SELECT * from $TABLE
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval SELECT * from t WHERE t.pk = (SELECT COUNT(*) FROM $TABLE)
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval DELETE FROM $TABLE
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval UPDATE $TABLE SET id= 0 WHERE ID= 1
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval INSERT INTO $TABLE VALUES (1)

--echo --
--echo -- DD table access from views.
--echo --
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval CREATE VIEW new_view AS SELECT * FROM $TABLE

--echo --
--echo -- DD table access from stored programs.
--echo --
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval CREATE PROCEDURE dd_access() SELECT * FROM $TABLE
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval CREATE FUNCTION dd_access() RETURNS INTEGER RETURN (SELECT COUNT(*) FROM $TABLE)

--echo --
--echo -- DD table access from prepared statements (the '?' placeholders cannot be used for meta data).
--echo --
--error ER_NO_SYSTEM_TABLE_ACCESS
--eval PREPARE ps FROM 'DROP TABLE $TABLE';
