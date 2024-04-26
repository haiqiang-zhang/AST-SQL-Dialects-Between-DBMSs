DROP DATABASE sys;
DROP PROCEDURE sys.ps_setup_save;
DROP PROCEDURE sys.ps_setup_reload_saved;
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'sys' AND ROUTINE_TYPE = 'PROCEDURE';

-- Filter out ndb_binlog_index to mask differences due to running with or
-- without ndb.
--let $restart_parameters = restart:--upgrade=FORCE
--let $wait_counter= 10000
--source include/restart_mysqld.inc
--sorted_result
SELECT ROUTINE_NAME FROM INFORMATION_SCHEMA.ROUTINES WHERE ROUTINE_SCHEMA = 'sys' AND ROUTINE_TYPE = 'FUNCTION';
DROP VIEW sys.host_summary;
DROP VIEW sys.processlist;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sys' AND TABLE_TYPE = 'VIEW' ORDER BY TABLE_NAME;
DROP TRIGGER sys.sys_config_insert_set_user;
DROP TRIGGER sys.sys_config_update_set_user;
SELECT TRIGGER_NAME FROM INFORMATION_SCHEMA.TRIGGERS WHERE TRIGGER_SCHEMA = 'sys';
DROP TABLE sys.sys_config;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'sys' AND TABLE_TYPE = 'BASE TABLE';
SET sql_mode= (SELECT replace(@@sql_mode,'NO_ZERO_DATE',''));
SET sql_mode= (SELECT replace(@@sql_mode,'STRICT_TRANS_TABLES',''));
CREATE TABLE mysql.db_backup SELECT * FROM mysql.db;

ALTER TABLE mysql.tables_priv
  MODIFY User char(16) NOT NULL default '',
  MODIFY Grantor char(77) DEFAULT '' NOT NULL;
ALTER TABLE mysql.columns_priv
  MODIFY User char(16) NOT NULL default '';
ALTER TABLE mysql.user
  MODIFY User char(16) NOT NULL default '';
ALTER TABLE mysql.db
  MODIFY User char(16) NOT NULL default '';
ALTER TABLE mysql.procs_priv
  MODIFY User char(16) binary DEFAULT '' NOT NULL,
  MODIFY Grantor char(77) DEFAULT '' NOT NULL;

ALTER TABLE mysql.proxies_priv MODIFY User char(16) binary DEFAULT '' NOT NULL;
ALTER TABLE mysql.proxies_priv MODIFY Proxied_user char(16) binary DEFAULT '' NOT NULL;
ALTER TABLE mysql.proxies_priv MODIFY Grantor char(77) DEFAULT '' NOT NULL;

-- Restore the saved contents of mysql.user and mysql.tables_priv
--let $restore= 1
--source include/backup_tables_priv_and_users.inc

--Restore mysql.db table
TRUNCATE TABLE mysql.db;
INSERT INTO mysql.db SELECT * FROM mysql.db_backup;
DROP TABLE mysql.db_backup;
