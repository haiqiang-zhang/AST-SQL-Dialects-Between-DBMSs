SELECT i FROM tbl ORDER BY i;
SELECT i FROM tbl ORDER BY i DESC;
SELECT i, COUNT(*) FROM tbl GROUP BY i ORDER BY i;
SELECT MIN(i), MAX(i) FROM tbl;
SELECT FIRST(i ORDER BY id), FIRST(i) FILTER (id=4) FROM tbl;
SELECT id, i, j FROM tbl JOIN tbl2 USING (id);
SELECT tbl.id, tbl2.id, i, j FROM tbl JOIN tbl2 ON (i=j) ORDER BY tbl.id;
