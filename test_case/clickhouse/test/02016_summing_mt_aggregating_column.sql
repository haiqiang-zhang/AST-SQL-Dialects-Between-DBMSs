OPTIMIZE TABLE summing_mt_aggregating_column FINAL;
SELECT Key, any(Value), any(ConcatArraySimple), groupArrayArrayMerge(ConcatArrayComplex) FROM summing_mt_aggregating_column GROUP BY Key;
DROP TABLE IF EXISTS summing_mt_aggregating_column;
