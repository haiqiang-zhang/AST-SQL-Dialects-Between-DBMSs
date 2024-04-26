CREATE USER some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890X;

CREATE USER some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890;
CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890X EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;

CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890 EVENT e1 ON SCHEDULE EVERY 1 DAY DO SELECT 1;

SELECT DEFINER FROM INFORMATION_SCHEMA.EVENTS WHERE EVENT_NAME='e1';

DROP EVENT e1;
CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890X PROCEDURE p1() SELECT 1;

CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890 PROCEDURE p1() SELECT 1;

SELECT ROUTINE_NAME, DEFINER
  FROM INFORMATION_SCHEMA.ROUTINES
  WHERE ROUTINE_NAME LIKE 'p1';

DROP PROCEDURE p1;
CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890X FUNCTION f1() RETURNS INT RETURN 1;

CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890 FUNCTION f1() RETURNS INT RETURN 1;

SELECT ROUTINE_NAME, DEFINER
  FROM INFORMATION_SCHEMA.ROUTINES
  WHERE ROUTINE_NAME LIKE 'f1';

DROP FUNCTION f1;
CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890X VIEW v1 AS SELECT 1;

CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890 VIEW v1 AS SELECT 1;

SELECT TABLE_NAME, DEFINER FROM INFORMATION_SCHEMA.VIEWS
  WHERE TABLE_NAME LIKE 'v1';

DROP VIEW v1;

CREATE TABLE t1 (f1 INT);
CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890X TRIGGER trg1 BEFORE UPDATE ON t1 FOR EACH ROW SET @f1=1;

CREATE DEFINER=some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890 TRIGGER trg1 BEFORE UPDATE ON t1 FOR EACH ROW SET @f1=1;

SELECT TRIGGER_NAME, DEFINER FROM INFORMATION_SCHEMA.TRIGGERS
  WHERE TRIGGER_NAME LIKE 'trg1';

DROP TRIGGER trg1;

DROP TABLE t1;
CREATE TABLE t1 (f1 INT);
CREATE TABLE t2 (f1 INT);

SELECT host,user,length(authentication_string) FROM mysql.user
  WHERE user LIKE 'some_user_name%' ORDER BY host,user,authentication_string;

SELECT host,db,user FROM mysql.db
  WHERE user LIKE 'some_user_name%' ORDER BY host,db,user;

SELECT host,db,user,table_name FROM mysql.tables_priv
  WHERE user LIKE 'some_user_name%' ORDER BY host,db,user,table_name;

SELECT host,db,user,table_name,column_name FROM mysql.columns_priv
  WHERE user LIKE 'some_user_name%'
  ORDER BY host,db,user,table_name,column_name;

SELECT GRANTEE FROM INFORMATION_SCHEMA.USER_PRIVILEGES
 WHERE GRANTEE LIKE "\'some_user_name%";
SELECT GRANTEE FROM INFORMATION_SCHEMA.SCHEMA_PRIVILEGES
 WHERE GRANTEE LIKE "\'some_user_name%";
SELECT GRANTEE FROM INFORMATION_SCHEMA.TABLE_PRIVILEGES
 WHERE GRANTEE LIKE "\'some_user_name%";
SELECT GRANTEE FROM INFORMATION_SCHEMA.COLUMN_PRIVILEGES
 WHERE GRANTEE LIKE "\'some_user_name%";

DROP TABLE t1;
DROP TABLE t2;
CREATE USER u1@localhost;

SELECT * FROM mysql.role_edges;

SET DEFAULT ROLE u1@localhost TO some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890;

SET DEFAULT ROLE some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890 TO root@localhost;
DROP USER u1@localhost;

SELECT * FROM mysql.default_roles;
SELECT USER, HOST, COUNT(*) > 0  FROM mysql.global_grants
  WHERE USER LIKE 'some_user_name%' AND HOST LIKE 'host_%' GROUP BY USER, HOST;
SELECT * FROM mysql.global_grants WHERE USER LIKE 'some_user_name%';

CREATE USER pass_hist_user@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890 IDENTIFIED BY 'haha' PASSWORD HISTORY 1;

SELECT User, Host FROM mysql.password_history WHERE User='pass_hist_user';

DROP USER pass_hist_user@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890;

CREATE SERVER 'server_one' FOREIGN DATA WRAPPER 'mysql' OPTIONS
  (HOST 'host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890',
  DATABASE 'test',
  USER 'some_user_name',
  PASSWORD '',
  PORT 9983,
  SOCKET '',
  OWNER 'some_user_name');
SELECT * FROM mysql.servers ORDER BY SERVER_NAME;

DROP SERVER 'server_one';

CREATE PROCEDURE p1() SELECT 1;

SELECT User, Host FROM mysql.procs_priv WHERE User LIKE 'some_user_name%';

DROP PROCEDURE p1;
SELECT * FROM mysql.proxies_priv WHERE user ='some_user_name';
SELECT * FROM mysql.proxies_priv WHERE Proxied_user ='some_user_name';

CREATE USER u1@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890;
CREATE USER u2@localhost;

SET GLOBAL DEBUG='+d,vio_peer_addr_fake_hostname1';
SET GLOBAL DEBUG='-d,vio_peer_addr_fake_hostname1';
DROP USER u2@localhost;
DROP USER u1@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890;
DROP USER some_user_name@host_1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890abcdefghij1234567890;