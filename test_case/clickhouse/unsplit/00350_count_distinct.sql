SET count_distinct_implementation = 'uniq';
SELECT count(DISTINCT x) FROM (SELECT number % 123 AS x FROM system.numbers LIMIT 1000);
SET count_distinct_implementation = 'uniqCombined';
SET count_distinct_implementation = 'uniqExact';
