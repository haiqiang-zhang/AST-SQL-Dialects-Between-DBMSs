
let $MYSQL_PORT= `SELECT @@port`;
let $MYSQL_SOCKET= `SELECT @@socket`;
let $MYSQL_DATADIR= `SELECT @@datadir`;
let $MYSQL_PIDFILE= `SELECT @@pid_file`;
let $MYSQL_MESSAGESDIR= `SELECT @@lc_messages_dir`;

SET PERSIST_ONLY ssl_ca = 'mohit';
SELECT @@global.ssl_ca;
