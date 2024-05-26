drop table if exists t1;
create table t1 (a int check (a>0));
insert into t1 values (1);
drop table t1;
create table t1 (a int, b int, check (a>b));
insert into t1 values (1,0);
drop table t1;
create table t1 (a int ,b int, constraint abc check (a>b));
insert into t1 values (1,0);
drop table t1;
create table t1 (a int null);
insert into t1 values (1),(NULL);
drop table t1;
create table t1 (a int null);
alter table t1 add constraint constraint_1 unique (a);
alter table t1 add constraint unique key_1(a);
alter table t1 add constraint constraint_2 unique key_2(a);
drop table t1;
drop table if exists t_illegal;
drop table if exists t_11714;
create table t_11714(a int, b int);
drop table t_11714;
CREATE TABLE t1 (f1 INT, f2 INT);
CREATE TABLE t2 (f1 INT PRIMARY KEY);
ALTER TABLE t1 ADD CONSTRAINT f2_check CHECK (f2 > 0);
ALTER TABLE t1 DROP CONSTRAINT f2_check;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1),
               ADD CONSTRAINT f2_unique UNIQUE (f2),
               ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1),
               ADD CONSTRAINT f2_check CHECK (f2 > 0);
ALTER TABLE t1 DROP CONSTRAINT fk;
ALTER TABLE t1 DROP CONSTRAINT `primary`;
ALTER TABLE t1 DROP CONSTRAINT f2_unique;
ALTER TABLE t1 DROP CONSTRAINT f2_check;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1),
               ADD CONSTRAINT f2_unique UNIQUE (f2),
               ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1),
               ADD CONSTRAINT f2_check CHECK (f2 > 0);
ALTER TABLE t1 DROP CONSTRAINT `primary`,
	       DROP CONSTRAINT f2_unique,
	       DROP CONSTRAINT fk,
	       DROP CONSTRAINT f2_check;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1),
               ADD CONSTRAINT name2 UNIQUE (f1),
               ADD CONSTRAINT `primary` FOREIGN KEY (f1) REFERENCES t2(f1),
               ADD CONSTRAINT name2 CHECK (f2 > 0);
ALTER TABLE t1 DROP PRIMARY KEY,
               DROP INDEX name2,
               DROP FOREIGN KEY `primary`,
               DROP CHECK name2;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1),
               ADD CONSTRAINT f2_unique UNIQUE (f2),
               ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1),
               ADD CONSTRAINT f2_check CHECK (f2 > 0);
ALTER TABLE t1 DROP CONSTRAINT `primary`,
               DROP FOREIGN KEY fk,
	       DROP CONSTRAINT f2_unique,
	       DROP CHECK f2_check;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1),
               ADD CONSTRAINT f2_unique UNIQUE (f2),
               ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1),
               ADD CONSTRAINT f2_check CHECK (f2 > 0),
               ADD COLUMN f3 INT;
ALTER TABLE t1 DROP CONSTRAINT `primary`, ADD CONSTRAINT PRIMARY KEY (f1),
               DROP CONSTRAINT f2_unique, ADD CONSTRAINT f2_unique UNIQUE (f3),
               DROP CONSTRAINT f2_check,
               ADD CONSTRAINT f2_check CHECK ((f3 + f2 + f1) < 999);
ALTER TABLE t1 DROP CONSTRAINT `primary`,
               DROP CONSTRAINT fk,
               DROP CONSTRAINT f2_unique,
               DROP CONSTRAINT f2_check,
               DROP COLUMN f3;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1);
ALTER TABLE t1 DROP PRIMARY KEY;
CREATE TABLE t3 (col1 INT, col2 INT GENERATED ALWAYS AS (col1) STORED);
ALTER TABLE t3 ADD UNIQUE INDEX idx (((COS( col2 ))) DESC);
ALTER TABLE t3 DROP CONSTRAINT idx;
ALTER TABLE t3 ADD UNIQUE INDEX idx (((COS( col1 ))) DESC);
DROP TABLE t3;
CREATE TEMPORARY TABLE tmp (f1 INT, f2 INT,
                            CONSTRAINT PRIMARY KEY (f1),
                            CONSTRAINT f2_unique UNIQUE(f2),
                            CONSTRAINT f2_check CHECK (f2 > 0));
ALTER TABLE tmp DROP CONSTRAINT `primary`,
                DROP CONSTRAINT f2_check,
                DROP CONSTRAINT f2_unique;
DROP TABLE tmp;
CREATE PROCEDURE drop_constraint_proc()
  ALTER TABLE t1 DROP CONSTRAINT `primary`,
                 DROP CONSTRAINT f2_unique,
                 DROP CONSTRAINT fk,
                 DROP CONSTRAINT f2_check;
ALTER TABLE t1 ADD CONSTRAINT PRIMARY KEY (f1),
               ADD CONSTRAINT f2_unique UNIQUE(f2),
               ADD CONSTRAINT fk FOREIGN KEY (f1) REFERENCES t2(f1),
               ADD CONSTRAINT f2_check CHECK (f2 > 0);
DROP PROCEDURE drop_constraint_proc;
ALTER TABLE t1 ADD COLUMN f3 INT GENERATED ALWAYS AS (f1) STORED;
CREATE PROCEDURE drop_constraint_proc()
  ALTER TABLE t1 DROP CONSTRAINT constraint_name;
ALTER TABLE t1 ADD UNIQUE INDEX constraint_name (((COS(f3))) DESC);
ALTER TABLE t1 ADD CONSTRAINT constraint_name CHECK (f2 > 0);
ALTER TABLE t1 ADD CONSTRAINT constraint_name FOREIGN KEY (f1) REFERENCES t2(f1);
DROP PROCEDURE drop_constraint_proc;
