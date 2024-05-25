SELECT * FROM compress_table;
ALTER TABLE compress_table MODIFY COLUMN value3 CODEC(Default);
INSERT INTO compress_table VALUES(2, '2', '2', '2');
SELECT * FROM compress_table ORDER BY key;
DESCRIBE TABLE compress_table;
SHOW CREATE TABLE compress_table;
DROP TABLE IF EXISTS compress_table;
