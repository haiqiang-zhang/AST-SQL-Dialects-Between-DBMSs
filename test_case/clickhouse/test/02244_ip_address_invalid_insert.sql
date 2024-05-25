SELECT ip, ipv4 FROM test_table_ipv4;
DROP TABLE test_table_ipv4;
DROP TABLE IF EXISTS test_table_ipv4_materialized;
CREATE TABLE test_table_ipv4_materialized
(
    ip String,
    ipv6 IPv4 MATERIALIZED toIPv4(ip)
) ENGINE = TinyLog;
SET cast_ipv4_ipv6_default_on_conversion_error = 1;
INSERT INTO test_table_ipv4_materialized(ip) VALUES ('1.1.1.1'), ('');
SELECT ip, ipv6 FROM test_table_ipv4_materialized;
SET cast_ipv4_ipv6_default_on_conversion_error = 0;
DROP TABLE test_table_ipv4_materialized;
DROP TABLE IF EXISTS test_table_ipv6;
CREATE TABLE test_table_ipv6
(
    ip String,
    ipv6 IPv6
) ENGINE = TinyLog;
SELECT ip, ipv6 FROM test_table_ipv6;
DROP TABLE test_table_ipv6;
DROP TABLE IF EXISTS test_table_ipv6_materialized;
CREATE TABLE test_table_ipv6_materialized
(
    ip String,
    ipv6 IPv6 MATERIALIZED toIPv6(ip)
) ENGINE = TinyLog;
SET cast_ipv4_ipv6_default_on_conversion_error = 1;
INSERT INTO test_table_ipv6_materialized(ip) VALUES ('fe80::9801:43ff:fe1f:7690'), ('1.1.1.1'), ('');
SELECT ip, ipv6 FROM test_table_ipv6_materialized;
SET cast_ipv4_ipv6_default_on_conversion_error = 0;
DROP TABLE test_table_ipv6_materialized;
