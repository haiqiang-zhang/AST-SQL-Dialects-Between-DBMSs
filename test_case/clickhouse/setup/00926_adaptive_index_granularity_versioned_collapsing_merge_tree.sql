DROP TABLE IF EXISTS zero_rows_per_granule;
CREATE TABLE zero_rows_per_granule (
  p Date,
  k UInt64,
  v1 UInt64,
  v2 Int64,
  Sign Int8,
  Version UInt8
) ENGINE VersionedCollapsingMergeTree(Sign, Version) PARTITION BY toYYYYMM(p) ORDER BY k
  SETTINGS index_granularity_bytes = 20,
           min_index_granularity_bytes = 10,
           write_final_mark = 0,
           enable_vertical_merge_algorithm=1,
           vertical_merge_algorithm_min_rows_to_activate=0,
           vertical_merge_algorithm_min_columns_to_activate=0,
           min_bytes_for_wide_part = 0,
           min_rows_for_wide_part = 0;
INSERT INTO zero_rows_per_granule (p, k, v1, v2, Sign, Version) VALUES ('2018-05-15', 1, 1000, 2000, 1, 1), ('2018-05-16', 2, 3000, 4000, 1, 1), ('2018-05-17', 3, 5000, 6000, 1, 1), ('2018-05-18', 4, 7000, 8000, 1, 1);