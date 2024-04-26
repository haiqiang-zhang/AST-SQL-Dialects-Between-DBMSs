-- 
-- Test of the authentification interface. The plugin checks the expected values set
-- by this application and the application checks the values set the the plugin.
--source include/have_plugin_interface.inc

-- Official builds include separate debug enabled plugins to be used by
-- the debug enabled server. But the non-debug *client* should not use them.

let PLUGIN_AUTH_OPT=`SELECT TRIM(TRAILING '/debug' FROM '$PLUGIN_AUTH_OPT')`;

CREATE DATABASE test_user_db;

CREATE USER qa_test_1_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_1_dest';
CREATE USER qa_test_1_dest IDENTIFIED BY 'dest_passwd';
SELECT user,plugin FROM mysql.user WHERE user != 'root';
SELECT @@proxy_user;
SELECT @@external_user;

DROP USER qa_test_1_user;
DROP USER qa_test_1_dest;

CREATE USER qa_test_2_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_2_dest';
CREATE USER qa_test_2_dest IDENTIFIED BY 'dest_passwd';
CREATE USER authenticated_as IDENTIFIED BY 'dest_passwd';
SELECT @@proxy_user;
SELECT @@external_user;

DROP USER qa_test_2_user;
DROP USER qa_test_2_dest;
DROP USER authenticated_as;

CREATE USER qa_test_3_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_3_dest';
CREATE USER qa_test_3_dest IDENTIFIED BY 'dest_passwd';

DROP USER qa_test_3_user;
DROP USER qa_test_3_dest;

CREATE USER qa_test_4_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_4_dest';
CREATE USER qa_test_4_dest IDENTIFIED BY 'dest_passwd';

DROP USER qa_test_4_user;
DROP USER qa_test_4_dest;

CREATE USER qa_test_5_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_5_dest';
CREATE USER qa_test_5_dest IDENTIFIED BY 'dest_passwd';
CREATE USER ''@'localhost' IDENTIFIED BY 'dest_passwd';

DROP USER qa_test_5_user;
DROP USER qa_test_5_dest;
DROP USER ''@'localhost';

CREATE USER qa_test_6_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_6_dest';
CREATE USER qa_test_6_dest IDENTIFIED BY 'dest_passwd';

CREATE USER root IDENTIFIED WITH qa_auth_interface AS 'qa_test_6_dest';

DROP USER qa_test_6_user;
DROP USER qa_test_6_dest;
DROP USER 'root'@'%';

CREATE USER qa_test_11_user IDENTIFIED WITH qa_auth_interface AS 'qa_test_11_dest';
CREATE USER qa_test_11_dest IDENTIFIED BY 'dest_passwd';

DROP USER qa_test_11_user, qa_test_11_dest;
DROP DATABASE test_user_db;
