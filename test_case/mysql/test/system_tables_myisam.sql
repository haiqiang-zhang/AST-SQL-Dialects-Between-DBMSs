CREATE USER 'user1'@'%';
CREATE TABLE t1 (f1 INT);

-- mysql.func
--replace_result $UDF_EXAMPLE_LIB UDF_EXAMPLE_LIB
eval CREATE FUNCTION sequence RETURNS INTEGER SONAME "$UDF_EXAMPLE_LIB";
CREATE TABLE mysql.func ENGINE='MyISAM' AS SELECT * FROM mysql.func_bkp;
CREATE FUNCTION udf_func RETURNS STRING SONAME 'udf_func.so';
DROP FUNCTION sequence;

ALTER TABLE mysql.func ENGINE='InnoDB',
                       DROP COLUMN ret;
CREATE FUNCTION udf_func RETURNS STRING SONAME 'udf_func.so';
DROP FUNCTION sequence;
DROP TABLE mysql.func;
DROP FUNCTION sequence;

-- mysql.plugin
RENAME TABLE mysql.plugin TO mysql.plugin_bkp;
CREATE TABLE mysql.plugin ENGINE='MyISAM' AS SELECT * FROM mysql.plugin_bkp;

ALTER TABLE mysql.plugin ENGINE=InnoDB,
                         MODIFY dl CHAR(64);
DROP TABLE mysql.plugin;

-- mysql.servers
RENAME TABLE mysql.servers TO mysql.servers_bkp;
CREATE TABLE mysql.servers ENGINE='MyISAM' AS SELECT * FROM mysql.servers_bkp;
CREATE SERVER fedlnk FOREIGN DATA WRAPPER mysql OPTIONS
       (USER 'fed_user', HOST 'remote_host', PORT 9306, DATABASE 'federated');
DROP SERVER fedlnk;
ALTER SERVER fedlnk OPTIONS (USER 'sally');

ALTER TABLE mysql.servers ENGINE='InnoDB',
                          MODIFY WRAPPER varchar(128);
CREATE SERVER fedlnk FOREIGN DATA WRAPPER mysql OPTIONS
       (USER 'fed_user', HOST 'remote_host', PORT 9306, DATABASE 'federated');
DROP SERVER fedlnk;
ALTER SERVER fedlnk OPTIONS (USER 'sally');
DROP TABLE mysql.servers;

-- mysql.user
RENAME TABLE mysql.user TO mysql.user_bkp;
CREATE TABLE mysql.user ENGINE='MyISAM' AS SELECT * FROM mysql.user_bkp;
CREATE USER 'user2'@'%';
DROP USER 'user1'@'%';
ALTER USER 'user1'@'%' PASSWORD EXPIRE;
SET PASSWORD FOR 'user1'@'%' = '123';

ALTER TABLE mysql.user ENGINE='InnoDB',
                       DROP COLUMN max_updates;
CREATE USER 'user2'@'%';
DROP USER 'user1'@'%';
ALTER USER 'user1'@'%' PASSWORD EXPIRE;
SET PASSWORD FOR 'user1'@'%' = '123';
DROP TABLE mysql.user;

-- mysql.columns_priv
RENAME TABLE mysql.columns_priv TO mysql.columns_priv_bkp;
CREATE TABLE mysql.columns_priv ENGINE='MyISAM' AS SELECT * FROM mysql.columns_priv_bkp;

ALTER TABLE mysql.columns_priv ENGINE='InnoDB',
                               DROP COLUMN Timestamp;
DROP TABLE mysql.columns_priv;

-- mysql.tables_priv
RENAME TABLE mysql.tables_priv TO mysql.tables_priv_bkp;
CREATE TABLE mysql.tables_priv ENGINE='MyISAM' AS SELECT * FROM mysql.tables_priv_bkp;

ALTER TABLE mysql.tables_priv ENGINE='InnoDB',
                              DROP COLUMN Timestamp;
DROP TABLE mysql.tables_priv;

