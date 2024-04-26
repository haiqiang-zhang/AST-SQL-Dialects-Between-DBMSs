
-- Thread stack overrun on solaris
--source include/not_sparc_debug.inc

--echo
--echo -- Suppress warnings if IP address cannot not be resolved.
call mtr.add_suppression("2001:db8::6:6");
SET GLOBAL DEBUG = '+d, vio_peer_addr_fake_ipv6, getaddrinfo_fake_good_ipv6';
CREATE USER 'morty'@'2001:db8::6:6';
SET GLOBAL DEBUG = '+d, getnameinfo_fake_max_length_plus_1';
SET GLOBAL DEBUG = '-d, getnameinfo_fake_max_length_plus_1';
SET GLOBAL DEBUG = '+d, getnameinfo_fake_max_length';
SELECT CURRENT_USER();
SELECT host FROM performance_schema.hosts WHERE host LIKE 'aaaa%';
SELECT user, host FROM performance_schema.accounts WHERE user='morty';
SELECT ip, host FROM performance_schema.host_cache WHERE host LIKE 'aaaa%';
SET GLOBAL DEBUG = '-d, getnameinfo_fake_max_length';
SET GLOBAL DEBUG = '-d, vio_peer_addr_fake_ipv6, getaddrinfo_fake_good_ipv6';
DROP USER 'morty'@'2001:db8::6:6';
SET GLOBAL DEBUG = default;
