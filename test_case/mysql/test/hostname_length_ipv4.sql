
-- Thread stack overrun on solaris
--source include/not_sparc_debug.inc

--echo
--echo -- Suppress warnings if IP address cannot not be resolved.
call mtr.add_suppression("192.0.2.4");
SET GLOBAL DEBUG = '+d, vio_peer_addr_fake_ipv4, getaddrinfo_fake_good_ipv4';
CREATE USER 'rick'@'192.0.2.4';
SET GLOBAL DEBUG = '+d, getnameinfo_fake_max_length_plus_1';
SET GLOBAL DEBUG = '-d, getnameinfo_fake_max_length_plus_1';
SET GLOBAL DEBUG = '+d, getnameinfo_fake_max_length';
SELECT CURRENT_USER();
SELECT host FROM performance_schema.hosts WHERE host LIKE 'aaaa%';
SELECT user, host FROM performance_schema.accounts WHERE user='rick';
SELECT ip, host FROM performance_schema.host_cache WHERE host LIKE 'aaaa%';
SET GLOBAL DEBUG = '-d, getnameinfo_fake_max_length';
SET GLOBAL DEBUG = '-d, vio_peer_addr_fake_ipv4, getaddrinfo_fake_good_ipv4';
DROP USER 'rick'@'192.0.2.4';
SET GLOBAL DEBUG = default;
