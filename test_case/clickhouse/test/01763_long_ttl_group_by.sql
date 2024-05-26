SELECT sum(value), min(min_value), max(max_value), uniqExact(key) FROM test_ttl_group_by01763;
DROP TABLE test_ttl_group_by01763;
