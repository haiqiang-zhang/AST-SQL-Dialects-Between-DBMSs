CREATE TABLE integers(i INTEGER, j INTEGER, k INTEGER);
CREATE INDEX i_index ON integers((j + 1), k);
SELECT * FROM duckdb_indexes();;
SELECT * FROM duckdb_indexes;;
