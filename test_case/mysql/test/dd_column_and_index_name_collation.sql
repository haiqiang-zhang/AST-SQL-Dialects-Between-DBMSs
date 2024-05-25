SELECT table_name, column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name= 't1' ORDER BY column_name;
SELECT table_name, column_name FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name= 't2' ORDER BY column_name;
SELECT table_name, index_name, column_name FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME= 't1' ORDER BY index_name;
SELECT table_name, index_name, column_name FROM INFORMATION_SCHEMA.STATISTICS WHERE TABLE_NAME= 't2' ORDER BY index_name;
DROP TABLE t2, t1;
