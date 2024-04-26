-- 
-- Test of the authentification interface. The plugin checks the expected values set
-- by this application and the application checks the values set the the plugin.
--source include/have_plugin_server.inc


-- Official builds include separate debug enabled plugins to be used by
-- the debug enabled server. But the non-debug *client* should not use them.

let PLUGIN_AUTH_OPT=`SELECT TRIM(TRAILING '/debug' FROM '$PLUGIN_AUTH_OPT')`;

CREATE DATABASE test_user_db;

CREATE USER qa_test_11_user IDENTIFIED WITH qa_auth_server AS 'qa_test_11_dest';
CREATE USER qa_test_11_dest identified by 'dest_passwd';

DROP USER qa_test_11_user, qa_test_11_dest;
DROP DATABASE test_user_db;
