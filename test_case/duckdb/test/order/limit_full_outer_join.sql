SELECT i, j, k, l FROM integers FULL OUTER JOIN integers2 ON integers.i=integers2.k ORDER BY ALL LIMIT 2;
SELECT COUNT(*) FROM (SELECT i, j, k, l FROM integers FULL OUTER JOIN integers2 ON integers.i=integers2.k LIMIT 2) tbl;
