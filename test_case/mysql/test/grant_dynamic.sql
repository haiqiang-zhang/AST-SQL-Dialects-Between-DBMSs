CREATE TABLE mysql.backup_global_grants AS SELECT * FROM mysql.global_grants;
CREATE USER 'u1'@'localhost' IDENTIFIED BY '123';
SELECT * FROM mysql.global_grants ORDER BY USER, PRIV, WITH_GRANT_OPTION;
SELECT * FROM mysql.global_grants ORDER BY USER, PRIV, WITH_GRANT_OPTION;
SELECT * FROM mysql.global_grants ORDER BY USER, PRIV, WITH_GRANT_OPTION;
SELECT * FROM mysql.global_grants ORDER BY USER, PRIV, WITH_GRANT_OPTION;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u1%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
SELECT * FROM mysql.global_grants ORDER BY USER, PRIV, WITH_GRANT_OPTION;
SELECT * FROM mysql.global_grants ORDER BY USER, PRIV, WITH_GRANT_OPTION;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE
LIKE '%u1%' ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;

INSERT INTO mysql.global_grants VALUES ('u1','localhost','RUBBISH','N');
INSERT INTO mysql.global_grants VALUES ('u1','localhost','RUBBISH','Y');
INSERT INTO mysql.global_grants VALUES ('u1','localhoster','RUBBISH','N');
DROP USER u1@localhost;
SELECT * FROM mysql.global_grants ORDER BY USER, PRIV, WITH_GRANT_OPTION;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u1%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
SELECT * FROM mysql.global_grants ORDER BY USER, PRIV, WITH_GRANT_OPTION;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u1%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u2%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
DROP USER u2@localhost;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
SELECT * FROM mysql.global_grants ORDER BY USER, PRIV, WITH_GRANT_OPTION;
SELECT * FROM information_schema.user_privileges WHERE GRANTEE LIKE '%u1%'
ORDER BY GRANTEE, PRIVILEGE_TYPE, IS_GRANTABLE;
CREATE TABLE t1 (c1 int);

DROP USER u1@localhost;
DROP TABLE t1;
INSERT INTO mysql.global_grants VALUES('u1', '%', 'ROUTINE_GRANT', 'Y');
INSERT INTO mysql.global_grants VALUES('u1_non', '%', 'HELLOWORLD', 'Y');
CREATE USER u1@localhost;
INSERT INTO mysql.global_grants VALUES('u1', 'localhost', 'HelloWorld', 'Y');
DROP USER u1@localhost;
DELETE FROM mysql.global_grants;
SET GLOBAL event_scheduler = 1;
CREATE DATABASE restricted;
CREATE TABLE restricted.t1 (c1 int, restricted int);
INSERT INTO restricted.t1 VALUES (1,2);
CREATE USER u1@localhost IDENTIFIED BY 'foo';
SELECT * from restricted.t1;
USE test;
CREATE DEFINER=root@localhost PROCEDURE p1() SELECT * FROM restricted.t1;
CREATE TABLE test.t1 (c1 INT);
CREATE DEFINER=root@localhost TRIGGER test.tr1 BEFORE INSERT ON test.t1
FOR EACH ROW INSERT INTO restricted.t1 VALUES (1,1);
INSERT INTO test.t1 VALUES (1);
SELECT * FROM restricted.t1;
DROP TRIGGER test.tr1;
CREATE DEFINER=root@localhost SQL SECURITY DEFINER VIEW v1 AS
SELECT a.restricted FROM restricted.t1 as a;
CREATE DEFINER=root@localhost SQL SECURITY DEFINER VIEW v1 AS
SELECT a.restricted FROM restricted.t1 as a;
SELECT * FROM v1;
CREATE DEFINER=root@localhost EVENT test.eve1 ON SCHEDULE AT
CURRENT_TIMESTAMP + INTERVAL 2 SECOND
DO BEGIN
  INSERT INTO restricted.t1 VALUES (5,5);
SELECT * FROM v1;
DROP PROCEDURE p1;
DROP DATABASE restricted;
DROP USER u1@localhost;
DROP VIEW test.v1;
DROP TABLE test.t1;
SET GLOBAL event_scheduler = 0;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
DROP USER u1@localhost;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
CREATE USER u2@localhost IDENTIFIED BY 'foo';
INSERT INTO mysql.global_grants VALUES('u1', 'localhost', 'ROLE_ADMIN', 'Y');
INSERT INTO mysql.global_grants
VALUES('u1', 'localhost', 'SYSTEM_VARIABLES_ADMIN', 'N');
DROP USER u1@localhost;
DROP USER u2@localhost;
DROP USER IF EXISTS u1, r1;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
CREATE ROLE r1;
SET ROLE r1;
DROP USER u1@localhost;
DROP ROLE r1;
DROP USER IF EXISTS u1;
CREATE USER u1, u1@localhost;
INSERT INTO mysql.global_grants VALUES('u1', '%', 'non_documented_privilege',
'Y');
INSERT INTO mysql.global_grants VALUES('u1', 'localhost',
'non_documented_privilege', 'Y');
SELECT * FROM mysql.global_grants;
SELECT * FROM mysql.global_grants;
DROP USER IF EXISTS 'u1'@'localhost';
DROP TABLE IF EXISTS test.t1;
CREATE TABLE test.t1(a int);
CREATE USER 'u1'@'localhost' IDENTIFIED BY 'pwd';
SET GLOBAL init_connect = 'INSERT INTO test.t1 values(555)';
SELECT * FROM test.t1;
SET GLOBAL init_connect = '';
SET GLOBAL offline_mode = 'ON';
SET GLOBAL offline_mode = 'OFF';
SET GLOBAL read_only = 'ON';
INSERT INTO test.t1 VALUES(1);
SET GLOBAL read_only = 'OFF';
SET @old_log_output=          @@global.log_output;
SET @old_general_log=         @@global.general_log;
SET @old_general_log_file=    @@global.general_log_file;
SET GLOBAL log_output =       'TABLE';
SET GLOBAL general_log=       'ON';
SET sql_log_off = ON;
SELECT 'helloworld';
SELECT COUNT(*) FROM mysql.general_log WHERE ARGUMENT like '%helloworld%';
SET sql_log_off = OFF;
SELECT 'helloworld';
SELECT COUNT(*)>=2 FROM mysql.general_log WHERE ARGUMENT like '%helloworld%';

