
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

connect (ssl_con,localhost,root,,,,,SSL);

let $str = `SELECT REPEAT('X', 33554432)`;
let $str = zzzzzzzzzzzzzzzz$str;
