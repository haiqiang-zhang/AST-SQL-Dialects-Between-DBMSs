DROP TABLE IF EXISTS test;
CREATE TABLE test (uid String, version UInt32, is_deleted UInt8) ENGINE = ReplacingMergeTree(version, is_deleted) Order by (uid) SETTINGS vertical_merge_algorithm_min_rows_to_activate = 1,
    vertical_merge_algorithm_min_columns_to_activate = 0,
    min_rows_for_wide_part = 1,
    min_bytes_for_wide_part = 1,
    allow_experimental_replacing_merge_with_cleanup=1;
INSERT INTO test (*) VALUES ('d1', 1, 0), ('d1', 2, 1), ('d1', 3, 0), ('d1', 4, 1), ('d1', 5, 0), ('d2', 1, 0), ('d3', 1, 0), ('d4', 1, 0),  ('d5', 1, 0), ('d6', 1, 0), ('d6', 3, 0);
INSERT INTO test (*) VALUES ('d1', 1, 0), ('d1', 2, 1), ('d1', 3, 0), ('d1', 4, 1), ('d1', 5, 0), ('d2', 1, 0), ('d3', 1, 0), ('d4', 1, 0),  ('d5', 1, 0), ('d6', 1, 0), ('d6', 2, 1);
SELECT '== Only last version remains after OPTIMIZE W/ CLEANUP ==';
OPTIMIZE TABLE test FINAL CLEANUP;
select * from test order by uid;
INSERT INTO test (*) VALUES ('d1', 1, 0), ('d1', 2, 1), ('d1', 3, 0), ('d1', 4, 1), ('d1', 5, 0), ('d2', 1, 0), ('d3', 1, 0), ('d4', 1, 0),  ('d5', 1, 0), ('d6', 1, 0), ('d6', 3, 1);
SELECT '== OPTIMIZE W/ CLEANUP (remove d6) ==';
OPTIMIZE TABLE test FINAL CLEANUP;
select * from test order by uid;
DROP TABLE IF EXISTS test;
