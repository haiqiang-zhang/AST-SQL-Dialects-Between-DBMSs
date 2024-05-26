PREPARE drop_constraint_stmt FROM
  'ALTER TABLE t1 DROP CONSTRAINT `primary`,
                  DROP CONSTRAINT f2_unique,
                  DROP CONSTRAINT fk,
                  DROP CONSTRAINT f2_check';
DROP PREPARE drop_constraint_stmt;
ALTER TABLE t1 ALTER CONSTRAINT f2_check NOT ENFORCED;
ALTER TABLE t1 DROP CONSTRAINT f2_check;
ALTER TABLE t1 ADD CONSTRAINT f2_check CHECK (f2 > 0);
ALTER TABLE t1 ALTER CHECK f2_check NOT ENFORCED, ALTER CHECK f2_check ENFORCED;
ALTER TABLE t1 ALTER CONSTRAINT f2_check NOT ENFORCED, ALTER CONSTRAINT f2_check ENFORCED;
ALTER TABLE t1 ALTER CHECK f2_check NOT ENFORCED, ALTER CONSTRAINT f2_check ENFORCED;
ALTER TABLE t1 DROP CONSTRAINT f2_check;
CREATE PROCEDURE drop_constraint_proc()
  ALTER TABLE t1 DROP CONSTRAINT `primary`,
                 DROP CONSTRAINT f2_unique,
                 DROP CONSTRAINT fk,
                 DROP CONSTRAINT f2_check;
CREATE PROCEDURE alter_constraint_proc()
  ALTER TABLE t1 ALTER CONSTRAINT f2_check NOT ENFORCED;
DROP PROCEDURE alter_constraint_proc;
DROP PROCEDURE drop_constraint_proc;
CREATE PROCEDURE alter_constraint_proc()
  ALTER TABLE t1 ALTER CONSTRAINT constraint_name NOT ENFORCED;
DROP PROCEDURE alter_constraint_proc;
PREPARE drop_constraint_stmt FROM
  'ALTER TABLE t1 DROP CONSTRAINT `primary`,
                  DROP CONSTRAINT f2_unique,
                  DROP CONSTRAINT fk,
                  DROP CONSTRAINT f2_check';
PREPARE alter_constraint_stmt FROM
  'ALTER TABLE t1 ALTER CONSTRAINT f2_check NOT ENFORCED';
DROP PREPARE alter_constraint_stmt;
DROP PREPARE drop_constraint_stmt;
CREATE TEMPORARY TABLE tmp (f1 INT, f2 INT,
                            CONSTRAINT PRIMARY KEY (f1),
                            CONSTRAINT f2_unique UNIQUE(f2),
                            CONSTRAINT f2_check CHECK (f2 > 0));
ALTER TABLE tmp ALTER CONSTRAINT f2_check NOT ENFORCED;
DROP TABLE tmp;
DROP TABLE t1, t2;
