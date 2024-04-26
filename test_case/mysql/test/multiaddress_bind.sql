
--# Setting --bind-address=127.0.0.1,::1 need to be done here, inside
--# the test after the check for IPv6.  If it is done in -master.opt,
--# MTR will attempt to start the server with an IPv6 address, and the
--# server start will fail on machines without IPv6.

--let $restart_parameters=restart: --bind-address=127.0.0.1,::1
--source include/restart_mysqld.inc

--let $MYSQLD_LOG= $MYSQL_TMP_DIR/server.log
--let $MYSQLD_DATADIR= `SELECT @@datadir`
--let DEFARGS= --no-defaults --log-error=$MYSQLD_LOG --datadir=$MYSQLD_DATADIR --secure-file-priv="" --socket=$MYSQLD_SOCKET --skip-ssl --skip-mysqlx

--echo --
--echo -- Server is started with --bind-address=127.0.0.1,::1
--echo -- Check that server accepts incoming connection both
--echo -- on the address 127.0.0.1 and on the address ::1
--echo --
--echo -- Connecting to a server via 127.0.0.1
--connect(con1,127.0.0.1,root,,,,,TCP)

--echo -- Connecting to a server via ::1
--connect(con2,::1,root,,,,,TCP)

--connection con1
--disconnect con1

--connection con2
--disconnect con2

--connection default
SELECT @@global.bind_address;
SELECT @@global.bind_address;
SELECT @@global.bind_address;
SELECT @@global.bind_address;
