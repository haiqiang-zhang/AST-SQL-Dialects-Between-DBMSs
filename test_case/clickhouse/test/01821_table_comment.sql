SELECT
    name,
    comment
FROM system.tables
WHERE name IN ('t1', 't2', 't3') AND database = currentDatabase() order by name;
SHOW CREATE TABLE t1;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
