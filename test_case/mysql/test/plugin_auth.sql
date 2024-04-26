
-- Official builds include separate debug enabled plugins to be used by
-- the debug enabled server. But the non-debug *client* should not use them.

let PLUGIN_AUTH_OPT=`SELECT TRIM(TRAILING '/debug' FROM '$PLUGIN_AUTH_OPT')`;

SET @old_log_output=          @@global.log_output;
SET @old_general_log=         @@global.general_log;

SET GLOBAL log_output =       'TABLE';
SET GLOBAL general_log=       'ON';

CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd';
SELECT plugin,authentication_string FROM mysql.user WHERE User='plug';
SELECT * FROM mysql.proxies_priv WHERE user !='root';
select USER(),CURRENT_USER();
SET PASSWORD = 'plug_dest';
select USER(),CURRENT_USER();
select USER(),CURRENT_USER();
CREATE USER `Ÿ` IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
select USER(),CURRENT_USER();
DROP USER `Ÿ`;
CREATE DATABASE test_grant_db;

DROP DATABASE test_grant_db;

-- Test effect of variabled on the plugin tested here (WL#7724).
SELECT @@global.check_proxy_users;
SELECT @@global.mysql_native_password_proxy_users;
SELECT @@global.sha256_password_proxy_users;

SET @@global.check_proxy_users=ON;
SET @@global.mysql_native_password_proxy_users=ON;
SET @@global.sha256_password_proxy_users=ON;


CREATE USER grant_plug IDENTIFIED WITH 'test_plugin_server'
  AS 'grant_plug_dest';
CREATE USER grant_plug_dest IDENTIFIED BY 'grant_plug_dest_passwd';
CREATE USER grant_plug_dest2 IDENTIFIED BY 'grant_plug_dest_passwd2';

-- This should fail, can't combine PROXY
--error ER_PARSE_ERROR
GRANT ALL PRIVILEGES,PROXY ON grant_plug_dest TO grant_plug;

-- Security context in THD contains two pairs of (user,host)
-- 1. (user,host) pair referring to inbound connection
-- 2. (priv_user,priv_host) pair obtained from mysql.user table after doing
--    authentication of incoming connection.
-- Granting/revoking proxy privileges, privileges should be checked wrt
-- (priv_user, priv_host) tuple that is obtained from mysql.user table
-- Following is a valid grant because effective user of connection is
-- grant_plug_dest@% and statement is trying to grant proxy on the same
-- user.
--echo This is a valid grant
GRANT PROXY ON grant_plug_dest TO grant_plug;

-- grant_plug_dest@localhost is not the same as grant_plug_dest@%
-- so following grant/revoke should fail
--echo this should fail : not the same user
--error ER_ACCESS_DENIED_NO_PASSWORD_ERROR
GRANT PROXY ON grant_plug_dest@localhost TO grant_plug WITH GRANT OPTION;
CREATE USER proxy_admin IDENTIFIED BY 'test';
CREATE USER test_drop@localhost;
DROP USER test_drop@localhost;
SELECT * FROM mysql.proxies_priv WHERE Host = 'test_drop' AND User = 'localhost';

DROP USER proxy_admin;

DROP USER grant_plug,grant_plug_dest,grant_plug_dest2;
DROP USER plug;
DROP USER plug_dest;
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd';

SELECT USER(),CURRENT_USER(),@@LOCAL.proxy_user;
SELECT @@GLOBAL.proxy_user;
SELECT @@LOCAL.proxy_user;
SET GLOBAL proxy_user = 'test';
SET LOCAL proxy_user = 'test';
SELECT @@LOCAL.proxy_user;
SELECT @@LOCAL.proxy_user;

SET @@global.check_proxy_users=0;
SET @@global.mysql_native_password_proxy_users=0;
SET @@global.sha256_password_proxy_users=0;
DROP USER plug;
DROP USER plug_dest;
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd';
SELECT USER(),CURRENT_USER(),@@LOCAL.external_user;
SELECT @@GLOBAL.external_user;
SELECT @@LOCAL.external_user;
SET GLOBAL external_user = 'test';
SET LOCAL external_user = 'test';
SELECT @@LOCAL.external_user;
SELECT @@LOCAL.external_user;
SELECT argument FROM mysql.general_log WHERE argument LIKE CONCAT('CREATE USER %') AND
                                             command_type NOT LIKE 'Prepare';
DROP USER plug;
DROP USER plug_dest;

SET GLOBAL log_output=  @old_log_output;
SET GLOBAL general_log= @old_general_log;

CREATE USER power_user;
CREATE USER ''@'' IDENTIFIED WITH 'test_plugin_server' AS 'power_user';
CREATE DATABASE confidential_db;
SELECT user(),current_user(),@@proxy_user;

DROP USER power_user;
DROP USER ''@'';
DROP DATABASE confidential_db;

CREATE USER ''@'' IDENTIFIED WITH 'test_plugin_server' AS 'standard_user';
CREATE USER standard_user;
CREATE DATABASE shared;

DROP USER ''@'';
DROP USER standard_user;
DROP DATABASE shared;

CREATE USER uplain@localhost IDENTIFIED WITH 'cleartext_plugin_server'
  AS 'cleartext_test';
select USER(),CURRENT_USER();
DROP USER uplain@localhost;

INSERT INTO mysql.user(
  Host,
  User,
  Select_priv,
  Insert_priv,
  Update_priv,
  Delete_priv,
  Create_priv,
  Drop_priv,
  Reload_priv,
  Shutdown_priv,
  Process_priv,
  File_priv,
  Grant_priv,
  References_priv,
  Index_priv,
  Alter_priv,
  Show_db_priv,
  Super_priv,
  Create_tmp_table_priv,
  Lock_tables_priv,
  Execute_priv,
  Repl_slave_priv,
  Repl_client_priv,
  /*!50001
  Create_view_priv,
  Show_view_priv,
  Create_routine_priv,
  Alter_routine_priv,
  Create_user_priv,
  */
  ssl_type,
  ssl_cipher,
  x509_issuer,
  x509_subject,
  max_questions,
  max_updates,
  max_connections)
VALUES (
  'localhost',
  'inserttest',
  'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y',
  'Y', 'Y',  'Y', 'Y', 'Y', 'Y', 'Y', 'Y', 'Y',
  /*!50001 'Y', 'Y', 'Y', 'Y', 'Y', */'', '', '', '', '0', '0', '0');
DROP USER inserttest@localhost;
SELECT IS_NULLABLE, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE
  COLUMN_NAME IN ('authentication_string', 'plugin') AND
  TABLE_NAME='user' AND
  TABLE_SCHEMA='mysql'
ORDER BY COLUMN_NAME;

SELECT IS_NULLABLE, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA= 'mysql' AND TABLE_NAME= 'user' AND
    COLUMN_NAME IN ('plugin', 'authentication_string')
  ORDER BY COLUMN_NAME;
ALTER TABLE mysql.user MODIFY plugin char(64) DEFAULT '' NOT NULL;
ALTER TABLE mysql.user MODIFY authentication_string TEXT NOT NULL;

SELECT IS_NULLABLE, COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
  WHERE TABLE_SCHEMA= 'mysql' AND TABLE_NAME= 'user' AND
    COLUMN_NAME IN ('plugin', 'authentication_string')
  ORDER BY COLUMN_NAME;

CREATE USER bug12610784@localhost;
SET PASSWORD FOR bug12610784@localhost = 'secret';
DROP USER bug12610784@localhost;

CREATE USER bug12818542@localhost
  IDENTIFIED WITH 'test_plugin_server' AS 'bug12818542_dest';
CREATE USER bug12818542_dest@localhost
  IDENTIFIED BY 'bug12818542_dest_passwd';
SELECT USER(),CURRENT_USER();
SET PASSWORD = 'bruhaha';
SELECT USER(),CURRENT_USER();

DROP USER bug12818542@localhost;
DROP USER bug12818542_dest@localhost;

CREATE USER 'empl_external'@'localhost' IDENTIFIED WITH test_plugin_server AS 'employee';
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'passkey';
ALTER USER employee@localhost PASSWORD EXPIRE;
DROP USER 'empl_external'@'localhost', 'employee'@'localhost';

CREATE USER bug20537246@localhost
    IDENTIFIED WITH 'cleartext_plugin_server' AS '';
select USER(),CURRENT_USER();
DROP USER bug20537246@localhost;

CREATE USER 'empl_external'@'localhost' IDENTIFIED WITH test_plugin_server AS 'employee';
CREATE USER 'employee'@'localhost' IDENTIFIED BY 'passkey';
SELECT USER(), CURRENT_USER, @@PROXY_USER;
ALTER USER 'employee'@'localhost' PASSWORD EXPIRE;
SELECT USER(), CURRENT_USER, @@PROXY_USER;
SELECT USER(), CURRENT_USER, @@PROXY_USER;
SELECT USER(), CURRENT_USER, @@PROXY_USER;
DROP USER 'employee'@'localhost', 'empl_external'@'localhost';

CREATE USER user_name_len_22_01234 IDENTIFIED WITH 'test_plugin_server' AS 'user_name_len_22_0dest';
CREATE USER user_name_len_22_0dest IDENTIFIED BY 'plug_dest_passwd';
SELECT plugin,authentication_string FROM mysql.user WHERE User='plug';
SELECT * FROM mysql.proxies_priv WHERE user !='root';
SELECT USER(),CURRENT_USER();
SET NAMES utf8mb3;

-- 32 characters user name
CREATE USER очень_очень_очень_длинный_юзер__ IDENTIFIED WITH 'test_plugin_server' AS 'очень_очень_очень_длинный_дест__';
CREATE USER очень_очень_очень_длинный_дест__ IDENTIFIED BY 'plug_dest_passwd';
SELECT plugin,authentication_string FROM mysql.user WHERE User='plug';
SELECT * FROM mysql.proxies_priv WHERE user !='root';
SELECT USER(),CURRENT_USER();
DROP USER user_name_len_22_01234;
DROP USER user_name_len_22_0dest;
DROP USER очень_очень_очень_длинный_юзер__;
DROP USER очень_очень_очень_длинный_дест__;
SET NAMES default;

CREATE USER user_name_len_22_01234@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';
SELECT CURRENT_USER();
DROP USER user_name_len_22_01234@localhost;

CREATE USER user_name_len_32_012345678901234@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string';
SELECT CURRENT_USER();
DROP USER user_name_len_32_012345678901234@localhost;

CREATE USER user_name_len_32_012345678901234@localhost IDENTIFIED WITH 'cleartext_plugin_server' AS 'auth_string';
SELECT CURRENT_USER();
DROP USER user_name_len_32_012345678901234@localhost;

CREATE USER user_name_len_22_01234@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string' REQUIRE SSL;
SELECT CURRENT_USER();
DROP USER user_name_len_22_01234@localhost;

CREATE USER user_name_len_32_012345678901234@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string' REQUIRE SSL;
SELECT CURRENT_USER();
DROP USER user_name_len_32_012345678901234@localhost;

CREATE USER user_name_len_32_012345678901234@localhost IDENTIFIED WITH 'cleartext_plugin_server' AS 'auth_string' REQUIRE SSL;
SELECT CURRENT_USER();
DROP USER user_name_len_32_012345678901234@localhost;
SET NAMES utf8mb3;

-- 32 characters user name
CREATE USER очень_очень_очень_длинный_юзер__@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string';
SELECT CURRENT_USER();
DROP USER очень_очень_очень_длинный_юзер__@localhost;

-- 32 characters user name
CREATE USER очень_очень_очень_длинный_юзер__@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string';
SELECT CURRENT_USER();
DROP USER очень_очень_очень_длинный_юзер__@localhost;

CREATE USER очень_очень_очень_длинный_юзер__@localhost IDENTIFIED WITH 'cleartext_plugin_server' AS 'auth_string';
SELECT CURRENT_USER();
DROP USER очень_очень_очень_длинный_юзер__@localhost;

-- 32 characters user name
CREATE USER очень_очень_очень_длинный_юзер__@localhost IDENTIFIED WITH 'sha256_password' BY 'auth_string' REQUIRE SSL;
SELECT CURRENT_USER();
DROP USER очень_очень_очень_длинный_юзер__@localhost;

-- 32 characters user name
CREATE USER очень_очень_очень_длинный_юзер__@localhost IDENTIFIED WITH 'mysql_native_password' BY 'auth_string' REQUIRE SSL;
SELECT CURRENT_USER();
DROP USER очень_очень_очень_длинный_юзер__@localhost;

CREATE USER очень_очень_очень_длинный_юзер__@localhost IDENTIFIED WITH 'cleartext_plugin_server' AS 'auth_string' REQUIRE SSL;
SELECT CURRENT_USER();
DROP USER очень_очень_очень_длинный_юзер__@localhost;
SET NAMES default;
