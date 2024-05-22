DROP TABLE IF EXISTS table_map;
CREATE TABLE table_map (id UInt32, col Map(String, UInt64)) engine = MergeTree() ORDER BY tuple();
INSERT INTO table_map SELECT number, map('key1', number, 'key2', number * 2) FROM numbers(1111, 3);
INSERT INTO table_map SELECT number, map('key3', number, 'key2', number + 1, 'key4', number + 2) FROM numbers(100, 4);
SELECT mapFilter((k, v) -> k like '%3' and v > 102, col) FROM table_map ORDER BY id;
SELECT col, mapFilter((k, v) -> ((v % 10) > 1), col) FROM table_map ORDER BY id ASC;
SELECT mapApply((k, v) -> (k, v + 1), col) FROM table_map ORDER BY id;
SELECT mapFilter((k, v) -> 0, col) from table_map;
SELECT mapConcat(col, map('key5', 500), map('key6', 600)) FROM table_map ORDER BY id;
SELECT mapConcat(col, materialize(map('key5', 500)), map('key6', 600)) FROM table_map ORDER BY id;
SELECT concat(map('key5', 500), map('key6', 600));
SELECT map('key5', 500) || map('key6', 600);
SELECT mapExists((k, v) -> k LIKE '%3', col) FROM table_map ORDER BY id;
SELECT mapExists((k, v) -> k LIKE '%2' AND v < 1000, col) FROM table_map ORDER BY id;
SELECT mapSort(col) FROM table_map ORDER BY id;
SELECT mapSort((k, v) -> v, col) FROM table_map ORDER BY id;
SELECT mapPartialSort((k, v) -> k, 2, col) FROM table_map ORDER BY id;
SELECT mapUpdate(map(1, 3, 3, 2), map(1, 0, 2, 0));
SELECT mapApply((x, y) -> (x, x + 1), map(1, 0, 2, 0));
SELECT mapApply((x, y) -> (x, x + 1), materialize(map(1, 0, 2, 0)));
SELECT mapApply((x, y) -> ('x', 'y'), map(1, 0, 2, 0));
SELECT mapApply((x, y) -> ('x', 'y'), materialize(map(1, 0, 2, 0)));
SELECT mapUpdate(map('k1', 1, 'k2', 2), map('k1', 11, 'k2', 22));
SELECT mapUpdate(materialize(map('k1', 1, 'k2', 2)), map('k1', 11, 'k2', 22));
SELECT mapUpdate(map('k1', 1, 'k2', 2), materialize(map('k1', 11, 'k2', 22)));
SELECT mapUpdate(materialize(map('k1', 1, 'k2', 2)), materialize(map('k1', 11, 'k2', 22)));
SELECT mapUpdate(map('k1', 1, 'k2', 2, 'k3', 3), map('k2', 22, 'k3', 33, 'k4', 44));
SELECT mapUpdate(materialize(map('k1', 1, 'k2', 2, 'k3', 3)), map('k2', 22, 'k3', 33, 'k4', 44));
SELECT mapUpdate(map('k1', 1, 'k2', 2, 'k3', 3), materialize(map('k2', 22, 'k3', 33, 'k4', 44)));
SELECT mapUpdate(materialize(map('k1', 1, 'k2', 2, 'k3', 3)), materialize(map('k2', 22, 'k3', 33, 'k4', 44)));
SELECT mapUpdate(map('k1', 1, 'k2', 2), map('k3', 33, 'k4', 44));
SELECT mapUpdate(materialize(map('k1', 1, 'k2', 2)), map('k3', 33, 'k4', 44));
SELECT mapUpdate(map('k1', 1, 'k2', 2), materialize(map('k3', 33, 'k4', 44)));
SELECT mapUpdate(materialize(map('k1', 1, 'k2', 2)), materialize(map('k3', 33, 'k4', 44)));
WITH (range(0, number % 10), range(0, number % 10))::Map(UInt64, UInt64) AS m1,
     (range(0, number % 10, 2), arrayMap(x -> x * x, range(0, number % 10, 2)))::Map(UInt64, UInt64) AS m2
SELECT DISTINCT mapUpdate(m1, m2) FROM numbers (100000);
SELECT mapApply((x) -> (x, x), map(1, 0, 2, 0));
DROP TABLE table_map;
