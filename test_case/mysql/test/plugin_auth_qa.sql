
CREATE DATABASE test_user_db;
CREATE USER plug IDENTIFIED WITH test_plugin_server;
DROP USER plug;
CREATE USER plug IDENTIFIED WITH test_plugin_server BY '123';
DROP USER plug;
CREATE USER plug IDENTIFIED WITH 'test_plugin_server';
DROP USER plug;
CREATE USER plug IDENTIFIED WITH test_plugin_server BY '123';
DROP USER plug;
CREATE USER plug IDENTIFIED WITH test_plugin_server AS '';
DROP USER plug;
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS ;
CREATE USER plug IDENTIFIED WITH test_plugin_server AS plug_dest;
CREATE USER plug IDENTIFIED WITH AS plug_dest;
CREATE USER plug IDENTIFIED WITH;
CREATE USER plug IDENTIFIED AS '';
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' IDENTIFIED WITH 'test_plugin_server';
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS '' AS 'plug_dest';
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS '' 
                 IDENTIFIED WITH test_plugin_server   AS 'plug_dest';
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd' 
                      IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest' 
       USER plug_dest IDENTIFIED by 'plug_dest_pwd';
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest' 
       plug_dest IDENTIFIED by 'plug_dest_pwd';
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest' 
       IDENTIFIED by 'plug_dest_pwd';
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd';
DROP USER plug, plug_dest;
-- 
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
DROP USER plug;
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd';
DROP USER plug_dest;
-- 
CREATE USER plug IDENTIFIED WITH test_plugin_server AS 'plug_dest';
DROP USER plug;
CREATE USER plug_dest IDENTIFIED BY 'plug_dest_passwd';
DROP USER plug_dest;
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
DROP USER plug;
-- 
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
DROP USER plug;
CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
CREATE USER plug_dest IDENTIFIED WITH 'test_plugin_server' AS 'plug_dest';
DROP USER plug,plug_dest;

SET NAMES utf8mb3;
-- 
CREATE USER plüg IDENTIFIED WITH 'test_plugin_server' AS 'plüg_dest';
DROP USER plüg;
CREATE USER plüg_dest IDENTIFIED BY 'plug_dest_passwd';
DROP USER plüg_dest;

SET NAMES ascii;
-- 
CREATE USER 'plüg' IDENTIFIED WITH 'test_plugin_server' AS 'plüg_dest';
DROP USER 'plüg';
CREATE USER 'plüg_dest' IDENTIFIED BY 'plug_dest_passwd';
DROP USER 'plüg_dest';

SET NAMES latin1;
-- 
--echo ========== test 1.1.1.5 ====================================
--error ER_PLUGIN_IS_NOT_LOADED
CREATE USER 'plüg' IDENTIFIED WITH 'test_plügin_server' AS 'plüg_dest';
CREATE USER 'plug' IDENTIFIED WITH 'test_plugin_server' AS 'plüg_dest';
DROP USER 'plug';
CREATE USER 'plüg_dest' IDENTIFIED BY 'plug_dest_passwd';
DROP USER 'plüg_dest';

SET NAMES utf8mb3;
-- 
--error ER_PLUGIN_IS_NOT_LOADED
CREATE USER plüg IDENTIFIED WITH 'test_pluggggin_server' AS 'plüg_dest';
CREATE USER 'plüg' IDENTIFIED WITH 'test_plugin_server' AS 'plüg_dest';
DROP USER 'plüg';
CREATE USER 'plüg_dest' IDENTIFIED BY 'plug_dest_passwd';
DROP USER 'plüg_dest';

CREATE USER plüg IDENTIFIED WITH test_plugin_server AS 'plüg_dest';
DROP USER plüg;
CREATE USER plüg_dest IDENTIFIED BY 'plug_dest_passwd';
DROP USER plüg_dest;

SET @auth_name= 'test_plugin_server';
CREATE USER plug IDENTIFIED WITH @auth_name AS 'plug_dest';

SET @auth_string= 'plug_dest';
CREATE USER plug IDENTIFIED WITH test_plugin_server AS @auth_string;
CREATE USER plug IDENTIFIED WITH 'hh''s_test_plugin_server' AS 'plug_dest';

CREATE USER plug IDENTIFIED WITH 'test_plugin_server' AS 'hh''s_plug_dest';
DROP USER plug;
CREATE USER 'hh''s_plug_dest' IDENTIFIED BY 'plug_dest_passwd';
DROP USER 'hh''s_plug_dest';
CREATE USER plug IDENTIFIED WITH hh''s_test_plugin_server AS 'plug_dest';

DROP DATABASE test_user_db;
