
-- Test of ipv4 (127.0.0.1) in ipv6 format
-- Options: --skip-name-resolve, --bind-address=0.0.0.0 (see corresponding opt file).
--

--source include/have_ipv4_mapped.inc
--source include/add_extra_root_users.inc

-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

echo =============Test of '127.0.0.1' (IPv4) ===========================;
let $IPv6= 127.0.0.1;
let $IPv6= 0:0:0:0:0:FFFF:127.0.0.1;
let $IPv6= 0000:0000:0000:0000:0000:FFFF:127.0.0.1;
let $IPv6= 0:0000:0000:0:0000:FFFF:127.0.0.1;
let $IPv6= 0::0000:FFFF:127.0.0.1;
let $IPv6= 0:0:0:0:0:FFFF:127.0.0.1/96;
let $IPv6= ::FFFF:127.0.0.1;
let $IPv6= ::FFFF:127.0.0.1/96;
let $IPv6= ::1;
