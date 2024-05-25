ATTACH ':memory:' AS db1;
CREATE TABLE db1.integers(i INTEGER);;
INSERT INTO db1.integers VALUES (1), (2), (3), (NULL);;
EXPORT DATABASE db1 TO '__TEST_DIR__/export_test' (FORMAT CSV);
SELECT * FROM integers;
IMPORT DATABASE '__TEST_DIR__/export_test';
SELECT * FROM integers ORDER BY i NULLS LAST;
