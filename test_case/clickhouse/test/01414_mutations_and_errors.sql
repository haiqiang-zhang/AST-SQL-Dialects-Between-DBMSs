SELECT distinct(value) FROM mutation_table ORDER BY value;
KILL MUTATION where table = 'mutation_table' and database = currentDatabase();
ALTER TABLE mutation_table MODIFY COLUMN value String SETTINGS mutations_sync = 2;
SELECT distinct(value) FROM mutation_table ORDER BY value;
DROP TABLE IF EXISTS mutation_table;
