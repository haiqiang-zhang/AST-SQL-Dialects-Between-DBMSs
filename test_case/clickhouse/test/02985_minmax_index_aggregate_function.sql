OPTIMIZE TABLE t_index_agg_func FINAL;
SELECT count() FROM system.parts WHERE table = 't_index_agg_func' AND database = currentDatabase() AND active;
SET force_data_skipping_indices = 'idx_v';
SET use_skip_indexes_if_final = 1;
SELECT id, finalizeAggregation(v) AS vv FROM t_index_agg_func FINAL WHERE vv >= 10 ORDER BY id;
DROP TABLE t_index_agg_func;
