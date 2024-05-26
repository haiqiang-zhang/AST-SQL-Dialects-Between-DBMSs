SELECT countMerge(x + y) FROM (SELECT countState(a) as x, countState(b) as y from add_aggregate);
SELECT sumMerge(x + y), sumMerge(x), sumMerge(y) FROM (SELECT sumState(a) as x, sumState(b) as y from add_aggregate);
SELECT minMerge(x) FROM (SELECT minState(a) + minState(b) as x FROM add_aggregate);
SELECT uniqMerge(x + y) FROM (SELECT uniqState(a) as x, uniqState(b) as y FROM add_aggregate);
SELECT arraySort(groupArrayMerge(x + y)) FROM (SELECT groupArrayState(a) AS x, groupArrayState(b) as y FROM add_aggregate);
DROP TABLE IF EXISTS add_aggregate;
