
-- Session
SELECT @@session.session_track_schema;
SELECT @@session.session_track_system_variables;

-- Global
SELECT @@global.session_track_schema;
SELECT @@global.session_track_system_variables;
SELECT @@session.character_set_client, @@session.character_set_results, @@session.character_set_connection;
SET NAMES 'utf8mb3';
SELECT @@session.character_set_client, @@session.character_set_results, @@session.character_set_connection;
SET NAMES 'big5';
SELECT @@session.character_set_client, @@session.character_set_results, @@session.character_set_connection;
SET @@session.character_set_client=utf8mb3;
SELECT @@session.character_set_client, @@session.character_set_results, @@session.character_set_connection;
SET @@session.character_set_results=utf8mb3;
SELECT @@session.character_set_client, @@session.character_set_results, @@session.character_set_connection;
SET @@session.character_set_connection=utf8mb3;
SELECT @@session.character_set_client, @@session.character_set_results, @@session.character_set_connection;
SELECT @@session.time_zone;

SET @@session.time_zone='Europe/Moscow';
SELECT @@session.time_zone;

SET @@session.time_zone='MET';
SELECT @@session.time_zone;
SET @@session.time_zone='funny';
SELECT @@session.time_zone;
SELECT @@session.autocommit;

SET @@session.autocommit= 1;
SELECT @@session.autocommit;

SET @@session.autocommit= 0;
SELECT @@session.autocommit;

SET @@session.autocommit= OFF;
SELECT @@session.autocommit;

SET @@session.autocommit= ON;
SELECT @@session.autocommit;
SET @@session.autocommit= foo;
SELECT @@session.autocommit;

SET @@session.autocommit=OFF, @@time_zone='SYSTEM';
SELECT @@session.autocommit;
SELECT @@session.time_zone;
SET @@session.autocommit=ON, @@time_zone='INVALID';
SELECT @@session.autocommit;
SELECT @@session.time_zone;
SELECT @@session.sql_mode;

SET @@session.session_track_system_variables='sql_mode';
SELECT @@session.session_track_system_variables;
SET @sql_mode_saved= @@session.sql_mode;
SET @@session.sql_mode='traditional';
SET @@session.sql_mode='traditional';
SELECT @@session.sql_mode;
SET @@session.sql_mode='invalid';
SET @@session.session_track_system_variables='*';
SET @@session.sql_mode= @sql_mode_saved;
SET @@session.session_track_system_variables='';
SET @@session.sql_mode= @sql_mode_saved;
SELECT @@session.sql_mode;
SET @@session.session_track_system_variables=NULL;
SET @@session.sql_mode= @sql_mode_saved;
SELECT @@session.sql_mode;
SET @@session.session_track_system_variables='var1,NULL';
SET @@session.sql_mode= @sql_mode_saved;
SELECT @@session.sql_mode;

SET @@session.session_track_system_variables='autocommit,time_zone,
                                              transaction_isolation';
SELECT @@session.session_track_system_variables;
CREATE PROCEDURE my_proc() BEGIN
  SET @@session.autocommit=OFF;
  SET @@session.time_zone='-6:00';
  SET @@session.transaction_isolation='READ-COMMITTED';
DROP PROCEDURE my_proc;
SET @@session.session_track_system_variables='var1,sql_mode,var2';
SELECT @@session.session_track_system_variables;

SET @@session.sql_mode='ANSI';
SELECT @@session.sql_mode;
SET @@session.sql_mode=@@session.sql_mode;
SET @@session.session_track_system_variables='session_track_system_variables';
SELECT @@session.session_track_system_variables;
SELECT @@session.session_track_schema;

USE mysql;
USE test;
USE non_existing_db;
USE mysql;
USE mysql;
USE test;
SET @@session.session_track_schema=false;
SELECT @@session.session_track_schema;
USE mysql;
USE test;
SET @@session.session_track_schema=ONN;
SELECT @@session.session_track_schema;
USE mysql;
USE test;
SET @@session.session_track_schema=ON;
USE test;
SET @@session.session_track_schema=OFFF;
USE test;
SET @@session.session_track_schema=OFF;
SELECT @@global.session_track_schema;
SELECT @@session.session_track_schema;
SET @@session.session_track_schema=@@global.session_track_schema;
SELECT @@session.session_track_schema;

