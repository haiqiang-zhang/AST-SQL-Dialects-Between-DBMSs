--

--source include/not_windows.inc

-- Set valiables to be used in parameters of mysqld.
let $MYSQLD_DATADIR= `SELECT @@datadir`;
let $MYSQL_BASEDIR= `SELECT @@basedir`;
let $MYSQL_SOCKET= `SELECT @@socket`;
let $MYSQL_TIMEZONE= `SELECT @@time_zone`;
let $MYSQL_PIDFILE= `SELECT @@pid_file`;
let $MYSQL_PORT= `SELECT @@port`;
let $MYSQL_MESSAGESDIR= `SELECT @@lc_messages_dir`;
let $start_page_size= `SELECT @@innodb_page_size`;
let $other_page_size_k= `SELECT $start_page_size DIV 1024`;
let $other_page_size_nk= `SELECT CONCAT($other_page_size_k,'k')`;
