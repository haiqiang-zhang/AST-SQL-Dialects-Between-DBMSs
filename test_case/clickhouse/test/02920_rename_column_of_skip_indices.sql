SYSTEM STOP MERGES t;
SET alter_sync = 0;
ALTER TABLE t RENAME COLUMN value1 TO value11;
SELECT * FROM t WHERE value11 = '000' SETTINGS max_rows_to_read = 0;
SYSTEM START MERGES t;
ALTER TABLE t RENAME COLUMN value11 TO value12 SETTINGS mutations_sync = 2;
SELECT * FROM t WHERE value12 = '000' SETTINGS max_rows_to_read = 0;
DROP TABLE t;
