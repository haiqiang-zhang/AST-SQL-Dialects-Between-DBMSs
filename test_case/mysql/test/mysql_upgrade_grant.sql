
CREATE USER 'user3'@'%';

DROP USER 'user3'@'%';

-- Save a copy of the user/tables_priv tables, to restore later
-- Otherwise the final mysql_upgrade will REPLACE and update timestamps etc.
--let $backup= 1
--source include/backup_tables_priv_and_users.inc

-- Create 5.6 mysql.user table layout

--source include/user_80_to_57.inc
--source include/user_57_to_56.inc

INSERT INTO mysql.user VALUES
('localhost','B19011337_nhash','*46ABF58B20022A84DF7B2E8B1AC8219C8DA71553','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0,'','','N'),
('localhost','B19011337_ohash','0f0ea7602c473904','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0,'','','N');
let SEARCH_FILE= $test_error_log;
SELECT plugin FROM mysql.user WHERE user='B19011337_nhash';
SELECT plugin FROM mysql.user WHERE user='B19011337_ohash';
DROP USER B19011337_nhash@localhost;
DROP USER B19011337_ohash@localhost;

-- Restore the saved contents of mysql.user and mysql.tables_priv
--let $restore= 1
--source include/backup_tables_priv_and_users.inc


--echo --
--echo -- WL #8350 ENSURE 5.7 SUPPORTS SMOOTH LIVE UPGRADE FROM 5.6
--echo --

call mtr.add_suppression("Column count of mysql.* is wrong. "
                         "Expected .*, found .*. "
                         "The table is probably corrupted");

let server_log= $MYSQLTEST_VARDIR/log/mysqld.1.err;

-- Save a copy of the user/tables_priv tables, to restore later
-- Otherwise the final mysql_upgrade will REPLACE and update timestamps etc.
--let $backup= 1
--source include/backup_tables_priv_and_users.inc

-- Create 5.6 mysql.user table layout

--source include/user_80_to_57.inc
--source include/user_57_to_56.inc

call mtr.add_suppression("The plugin 'mysql_old_password' used to authenticate user 'user_old_pass_wp'@'%' is not loaded. Nobody can currently login using this account.");

-- Password for each user is 'lala'

INSERT INTO mysql.user VALUES
('%','user_old_pass_wp','0f0ea7602c473904','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'mysql_old_password','','N');
INSERT INTO mysql.user VALUES
('%','user_old_pass_pn','0f0ea7602c473904','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'','','N'),
('%','su_old_pass_pn','0f0ea7602c473904','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','Y','','','','',0,0,0,0,'','','N'),
('%','user_nat_pass_pn','*46ABF58B20022A84DF7B2E8B1AC8219C8DA71553','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,NULL,'','N'),
('%','user_nat_pass_wp','*46ABF58B20022A84DF7B2E8B1AC8219C8DA71553','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'mysql_native_password','','N');
let SEARCH_FILE= $test_error_log;
SELECT * FROM mysql.user WHERE user="user_nat_pass_pn";
SELECT * FROM mysql.user WHERE user="user_nat_pass_pn";
SELECT * FROM mysql.user WHERE user="user_nat_pass_pn";
SELECT authentication_string FROM mysql.user where user='user_nat_pass_pn';
SELECT password_expired FROM mysql.user where user='user_nat_pass_pn';
ALTER USER 'user_nat_pass_pn'@'%' PASSWORD EXPIRE;

SELECT authentication_string FROM mysql.user WHERE user='user_nat_pass_pn';
SELECT password_expired FROM mysql.user WHERE user='user_nat_pass_pn';
UPDATE mysql.user SET authentication_string='' WHERE user='user_nat_pass_pn';

UPDATE mysql.user SET Select_priv='Y', Insert_priv='Y', Update_priv='Y', Delete_priv='Y', Create_priv='Y', Drop_priv='Y', Reload_priv='Y', Shutdown_priv='Y', Process_priv='Y', File_priv='Y', Grant_priv='Y', References_priv='Y', Index_priv='Y', Alter_priv='Y', Show_db_priv='Y', Super_priv='Y', Create_tmp_table_priv='Y', Lock_tables_priv='Y', Execute_priv='Y', Repl_slave_priv='Y', Repl_client_priv='Y', Create_view_priv='Y', Show_view_priv='Y', Create_routine_priv='Y', Alter_routine_priv='Y', Create_user_priv='Y', Event_priv='Y', Trigger_priv='Y', Create_tablespace_priv='Y' where user="user_nat_pass_pn";
SELECT * FROM mysql.user WHERE user="user_nat_pass_pn";
let SEARCH_FILE= $test_error_log;

ALTER USER 'user_nat_pass_pn'@'%' PASSWORD EXPIRE;
SELECT password_expired FROM mysql.user WHERE user='user_nat_pass_pn';
SET PASSWORD FOR user_nat_pass_pn@'%' = 'lala';
SELECT password_expired FROM mysql.user WHERE user='user_nat_pass_pn';

ALTER USER 'user_nat_pass_wp'@'%' ACCOUNT LOCK;
SELECT account_locked FROM mysql.user WHERE user='user_nat_pass_wp';
ALTER USER 'user_nat_pass_wp'@'%' ACCOUNT UNLOCK;
SELECT account_locked FROM mysql.user WHERE user='user_nat_pass_wp';
CREATE USER super@localhost IDENTIFIED BY 'lala';
SELECT user FROM mysql.user WHERE user='super';

-- Cleanup

DROP USER 'super'@'localhost';
DROP USER 'user_old_pass_pn'@'%';
DROP USER 'su_old_pass_pn'@'%';
DROP USER 'user_old_pass_wp'@'%';
DROP USER 'user_nat_pass_pn'@'%';
DROP USER 'user_nat_pass_wp'@'%';

let server_log= $MYSQLTEST_VARDIR/log/mysqld.1.err;

-- Save a copy of the user/tables_priv tables, to restore later
-- Otherwise the final mysql_upgrade will REPLACE and update timestamps etc.
--let $backup= 1
--source include/backup_tables_priv_and_users.inc

-- Create 5.6 mysql.user table layout

--source include/user_80_to_57.inc
--source include/user_57_to_56.inc

INSERT INTO mysql.user VALUES
('localhost','B20614545','0f0ea7602c473904','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','N','','','','',0,0,0,0,'','','N');
let SEARCH_FILE= $test_error_log;
let SEARCH_FILE= $test_error_log;
SELECT plugin FROM mysql.user WHERE user='B20614545';

DROP USER B20614545@localhost;

CREATE USER u1;
DROP USER u1;
CREATE USER u1;
CREATE USER u2;
DROP USER u1;
DROP USER u2;

-- Revoke privilege XA_RECOVER_ADMIN from the user mysql.session@localhost in order to
-- match contol checksum for mysql.global_grants
REVOKE XA_RECOVER_ADMIN ON *.* FROM `mysql.session`@localhost;


-- Create a new user user1 and grant super privilege to user1.
CREATE USER user1;
DROP USER user1;

-- Revoke privilege RESOURCE_GROUP_ADMIN from the user mysql.session@localhost in order to
-- match contol checksum for mysql.global_grants
REVOKE RESOURCE_GROUP_ADMIN ON *.* FROM `mysql.session`@localhost;

CREATE USER u1;
DROP USER u1;

CREATE USER u1;
DROP USER u1;
CREATE USER sheldon;
DROP USER sheldon;