-- mysql.procs_priv
CREATE FUNCTION f1() RETURNS INT return 1;
CREATE TABLE mysql.procs_priv ENGINE='MyISAM' AS SELECT * FROM mysql.procs_priv_bkp;

ALTER TABLE mysql.procs_priv ENGINE='InnoDB',
                             DROP COLUMN timestamp;
DROP TABLE mysql.procs_priv;

-- mysql.proxies_priv
RENAME TABLE mysql.proxies_priv TO mysql.proxies_priv_bkp;
CREATE TABLE mysql.proxies_priv ENGINE='MyISAM' AS SELECT * FROM mysql.proxies_priv_bkp;

ALTER TABLE mysql.proxies_priv ENGINE='InnoDB',
                               DROP COLUMN timestamp;
DROP TABLE mysql.proxies_priv;

-- mysql.component
RENAME TABLE mysql.component TO mysql.component_bkp;
CREATE TABLE mysql.component ENGINE='MyISAM' AS SELECT * FROM mysql.component_bkp;

ALTER TABLE mysql.component ENGINE='InnoDB',
                            DROP COLUMN component_urn;
DROP TABLE mysql.component;

-- mysql.db
RENAME TABLE mysql.db TO mysql.db_bkp;
CREATE TABLE mysql.db ENGINE='MyISAM' AS SELECT * FROM mysql.db_bkp;

ALTER TABLE mysql.db ENGINE='InnoDB',
                     DROP COLUMN Select_priv;
DROP TABLE mysql.db;

-- mysql.default_roles
RENAME TABLE mysql.default_roles TO mysql.default_roles_bkp;
CREATE TABLE mysql.default_roles ENGINE='MyISAM' AS SELECT * FROM mysql.default_roles_bkp;
SET DEFAULT ROLE ALL TO 'user1'@'%';

ALTER TABLE mysql.default_roles ENGINE='InnoDB',
                                DROP COLUMN DEFAULT_ROLE_USER;
SET DEFAULT ROLE ALL TO 'user1'@'%';
DROP TABLE mysql.default_roles;

-- mysql.global_grants
RENAME TABLE mysql.global_grants TO mysql.global_grants_bkp;
CREATE TABLE mysql.global_grants ENGINE='MyISAM' AS SELECT * FROM mysql.global_grants_bkp;

ALTER TABLE mysql.global_grants ENGINE='InnoDB',
                                DROP COLUMN WITH_GRANT_OPTION;
DROP TABLE mysql.global_grants;

-- mysql.role_edges
RENAME TABLE mysql.role_edges TO mysql.role_edges_bkp;
CREATE TABLE mysql.role_edges ENGINE='MyISAM' AS SELECT * FROM mysql.role_edges_bkp;
SET DEFAULT ROLE ALL TO 'user1'@'%';

ALTER TABLE mysql.role_edges ENGINE='InnoDB',
                             DROP COLUMN TO_USER;
SET DEFAULT ROLE ALL TO 'user1'@'%';
DROP TABLE mysql.role_edges;

-- mysql.password_history
SET GLOBAL default_password_lifetime = 2;
CREATE TABLE mysql.password_history ENGINE='MyISAM' AS SELECT * FROM mysql.password_history_bkp;
ALTER USER 'user1'@'%' IDENTIFIED BY 'password';

ALTER TABLE mysql.password_history ENGINE='InnoDB',
                                   DROP COLUMN Password_timestamp;
ALTER USER 'user1'@'%' IDENTIFIED BY 'password';
DROP TABLE mysql.password_history;
SET GLOBAL default_password_lifetime = DEFAULT;
DROP TABLE t1;
DROP FUNCTION f1;
DROP USER 'user1'@'%';
SELECT table_schema, table_name, engine FROM information_schema.tables
                                        WHERE table_schema='mysql'
                                              AND engine='MyISAM';
SELECT table_schema, table_name, engine FROM information_schema.tables
                                        WHERE table_schema='mysql'
                                              AND engine='MyISAM';
