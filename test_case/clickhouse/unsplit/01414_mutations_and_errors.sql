DROP TABLE IF EXISTS mutation_table;
CREATE TABLE mutation_table
(
    date Date,
    key UInt64,
    value String
)
ENGINE = MergeTree()
PARTITION BY date
ORDER BY tuple();
INSERT INTO mutation_table SELECT toDate('2019-10-01'), number, '42' FROM numbers(100);
INSERT INTO mutation_table SELECT toDate('2019-10-02'), number, 'Hello' FROM numbers(100);
SELECT distinct(value) FROM mutation_table ORDER BY value;
KILL MUTATION where table = 'mutation_table' and database = currentDatabase();
ALTER TABLE mutation_table MODIFY COLUMN value String SETTINGS mutations_sync = 2;
DROP TABLE IF EXISTS mutation_table;
