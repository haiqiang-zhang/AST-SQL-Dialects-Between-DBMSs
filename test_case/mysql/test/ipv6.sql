
-- Test of ipv6 format
-- Options: --skip-name-resolve (see corresponding opt file).
--
--source include/check_ipv6.inc
--source include/add_extra_root_users.inc

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

echo =============Test of '::1' ========================================;
let $IPv6= ::1;
let $IPv6= 127.0.0.1;
let $IPv6= ::1/128;
let $IPv6= 0000:0000:0000:0000:0000:0000:0000:0001;
let $IPv6= 0:0:0:0:0:0:0:1;
