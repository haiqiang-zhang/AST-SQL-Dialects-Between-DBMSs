SELECT mapFilter((k, v) -> k like '%3' and v > 102, col) FROM table_map ORDER BY id;
SELECT mapApply((k, v) -> (k, v + 1), col) FROM table_map ORDER BY id;
SELECT mapConcat(col, map('key5', 500), map('key6', 600)) FROM table_map ORDER BY id;
SELECT concat(map('key5', 500), map('key6', 600));
SELECT map('key5', 500) || map('key6', 600);
SELECT mapExists((k, v) -> k LIKE '%3', col) FROM table_map ORDER BY id;
SELECT mapSort(col) FROM table_map ORDER BY id;
SELECT mapPartialSort((k, v) -> k, 2, col) FROM table_map ORDER BY id;
SELECT mapUpdate(map(1, 3, 3, 2), map(1, 0, 2, 0));
WITH (range(0, number % 10), range(0, number % 10))::Map(UInt64, UInt64) AS m1,
     (range(0, number % 10, 2), arrayMap(x -> x * x, range(0, number % 10, 2)))::Map(UInt64, UInt64) AS m2
SELECT DISTINCT mapUpdate(m1, m2) FROM numbers (100000);
DROP TABLE table_map;
