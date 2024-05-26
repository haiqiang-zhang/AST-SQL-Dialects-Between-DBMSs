SELECT COUNT() from test_vertical_merge WHERE val2 <= 2400;
OPTIMIZE TABLE test_vertical_merge FINAL;
DROP TABLE IF EXISTS test_vertical_merge;
