DROP TABLE IF EXISTS agg_func_col;
set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE agg_func_col (p Date, k UInt8, d AggregateFunction(sum, UInt64) DEFAULT arrayReduce('sumState', [toUInt64(200)])) ENGINE = AggregatingMergeTree(p, k, 1);
INSERT INTO agg_func_col (k) VALUES (0);
INSERT INTO agg_func_col (k, d) SELECT 1 AS k, arrayReduce('sumState', [toUInt64(100)]) AS d;
