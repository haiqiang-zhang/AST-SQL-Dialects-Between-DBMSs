CREATE TABLE t1 (c1 INT PRIMARY KEY);
SELECT unique_constraint_schema, referenced_table_name
  FROM information_schema.referential_constraints WHERE table_name = 't2';
