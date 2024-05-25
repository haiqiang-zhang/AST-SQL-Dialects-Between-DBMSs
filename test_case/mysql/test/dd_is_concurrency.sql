CREATE TABLE t1 (f1 int) COMMENT='abc';
SELECT table_name, table_comment
  FROM INFORMATION_SCHEMA.TABLES
  WHERE table_name='t1';
SELECT table_name, table_comment
  FROM INFORMATION_SCHEMA.TABLES
  WHERE table_name='t1';
SELECT table_name, table_comment
  FROM INFORMATION_SCHEMA.TABLES
  WHERE table_name='t1';
SELECT table_name, table_comment
  FROM INFORMATION_SCHEMA.TABLES
  WHERE table_name='t1';
DROP TABLE t1;
