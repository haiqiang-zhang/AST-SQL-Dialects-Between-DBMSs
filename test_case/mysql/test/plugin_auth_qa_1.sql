
-- Official builds include separate debug enabled plugins to be used by
-- the debug enabled server. But the non-debug *client* should not use them.

let PLUGIN_AUTH_OPT=`SELECT TRIM(TRAILING '/debug' FROM '$PLUGIN_AUTH_OPT')`;

CREATE DATABASE test_user_db;
CREATE USER plug_user
  IDENTIFIED WITH test_plugin_server AS 'plug_dest';
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd';
DROP USER plug_user,new_dest;
CREATE USER plug_user
  IDENTIFIED WITH test_plugin_server AS 'plug_dest';
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd';
select USER(),CURRENT_USER();
select USER(),CURRENT_USER();
UPDATE mysql.user SET user='plug_user' WHERE user='new_user';
DROP USER plug_dest,plug_user;

--
CREATE USER plug_user
  IDENTIFIED WITH test_plugin_server AS 'plug_dest';
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd';
select USER(),CURRENT_USER();
UPDATE mysql.user SET user='new_user' WHERE user='plug_user';
UPDATE mysql.user SET authentication_string='new_dest' WHERE user='new_user';
UPDATE mysql.user SET plugin='new_plugin_server' WHERE user='new_user';
UPDATE mysql.user SET plugin='test_plugin_server' WHERE user='new_user';
UPDATE mysql.user SET USER='new_dest' WHERE user='plug_dest';
select USER(),CURRENT_USER();
UPDATE mysql.user SET USER='plug_dest' WHERE user='new_dest';
CREATE USER new_dest IDENTIFIED BY 'new_dest_passwd';
select USER(),CURRENT_USER();
DROP USER plug_user, new_user,new_dest,plug_dest;

CREATE USER ''@'' IDENTIFIED WITH test_plugin_server AS 'proxied_user';
CREATE USER proxied_user IDENTIFIED BY 'proxied_user_passwd';
SELECT USER(),CURRENT_USER();
SELECT @@proxy_user;
SELECT USER(),CURRENT_USER();
SELECT USER(),CURRENT_USER();
SELECT @@proxy_user;
DROP USER ''@'',proxied_user;
CREATE USER ''@'' IDENTIFIED WITH test_plugin_server AS 'proxied_user';
CREATE USER proxied_user IDENTIFIED BY 'proxied_user_passwd';
SELECT USER(),CURRENT_USER();
SELECT @@proxy_user;
SELECT USER(),CURRENT_USER();
SELECT USER(),CURRENT_USER();
SELECT @@proxy_user;
DROP USER ''@'',proxied_user;
CREATE USER ''@'' IDENTIFIED WITH test_plugin_server AS 'proxied_user';
CREATE USER proxied_user_1 IDENTIFIED BY 'proxied_user_1_pwd';
CREATE USER proxied_user_2 IDENTIFIED BY 'proxied_user_2_pwd';
CREATE USER proxied_user_3 IDENTIFIED BY 'proxied_user_3_pwd';
CREATE USER proxied_user_4 IDENTIFIED BY 'proxied_user_4_pwd';
CREATE USER proxied_user_5 IDENTIFIED BY 'proxied_user_5_pwd';
SELECT USER(),CURRENT_USER();
SELECT @@proxy_user;
SELECT USER(),CURRENT_USER();
SELECT @@proxy_user;
SELECT USER(),CURRENT_USER();
SELECT @@proxy_user;
SELECT USER(),CURRENT_USER();
SELECT @@proxy_user;
SELECT USER(),CURRENT_USER();
SELECT @@proxy_user;
DROP USER ''@'',proxied_user_1,proxied_user_2,proxied_user_3,proxied_user_4,proxied_user_5;

DROP DATABASE test_user_db;
