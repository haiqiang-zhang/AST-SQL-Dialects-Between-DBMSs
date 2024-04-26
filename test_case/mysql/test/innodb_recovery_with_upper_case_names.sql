
-- Start the server with innodb-fast-shutdown=2,so that
-- during next invocation of server it enters crash
-- recovery mode

create database MYDB;
USE MYDB;
CREATE TABLE mytable (id int primary key) ENGINE=innodb;
CREATE TABLE FOO (id int,constraint FOREIGN KEY (id) REFERENCES mytable(id) ON DELETE CASCADE) ENGINE=innodb;
CREATE TABLE mytable_ref (id int,constraint FOREIGN KEY (id) REFERENCES FOO(id) ON DELETE CASCADE) ENGINE=innodb;

INSERT INTO mytable VALUES (10),(20),(30),(40);
INSERT INTO FOO VALUES (20),(10);
INSERT INTO mytable_ref VALUES (20),(10);

INSERT INTO mytable VALUES (50);
INSERT INTO FOO VALUES (50);
INSERT INTO mytable_ref VALUES (50);

-- Stop the server
--exec echo "wait" > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--shutdown_server
--source include/wait_until_disconnected.inc

--echo -- Restart the server. This will go into crash recovery mode
--exec echo "restart: --innodb-fast-shutdown=0 " > $MYSQLTEST_VARDIR/tmp/mysqld.1.expect
--enable_reconnect
--source include/wait_until_connected_again.inc

USE MYDB;
SELECT * FROM mytable;
SELECT * FROM FOO;
SELECT * FROM mytable_ref;

DELETE FROM mytable WHERE id =10;

SELECT * FROM FOO;
SELECT * FROM mytable_ref;

-- Create table with mixed names,this should
-- fail in case insensitive systems

--error ER_TABLE_EXISTS_ERROR
CREATE TABLE MYtable (id int) ENGINE=innodb;
CREATE TABLE Foo (id int) ENGINE=innodb;

DROP TABLE mytable_ref,FOO;
DROP TABLE mytable;
use test;
DROP DATABASE MYDB;

-- Clean up
let $restart_parameters = restart:;
