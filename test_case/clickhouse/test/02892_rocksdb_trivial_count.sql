SELECT count() FROM dict SETTINGS optimize_trivial_approximate_count_query = 1, max_rows_to_read = 1;
SET optimize_trivial_approximate_count_query = 1;
DETACH TABLE dict SYNC;
ATTACH TABLE dict;
