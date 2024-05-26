CREATE TEMPORARY TABLE t (x UInt8);
SET empty_result_for_aggregation_by_empty_set = 0;
SELECT count() FROM system.one WHERE 0;
SELECT count(), uniq(x), avg(x), avg(toNullable(x)), groupArray(x), groupUniqArray(x) FROM t;
SET empty_result_for_aggregation_by_empty_set = 1;
