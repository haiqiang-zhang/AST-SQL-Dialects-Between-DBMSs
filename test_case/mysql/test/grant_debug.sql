
CREATE USER user_name_robert_golebiowski1234@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char;

CREATE USER user_name_robert_golebiowski1234@localhost;

CREATE USER some_user@localhost;
SET @@global.debug="+d,wl_9262_set_max_length_hostname";
SET @@global.debug="-d,wl_9262_set_max_length_hostname";
SELECT CURRENT_USER();

CREATE DATABASE db_1;
CREATE TABLE db_1.test_table(ID INT);

SELECT Grantor FROM mysql.tables_priv WHERE USER = 'some_user';
SELECT LENGTH(Grantor) FROM mysql.tables_priv WHERE USER = 'some_user';

DROP USER user_name_robert_golebiowski1234@localhost;
DROP USER some_user@localhost;
DROP USER user_name_robert_golebiowski1234@oh_my_gosh_this_is_a_long_hostname_look_at_it_it_has_60_char;
DROP DATABASE db_1;
use test;
CREATE ROLE r1,r2;
CREATE USER u1@localhost IDENTIFIED BY 'foo';
ALTER USER u1@localhost DEFAULT ROLE r1;
SET @@global.debug="+d,induce_acl_load_failure";
SET @@global.debug="+d,induce_acl_load_failure";
SET @@global.debug="-d,induce_acl_load_failure";
DROP USER u1@localhost;
DROP ROLE r1,r2;
CREATE USER u1;
CREATE ROLE r1;
SET DEFAULT ROLE ALL TO u1;
SELECT * FROM mysql.role_edges;
SELECT * FROM mysql.default_roles;
USE mysql;

-- Trigger a debug execution in role cache reinitialization and return error,
-- in turn this leads backup copies to be restored.
SET @@global.debug="+d, dbug_fail_in_role_cache_reinit";
USE mysql;

SET @@global.debug="-d, dbug_fail_in_role_cache_reinit";
DROP USER u1;
DROP ROLE r1;
