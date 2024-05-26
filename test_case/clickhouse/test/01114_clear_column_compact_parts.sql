SELECT * FROM clear_column ORDER BY x;
ALTER TABLE clear_column CLEAR COLUMN y IN PARTITION 2;
SELECT * FROM clear_column ORDER BY x;
DROP TABLE clear_column;
