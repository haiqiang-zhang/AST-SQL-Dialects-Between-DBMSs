SET cast_ipv4_ipv6_default_on_conversion_error = 1;
DROP TABLE IF EXISTS ipv4_test;
CREATE TABLE ipv4_test
(
    id UInt64,
    value String
) ENGINE=MergeTree ORDER BY id;
ALTER TABLE ipv4_test MODIFY COLUMN value IPv4 DEFAULT '';
SET cast_ipv4_ipv6_default_on_conversion_error = 0;