SELECT @@global.session_track_system_variables;
SELECT @@session.session_track_system_variables;

SET @@session.session_track_system_variables='validate_password_policy,autocommit';

SELECT @@session.session_track_system_variables;
SET @@session.session_track_system_variables='validate_password_policy,autocommit';

CREATE TABLE test.t(i INT);
SET @@session.session_track_state_change=ON;
CREATE TEMPORARY TABLE test.t1(i INT);
DROP TEMPORARY TABLE test.t1;

SET @@session.session_track_state_change=OFF;
CREATE TEMPORARY TABLE test.t1(i INT);
DROP TEMPORARY TABLE test.t1;

CREATE TEMPORARY TABLE test.t1(i INT);
SET @@session.session_track_state_change=ON;
ALTER TABLE test.t1 ADD COLUMN (j INT);
DROP TEMPORARY TABLE test.t1;

SET @@session.session_track_state_change=ON;

SET @@session.session_track_state_change=OFF;

SET @@session.session_track_state_change=ON;
SET NAMES 'utf8mb3';

SET @@session.session_track_state_change=OFF;
SET NAMES 'utf8mb3';

SET @@session.session_track_state_change=ON;
USE test;

SET @@session.session_track_state_change=OFF;
USE test;

SET @@session.session_track_state_change=ON;
SET @var1=20;

SET @@session.session_track_state_change=OFF;
SET @var1=20;

SET @@session.session_track_state_change=ON;
CREATE TEMPORARY TABLE test.t1(i INT);
DROP TEMPORARY TABLE test.t1;

SET @@session.session_track_state_change=ON;
USE test;
SET @var3= 10;
CREATE TEMPORARY TABLE test.t1(i INT);
ALTER TABLE test.t1 ADD COLUMN (j INT);
DROP TEMPORARY TABLE test.t1;
SET @@session.session_track_state_change=OFF;
USE test;
SET @@session.session_track_state_change=ON;
SET @@session.session_track_state_change=OFF;
SET @@session.session_track_state_change=ON;
CREATE TEMPORARY TABLE test.t1(i INT);
DROP TEMPORARY TABLE test.t1;
SET @@session.session_track_state_change=OFF;
SET @var1= 20;
SET @@session.session_track_state_change=ON;
SET @@session.session_track_state_change=OFF;
SET autocommit= 1;
SET @@session.session_track_state_change=ON;
CREATE TEMPORARY TABLE test.t1(i INT);
DROP TEMPORARY TABLE test.t1;
SET @@session.session_track_state_change=OFF;
CREATE TEMPORARY TABLE test.t1(i INT);
SET @@session.session_track_state_change=ON;

SET @@session.session_track_state_change=1;
SET @@session.session_track_state_change=0;
SET @@session.session_track_state_change=True;
SET @@session.session_track_state_change=falSe;
DROP TABLE test.t;
SET @@session.session_track_state_change=oNN;
SET @@session.session_track_state_change=FALS;
SET @@session.session_track_state_change=20;
SET @@session.session_track_state_change=OFFF;
SET @@session.session_track_state_change=NULL;
SET @@session.session_track_state_change='';
SET @@session.session_track_system_variables='time_zone,transaction_isolation';
SET @@session.time_zone='-6:00';
SET @@session.session_track_state_change=1;
SET @@session.transaction_isolation='READ-COMMITTED';
SET @var2= 20;
SET @@session.session_track_state_change=1;
SET @@session.session_track_schema=1;
USE test;
SET @@session.time_zone='-6:00';
SET @@session.session_track_state_change=1;
SET @var2= 20;
SET @@session.session_track_schema=1;
USE test;
SET @@session.session_track_state_change=1;
SET @@session.session_track_system_variables='transaction_isolation';
SET @@session.session_track_schema=1;
SET @@session.session_track_state_change=1;
SET @@session.session_track_state_change=0;

SET @@session.session_track_state_change=1;
SELECT @@session.session_track_state_change;
SELECT @@session.session_track_state_change;
SET @@session.session_track_state_change=1;
create function f() returns longtext no sql
begin
  declare continue handler for sqlexception begin end;
end $
delimiter ;

set session_track_system_variables=f();
set session_track_system_variables=DEFAULT;

drop function f;
