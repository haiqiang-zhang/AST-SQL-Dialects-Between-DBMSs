PRAGMA enable_verification;
CREATE TABLE structs AS SELECT i id, {'i': i} s, i%3 j FROM generate_series(0,99,1) tbl(i), generate_series(0,1,1);;
CREATE TABLE other_table AS SELECT i id, i%3 j FROM generate_series(0,99,1) tbl(i) WHERE i%2=0;;
DROP TABLE structs;;
DROP TABLE other_table;
CREATE TABLE structs AS SELECT i id, {'i': [i, i + 1, i + 2], 'j': CASE WHEN i%4=1 THEN NULL ELSE [i, i] END} s, i%3 j FROM generate_series(0,99,1) tbl(i), generate_series(0,1,1);;
CREATE TABLE other_table AS SELECT i id, i%3 j FROM generate_series(0,99,1) tbl(i) WHERE i%2=0;;
DROP TABLE structs;;
DROP TABLE other_table;
CREATE TABLE structs AS SELECT i id, {'i': {'j': [i + 1, i + 2, i + 3], 'k': i}, 'l': NULL} s, i%3 j FROM generate_series(0,99,1) tbl(i), generate_series(0,1,1);;
CREATE TABLE other_table AS SELECT i id, i%3 j FROM generate_series(0,99,1) tbl(i) WHERE i%2=0;;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs;;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs WHERE id%2<>0;;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs JOIN other_table USING (id);;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs LEFT JOIN other_table USING (id);;
SELECT structs.j, COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id)
FROM structs
LEFT JOIN other_table o1 USING (id)
CROSS JOIN other_table
WHERE ((structs.j IN (0, 1) AND (structs.id=other_table.id)) OR (structs.j=2 AND structs.id+1=other_table.id))
GROUP BY ALL
ORDER BY ALL;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs;;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs WHERE id%2<>0;;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs JOIN other_table USING (id);;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs LEFT JOIN other_table USING (id);;
SELECT structs.j, COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id)
FROM structs
LEFT JOIN other_table o1 USING (id)
CROSS JOIN other_table
WHERE ((structs.j IN (0, 1) AND (structs.id=other_table.id)) OR (structs.j=2 AND structs.id+1=other_table.id))
GROUP BY ALL
ORDER BY ALL;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs;;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs WHERE id%2<>0;;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs JOIN other_table USING (id);;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs LEFT JOIN other_table USING (id);;
SELECT structs.j, COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id)
FROM structs
LEFT JOIN other_table o1 USING (id)
CROSS JOIN other_table
WHERE ((structs.j IN (0, 1) AND (structs.id=other_table.id)) OR (structs.j=2 AND structs.id+1=other_table.id))
GROUP BY ALL
ORDER BY ALL;
