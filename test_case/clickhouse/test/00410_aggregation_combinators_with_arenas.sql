SELECT length(groupUniqArrayIf(d, d != hex(0))) FROM arena GROUP BY k;
SELECT length(groupUniqArrayMerge(ds)) FROM (SELECT k, groupUniqArrayState(d) AS ds FROM arena GROUP BY k) GROUP BY k;
DROP TABLE IF EXISTS arena;
SELECT length(arrayReduce('groupUniqArray', [[1, 2], [1],  emptyArrayUInt8(), [1], [1, 2]]));
SELECT min(x), max(x) FROM (SELECT length(arrayReduce('groupUniqArray', [hex(number), hex(number+1), hex(number)])) AS x FROM system.numbers LIMIT 100000);
SET max_bytes_before_external_group_by = 0;
