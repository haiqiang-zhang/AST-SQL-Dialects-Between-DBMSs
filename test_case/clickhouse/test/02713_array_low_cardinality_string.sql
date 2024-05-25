SELECT '---';
SELECT table, name, type
FROM system.data_skipping_indices
WHERE database = currentDatabase() AND table = 'tab';
SELECT '---';
EXPLAIN indexes = 1, description = 0 SELECT * FROM tab WHERE has(foo, 'b');
DROP TABLE tab;
