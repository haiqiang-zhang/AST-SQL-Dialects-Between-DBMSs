SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs WHERE id%2<>0;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs JOIN other_table USING (id);
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs LEFT JOIN other_table USING (id);
SELECT structs.j, COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id)
FROM structs
LEFT JOIN other_table o1 USING (id)
CROSS JOIN other_table
WHERE ((structs.j IN (0, 1) AND (structs.id=other_table.id)) OR (structs.j=2 AND structs.id+1=other_table.id))
GROUP BY ALL
ORDER BY ALL;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs WHERE id%2<>0;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs JOIN other_table USING (id);
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs LEFT JOIN other_table USING (id);
SELECT structs.j, COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id)
FROM structs
LEFT JOIN other_table o1 USING (id)
CROSS JOIN other_table
WHERE ((structs.j IN (0, 1) AND (structs.id=other_table.id)) OR (structs.j=2 AND structs.id+1=other_table.id))
GROUP BY ALL
ORDER BY ALL;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs WHERE id%2<>0;
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs JOIN other_table USING (id);
SELECT COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id) FROM structs LEFT JOIN other_table USING (id);
SELECT structs.j, COUNT(*), COUNT(s), COUNT(DISTINCT s), COUNT(DISTINCT structs.id)
FROM structs
LEFT JOIN other_table o1 USING (id)
CROSS JOIN other_table
WHERE ((structs.j IN (0, 1) AND (structs.id=other_table.id)) OR (structs.j=2 AND structs.id+1=other_table.id))
GROUP BY ALL
ORDER BY ALL;