SET GLOBAL init_connect = 'INSERT INTO test.t1 values(555)';
SELECT * FROM test.t1;

-- CONNECTION_ADMIN needed to modify offline_mode
connection default;
SET GLOBAL init_connect = '';
SET GLOBAL offline_mode = 'ON';

-- CONNECTION_ADMIN needed to modify offline_mode
connection default;
SET GLOBAL offline_mode = 'OFF';
SET GLOBAL read_only = 'ON';
INSERT INTO test.t1 VALUES(1);
SET GLOBAL read_only = 'OFF';
SET sql_log_off = OFF;
SELECT 'helloworld';
SELECT COUNT(*)>0 FROM mysql.general_log WHERE ARGUMENT like '%helloworld%';
SET sql_log_off = ON;
SELECT 'helloworld';
SELECT COUNT(*)>0 FROM mysql.general_log WHERE ARGUMENT like '%helloworld%';
SET sql_log_off = OFF;
SET GLOBAL general_log_file=  @old_general_log_file;
SET GLOBAL general_log=       @old_general_log;
SET GLOBAL log_output=        @old_log_output;
DROP USER IF EXISTS u1, r1, r2;
CREATE USER u1, r1, r2;
DROP ROLE r1;
INSERT INTO mysql.global_grants VALUES('u1', '%',
'length_32_abcdefghijklmnopqrstux', 'Y');
INSERT INTO mysql.global_grants VALUES('u1', '%',
'length_33_abcdefghijklmnopqrstuvw', 'Y');
DROP USER u1@localhost;
CREATE USER u1@localhost IDENTIFIED BY 'pwd';
DROP USER u1@localhost, u1, r2;
DROP TABLE test.t1;
CREATE USER u1@localhost IDENTIFIED BY 'pwd';
CREATE DATABASE db1_protected;
CREATE DATABASE db1;
DROP TABLE mysql.global_grants;
DROP DATABASE db1_protected;
DROP DATABASE db1;
DROP DATABASE db1_protected;
CREATE TABLE IF NOT EXISTS mysql.global_grants
(
 USER CHAR(32) BINARY DEFAULT '' NOT NULL,
 HOST CHAR(255) CHARACTER SET ASCII DEFAULT '' NOT NULL,
 PRIV CHAR(32) COLLATE utf8mb3_GENERAL_CI DEFAULT '' NOT NULL,
 WITH_GRANT_OPTION ENUM('N','Y') COLLATE utf8mb3_GENERAL_CI DEFAULT 'N' NOT NULL,
PRIMARY KEY (USER,HOST,PRIV)
) engine=InnoDB STATS_PERSISTENT=0 CHARACTER SET utf8mb3 COLLATE utf8mb3_bin
comment='Extended global grants' ROW_FORMAT=DYNAMIC TABLESPACE=mysql;
DROP USER u1@localhost;
CREATE USER u1;
CREATE USER u2;
CREATE USER u3;
DROP USER u1;
DROP USER u2;
DROP USER u3;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
DROP USER u1@localhost;
CREATE USER u1;
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
SELECT * FROM mysql.global_grants WHERE USER='u1';
DROP USER u1;
INSERT INTO mysql.global_grants (user, host, priv) values ('', '%', ' ');
DELETE FROM mysql.global_grants WHERE user = '' AND host = '%' AND priv = ' ';
INSERT INTO mysql.global_grants (user, host, priv) values ('', '', '');
DELETE FROM mysql.global_grants WHERE user = '' AND host = '' AND priv = '';
INSERT INTO mysql.global_grants (user, host, priv) values (' ', '', '');
DELETE FROM mysql.global_grants WHERE user = '' AND host = ' ' AND priv = '';
INSERT INTO mysql.global_grants (user, host, priv) values (' ', ' ', '');
DELETE FROM mysql.global_grants WHERE user = ' ' AND host = ' ' AND priv = '';
INSERT INTO mysql.global_grants (user, host, priv) values ('', '', ' ');
DELETE FROM mysql.global_grants WHERE user = '' AND host = '' AND priv = ' ';
DELETE FROM mysql.global_grants;
INSERT INTO mysql.global_grants SELECT * FROM mysql.backup_global_grants;
DROP TABLE mysql.backup_global_grants;
