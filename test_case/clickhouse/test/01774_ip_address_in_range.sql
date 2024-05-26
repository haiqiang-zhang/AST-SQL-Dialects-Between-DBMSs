SELECT '# Invocation with constants';
SELECT isIPAddressInRange('127.0.0.1', '127.0.0.0/8');
SELECT '# Invocation with non-constant addresses';
WITH arrayJoin(['192.168.99.255', '192.168.100.1', '192.168.103.255', '192.168.104.0']) as addr, '192.168.100.0/22' as prefix SELECT addr, prefix, isIPAddressInRange(addr, prefix);
SELECT '# Invocation with non-constant prefixes';
SELECT '# Invocation with non-constants';
SELECT '# Check with dense table';
DROP TABLE IF EXISTS test_data;
CREATE TABLE test_data (cidr String) ENGINE = Memory;
INSERT INTO test_data
SELECT
    IPv4NumToString(IPv4CIDRToRange(IPv4StringToNum('255.255.255.255'), toUInt8(number)).1) || '/' || toString(number) AS cidr
FROM system.numbers LIMIT 33;
SELECT sum(isIPAddressInRange('0.0.0.0', cidr)) == 1 FROM test_data;
SELECT sum(isIPAddressInRange('127.0.0.0', cidr)) == 1 FROM test_data;
SELECT sum(isIPAddressInRange('128.0.0.0', cidr)) == 2 FROM test_data;
SELECT sum(isIPAddressInRange('255.0.0.0', cidr)) == 9 FROM test_data;
SELECT sum(isIPAddressInRange('255.0.0.1', cidr)) == 9 FROM test_data;
SELECT sum(isIPAddressInRange('255.0.0.255', cidr)) == 9 FROM test_data;
SELECT sum(isIPAddressInRange('255.255.255.255', cidr)) == 33 FROM test_data;
SELECT sum(isIPAddressInRange('255.255.255.254', cidr)) == 32 FROM test_data;
DROP TABLE IF EXISTS test_data;
SELECT '# Mismatching IP versions is not an error.';
SELECT '# Unparsable arguments';
SELECT '# Wrong argument types';
