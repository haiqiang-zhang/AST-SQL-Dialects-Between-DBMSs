SELECT n.x FROM table_for_rename_nested WHERE key = 7;
SELECT n.y FROM table_for_rename_nested WHERE key = 7;
SHOW CREATE TABLE table_for_rename_nested;
ALTER TABLE table_for_rename_nested RENAME COLUMN n.x TO n.renamed_x;
ALTER TABLE table_for_rename_nested RENAME COLUMN n.y TO n.renamed_y;
SHOW CREATE TABLE table_for_rename_nested;
SELECT key, n.renamed_x FROM table_for_rename_nested WHERE key = 7;
SELECT key, n.renamed_y FROM table_for_rename_nested WHERE key = 7;
DROP TABLE IF EXISTS table_for_rename_nested;
