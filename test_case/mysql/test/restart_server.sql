

-- Ensure when RESTART when mysqld is managed with no SUPERVISOR returns error.
--error ER_RESTART_SERVER_FAILED
RESTART;

-- 1) Set valiables to be used in parameters of mysqld_safe.
let $MYSQLD_DATADIR= `SELECT @@datadir`;
let $MYSQL_BASEDIR= `SELECT @@basedir`;
let $MYSQL_SOCKET= `SELECT @@socket`;
let $MYSQL_TIMEZONE= `SELECT @@time_zone`;
let $MYSQL_PIDFILE= `SELECT @@pid_file`;
let $MYSQL_PORT= `SELECT @@port`;
let $MYSQL_MESSAGESDIR= `SELECT @@lc_messages_dir`;
let $start_page_size= `select @@innodb_page_size`;
let $other_page_size_k=    `SELECT $start_page_size DIV 1024`;
let $other_page_size_nk=       `SELECT CONCAT($other_page_size_k,'k')`;

-- mysqld_path to be passed to --ledir
-- use test;
 my $dir = $ENV{'MYSQLTEST_VARDIR'};
 my $path = $ENV{MYSQLD};
EOF

--Get the value of the variable from to MTR, from perl
--source  $MYSQLTEST_VARDIR/tmp/mysqld_path_file.inc

--Remove the temp file
--remove_file $MYSQLTEST_VARDIR/tmp/mysqld_path_file.inc

-- 2) Shutdown mysqld which is started by mtr.
--let $_server_id= `SELECT @@server_id`
--let $_expect_file_name= $MYSQLTEST_VARDIR/tmp/mysqld.$_server_id.expect
--exec echo "wait" > $_expect_file_name
--shutdown_server
--source include/wait_until_disconnected.inc

-- 3) Run the mysqld_safe script with exec.
--exec sh $MYSQLD_SAFE --defaults-file=$MYSQLTEST_VARDIR/my.cnf --log-error=$MYSQLTEST_VARDIR/log/err.log --basedir=$MYSQL_BASEDIR --ledir=$mysqld_path --mysqld=$mysqld_bin --datadir=$MYSQLD_DATADIR --socket=$MYSQL_SOCKET --pid-file=$MYSQL_PIDFILE --port=$MYSQL_PORT --timezone=SYSTEM --log-output=file --loose-debug-sync-timeout=600 --default-storage-engine=InnoDB --default-tmp-storage-engine=InnoDB  --secure-file-priv="" --loose-skip-log-bin --core-file --lc-messages-dir=$MYSQL_MESSAGESDIR --innodb-page-size=$other_page_size_nk < /dev/null > /dev/null 2>&1 &
-- mysqld_safe takes some time to start mysqld
--enable_reconnect
--source include/wait_until_connected_again.inc
--disable_reconnect

-- 4) Reconnect to mysqld again
connection default;

-- 5) Execute the RESTART sql command.
--exec $MYSQL -h localhost -S $MYSQL_SOCKET -P $MYSQL_PORT -u root -e "RESTART" 2>&1
--source include/wait_until_disconnected.inc
-- mysqld_safe takes some time to restart mysqld
--enable_reconnect
--source include/wait_until_connected_again.inc
--echo -- Executing a sql command after RESTART.
SELECT 1;

-- 5.1) Create user and GRANT shutdown privilege on the user, execute RESTART.
-- First check check user can't execute RESTART without SHUTDOWN privilege.
CREATE USER u1@localhost;
DROP USER u1@localhost;
