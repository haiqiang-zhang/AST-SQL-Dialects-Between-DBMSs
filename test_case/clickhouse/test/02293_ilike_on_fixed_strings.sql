SELECT col, col LIKE '%a', col ILIKE '%a' FROM tab WHERE col = 'AA';
SELECT col, col LIKE '%a', col ILIKE '%a' FROM tab WHERE col = 'Aa';
DROP TABLE IF EXISTS tab;
