DESCRIBE TABLE null_00557;
ALTER TABLE null_00557 ADD COLUMN y String, MODIFY COLUMN x Int64 DEFAULT toInt64(y);
DESCRIBE TABLE null_00557;
DROP TABLE null_00557;