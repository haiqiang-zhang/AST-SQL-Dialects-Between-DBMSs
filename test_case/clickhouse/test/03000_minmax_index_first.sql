SELECT trim(explain) FROM ( EXPLAIN indexes = 1 SELECT * FROM skip_table WHERE v = 125) WHERE explain like '%Name%';
DROP TABLE skip_table;
