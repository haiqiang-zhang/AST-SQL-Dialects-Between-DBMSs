SET client_min_messages TO 'warning';
RESET client_min_messages;
CREATE TABLE attmp (initial int4);
COMMENT ON TABLE attmp IS 'table comment';
COMMENT ON TABLE attmp IS NULL;
ALTER TABLE attmp ADD COLUMN a int4 default 3;
ALTER TABLE attmp ADD COLUMN b name;
ALTER TABLE attmp ADD COLUMN c text;
ALTER TABLE attmp ADD COLUMN d float8;
ALTER TABLE attmp ADD COLUMN e float4;
ALTER TABLE attmp ADD COLUMN f int2;
ALTER TABLE attmp ADD COLUMN g polygon;
ALTER TABLE attmp ADD COLUMN i char;
ALTER TABLE attmp ADD COLUMN k int4;
ALTER TABLE attmp ADD COLUMN l tid;
ALTER TABLE attmp ADD COLUMN m xid;
ALTER TABLE attmp ADD COLUMN n oidvector;
ALTER TABLE attmp ADD COLUMN p boolean;
ALTER TABLE attmp ADD COLUMN q point;
ALTER TABLE attmp ADD COLUMN r lseg;
ALTER TABLE attmp ADD COLUMN s path;
ALTER TABLE attmp ADD COLUMN t box;
ALTER TABLE attmp ADD COLUMN v timestamp;
ALTER TABLE attmp ADD COLUMN w interval;
ALTER TABLE attmp ADD COLUMN x float8[];
ALTER TABLE attmp ADD COLUMN y float4[];
ALTER TABLE attmp ADD COLUMN z int2[];
INSERT INTO attmp (a, b, c, d, e, f, g,    i,    k, l, m, n, p, q, r, s, t,
	v, w, x, y, z)
   VALUES (4, 'name', 'text', 4.1, 4.1, 2, '(4.1,4.1,3.1,3.1)',
	'c',
	314159, '(1,1)', '512',
	'1 2 3 4 5 6 7 8', true, '(1.1,1.1)', '(4.1,4.1,3.1,3.1)',
	'(0,2,4.1,4.1,3.1,3.1)', '(4.1,4.1,3.1,3.1)',
	'epoch', '01:00:10', '{1.0,2.0,3.0,4.0}', '{1.0,2.0,3.0,4.0}', '{1,2,3,4}');
SELECT * FROM attmp;
DROP TABLE attmp;
CREATE TABLE attmp (
	initial 	int4
);
ALTER TABLE attmp ADD COLUMN a int4;
ALTER TABLE attmp ADD COLUMN b name;
ALTER TABLE attmp ADD COLUMN c text;
ALTER TABLE attmp ADD COLUMN d float8;
ALTER TABLE attmp ADD COLUMN e float4;
ALTER TABLE attmp ADD COLUMN f int2;
ALTER TABLE attmp ADD COLUMN g polygon;
ALTER TABLE attmp ADD COLUMN i char;
ALTER TABLE attmp ADD COLUMN k int4;
ALTER TABLE attmp ADD COLUMN l tid;
ALTER TABLE attmp ADD COLUMN m xid;
ALTER TABLE attmp ADD COLUMN n oidvector;
ALTER TABLE attmp ADD COLUMN p boolean;
ALTER TABLE attmp ADD COLUMN q point;
ALTER TABLE attmp ADD COLUMN r lseg;
ALTER TABLE attmp ADD COLUMN s path;
ALTER TABLE attmp ADD COLUMN t box;
ALTER TABLE attmp ADD COLUMN v timestamp;
ALTER TABLE attmp ADD COLUMN w interval;
ALTER TABLE attmp ADD COLUMN x float8[];
ALTER TABLE attmp ADD COLUMN y float4[];
ALTER TABLE attmp ADD COLUMN z int2[];
INSERT INTO attmp (a, b, c, d, e, f, g,    i,   k, l, m, n, p, q, r, s, t,
	v, w, x, y, z)
   VALUES (4, 'name', 'text', 4.1, 4.1, 2, '(4.1,4.1,3.1,3.1)',
        'c',
	314159, '(1,1)', '512',
	'1 2 3 4 5 6 7 8', true, '(1.1,1.1)', '(4.1,4.1,3.1,3.1)',
	'(0,2,4.1,4.1,3.1,3.1)', '(4.1,4.1,3.1,3.1)',
	'epoch', '01:00:10', '{1.0,2.0,3.0,4.0}', '{1.0,2.0,3.0,4.0}', '{1,2,3,4}');
SELECT * FROM attmp;
CREATE INDEX attmp_idx ON attmp (a, (d + e), b);
ALTER INDEX attmp_idx ALTER COLUMN 2 SET STATISTICS 1000;
ALTER INDEX attmp_idx ALTER COLUMN 2 SET STATISTICS -1;
DROP TABLE attmp;
CREATE TABLE attmp (regtable int);
CREATE TEMP TABLE attmp (attmptable int);
ALTER TABLE attmp RENAME TO attmp_new;
SELECT * FROM attmp;
SELECT * FROM attmp_new;
ALTER TABLE attmp RENAME TO attmp_new2;
SELECT * FROM attmp_new;
SELECT * FROM attmp_new2;
DROP TABLE attmp_new;
DROP TABLE attmp_new2;
CREATE TABLE part_attmp (a int primary key) partition by range (a);
CREATE TABLE part_attmp1 PARTITION OF part_attmp FOR VALUES FROM (0) TO (100);
ALTER INDEX part_attmp_pkey RENAME TO part_attmp_index;
ALTER INDEX part_attmp1_pkey RENAME TO part_attmp1_index;
ALTER TABLE part_attmp RENAME TO part_at2tmp;
ALTER TABLE part_attmp1 RENAME TO part_at2tmp1;
ALTER INDEX part_attmp_index RENAME TO fail;
RESET ROLE;
DROP TABLE part_at2tmp;
CREATE TABLE attmp_array (id int);
CREATE TABLE attmp_array2 (id int);
SELECT typname FROM pg_type WHERE oid = 'attmp_array[]'::regtype;
SELECT typname FROM pg_type WHERE oid = 'attmp_array2[]'::regtype;
ALTER TABLE attmp_array2 RENAME TO _attmp_array;
SELECT typname FROM pg_type WHERE oid = 'attmp_array[]'::regtype;
SELECT typname FROM pg_type WHERE oid = '_attmp_array[]'::regtype;
DROP TABLE _attmp_array;
DROP TABLE attmp_array;
CREATE TABLE attmp_array (id int);
SELECT typname FROM pg_type WHERE oid = 'attmp_array[]'::regtype;
ALTER TABLE attmp_array RENAME TO _attmp_array;
SELECT typname FROM pg_type WHERE oid = '_attmp_array[]'::regtype;
DROP TABLE _attmp_array;
ALTER INDEX IF EXISTS __onek_unique1 RENAME TO attmp_onek_unique1;
ALTER INDEX IF EXISTS __attmp_onek_unique1 RENAME TO onek_unique1;
RESET ROLE;
CREATE TABLE alter_idx_rename_test (a INT);
CREATE INDEX alter_idx_rename_test_idx ON alter_idx_rename_test (a);
CREATE TABLE alter_idx_rename_test_parted (a INT) PARTITION BY LIST (a);
CREATE INDEX alter_idx_rename_test_parted_idx ON alter_idx_rename_test_parted (a);
BEGIN;
ALTER INDEX alter_idx_rename_test RENAME TO alter_idx_rename_test_2;
ALTER INDEX alter_idx_rename_test_parted RENAME TO alter_idx_rename_test_parted_2;
SELECT relation::regclass, mode FROM pg_locks
WHERE pid = pg_backend_pid() AND locktype = 'relation'
  AND relation::regclass::text LIKE 'alter\_idx%'
ORDER BY relation::regclass::text COLLATE "C";
COMMIT;
BEGIN;
ALTER INDEX alter_idx_rename_test_idx RENAME TO alter_idx_rename_test_idx_2;
ALTER INDEX alter_idx_rename_test_parted_idx RENAME TO alter_idx_rename_test_parted_idx_2;
SELECT relation::regclass, mode FROM pg_locks
WHERE pid = pg_backend_pid() AND locktype = 'relation'
  AND relation::regclass::text LIKE 'alter\_idx%'
ORDER BY relation::regclass::text COLLATE "C";
COMMIT;
BEGIN;
ALTER TABLE alter_idx_rename_test_idx_2 RENAME TO alter_idx_rename_test_idx_3;
ALTER TABLE alter_idx_rename_test_parted_idx_2 RENAME TO alter_idx_rename_test_parted_idx_3;
SELECT relation::regclass, mode FROM pg_locks
WHERE pid = pg_backend_pid() AND locktype = 'relation'
  AND relation::regclass::text LIKE 'alter\_idx%'
ORDER BY relation::regclass::text COLLATE "C";
COMMIT;
DROP TABLE alter_idx_rename_test_2;
RESET ROLE;
set enable_seqscan to off;
set enable_bitmapscan to off;
reset enable_seqscan;
reset enable_bitmapscan;
CREATE TABLE constraint_rename_test (a int CONSTRAINT con1 CHECK (a > 0), b int, c int);
CREATE TABLE constraint_rename_test2 (a int CONSTRAINT con1 CHECK (a > 0), d int) INHERITS (constraint_rename_test);
ALTER TABLE constraint_rename_test RENAME CONSTRAINT con1 TO con1foo;
ALTER TABLE constraint_rename_test ADD CONSTRAINT con2 CHECK (b > 0) NO INHERIT;
ALTER TABLE ONLY constraint_rename_test RENAME CONSTRAINT con2 TO con2foo;
ALTER TABLE constraint_rename_test RENAME CONSTRAINT con2foo TO con2bar;
ALTER TABLE constraint_rename_test ADD CONSTRAINT con3 PRIMARY KEY (a);
ALTER TABLE constraint_rename_test RENAME CONSTRAINT con3 TO con3foo;
DROP TABLE constraint_rename_test2;
DROP TABLE constraint_rename_test;
ALTER TABLE IF EXISTS constraint_not_exist RENAME CONSTRAINT con3 TO con3foo;
ALTER TABLE IF EXISTS constraint_rename_test ADD CONSTRAINT con4 UNIQUE (a);
CREATE TABLE constraint_rename_cache (a int,
  CONSTRAINT chk_a CHECK (a > 0),
  PRIMARY KEY (a));
ALTER TABLE constraint_rename_cache
  RENAME CONSTRAINT chk_a TO chk_a_new;
ALTER TABLE constraint_rename_cache
  RENAME CONSTRAINT constraint_rename_cache_pkey TO constraint_rename_pkey_new;
CREATE TABLE like_constraint_rename_cache
  (LIKE constraint_rename_cache INCLUDING ALL);
DROP TABLE constraint_rename_cache;
DROP TABLE like_constraint_rename_cache;
CREATE TABLE attmp2 (a int primary key);
CREATE TABLE attmp3 (a int, b int);
CREATE TABLE attmp4 (a int, b int, unique(a,b));
CREATE TABLE attmp5 (a int, b int);
INSERT INTO attmp2 values (1);
INSERT INTO attmp2 values (2);
INSERT INTO attmp2 values (3);
INSERT INTO attmp2 values (4);
INSERT INTO attmp3 values (1,10);
INSERT INTO attmp3 values (1,20);
INSERT INTO attmp3 values (5,50);
DELETE FROM attmp3 where a=5;
ALTER TABLE attmp3 add constraint attmpconstr foreign key (a) references attmp2 match full;
ALTER TABLE attmp3 drop constraint attmpconstr;
INSERT INTO attmp3 values (5,50);
ALTER TABLE attmp3 add constraint attmpconstr foreign key (a) references attmp2 match full NOT VALID;
DELETE FROM attmp3 where a=5;
ALTER TABLE attmp3 validate constraint attmpconstr;
ALTER TABLE attmp3 validate constraint attmpconstr;
ALTER TABLE attmp3 ADD CONSTRAINT b_greater_than_ten CHECK (b > 10) NOT VALID;
DELETE FROM attmp3 WHERE NOT b > 10;
ALTER TABLE attmp3 VALIDATE CONSTRAINT b_greater_than_ten;
ALTER TABLE attmp3 VALIDATE CONSTRAINT b_greater_than_ten;
select * from attmp3;
CREATE TABLE attmp6 () INHERITS (attmp3);
CREATE TABLE attmp7 () INHERITS (attmp3);
INSERT INTO attmp6 VALUES (6, 30), (7, 16);
ALTER TABLE attmp3 ADD CONSTRAINT b_le_20 CHECK (b <= 20) NOT VALID;
DELETE FROM attmp6 WHERE b > 20;
ALTER TABLE attmp3 VALIDATE CONSTRAINT b_le_20;
END;
INSERT INTO attmp7 VALUES (8, 18);
create table parent_noinh_convalid (a int);
create table child_noinh_convalid () inherits (parent_noinh_convalid);
insert into parent_noinh_convalid values (1);
insert into child_noinh_convalid values (1);
alter table parent_noinh_convalid add constraint check_a_is_2 check (a = 2) no inherit not valid;
delete from only parent_noinh_convalid;
alter table parent_noinh_convalid validate constraint check_a_is_2;
select convalidated from pg_constraint where conrelid = 'parent_noinh_convalid'::regclass and conname = 'check_a_is_2';
drop table parent_noinh_convalid, child_noinh_convalid;
DROP TABLE attmp7;
DROP TABLE attmp6;
DROP TABLE attmp5;
DROP TABLE attmp4;
DROP TABLE attmp3;
DROP TABLE attmp2;
set constraint_exclusion TO 'partition';
create table nv_parent (d date, check (false) no inherit not valid);
create table nv_child_2010 () inherits (nv_parent);
create table nv_child_2011 () inherits (nv_parent);
alter table nv_child_2010 add check (d between '2010-01-01'::date and '2010-12-31'::date) not valid;
alter table nv_child_2011 add check (d between '2011-01-01'::date and '2011-12-31'::date) not valid;
explain (costs off) select * from nv_parent where d between '2011-08-01' and '2011-08-31';
create table nv_child_2009 (check (d between '2009-01-01'::date and '2009-12-31'::date)) inherits (nv_parent);
explain (costs off) select * from nv_parent where d between '2011-08-01'::date and '2011-08-31'::date;
explain (costs off) select * from nv_parent where d between '2009-08-01'::date and '2009-08-31'::date;
alter table nv_child_2011 VALIDATE CONSTRAINT nv_child_2011_d_check;
explain (costs off) select * from nv_parent where d between '2009-08-01'::date and '2009-08-31'::date;
alter table nv_parent add check (d between '2001-01-01'::date and '2099-12-31'::date) not valid;
CREATE TEMP TABLE PKTABLE (ptest1 int PRIMARY KEY);
INSERT INTO PKTABLE VALUES(42);
CREATE TEMP TABLE FKTABLE (ftest1 inet);
DROP TABLE FKTABLE;
CREATE TEMP TABLE FKTABLE (ftest1 int8);
ALTER TABLE FKTABLE ADD FOREIGN KEY(ftest1) references pktable;
INSERT INTO FKTABLE VALUES(42);
DROP TABLE FKTABLE;
CREATE TEMP TABLE FKTABLE (ftest1 numeric);
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TEMP TABLE PKTABLE (ptest1 numeric PRIMARY KEY);
INSERT INTO PKTABLE VALUES(42);
CREATE TEMP TABLE FKTABLE (ftest1 int);
ALTER TABLE FKTABLE ADD FOREIGN KEY(ftest1) references pktable;
INSERT INTO FKTABLE VALUES(42);
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TEMP TABLE PKTABLE (ptest1 int, ptest2 inet,
                           PRIMARY KEY(ptest1, ptest2));
CREATE TEMP TABLE FKTABLE (ftest1 cidr, ftest2 timestamp);
DROP TABLE FKTABLE;
CREATE TEMP TABLE FKTABLE (ftest1 cidr, ftest2 timestamp);
DROP TABLE FKTABLE;
CREATE TEMP TABLE FKTABLE (ftest1 int, ftest2 inet);
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TEMP TABLE PKTABLE (ptest1 int primary key);
CREATE TEMP TABLE FKTABLE (ftest1 int);
ALTER TABLE FKTABLE ADD CONSTRAINT fknd FOREIGN KEY(ftest1) REFERENCES pktable
  ON DELETE CASCADE ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE FKTABLE ADD CONSTRAINT fkdd FOREIGN KEY(ftest1) REFERENCES pktable
  ON DELETE CASCADE ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE FKTABLE ADD CONSTRAINT fkdi FOREIGN KEY(ftest1) REFERENCES pktable
  ON DELETE CASCADE ON UPDATE NO ACTION DEFERRABLE INITIALLY IMMEDIATE;
ALTER TABLE FKTABLE ADD CONSTRAINT fknd2 FOREIGN KEY(ftest1) REFERENCES pktable
  ON DELETE CASCADE ON UPDATE NO ACTION DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE FKTABLE ALTER CONSTRAINT fknd2 NOT DEFERRABLE;
ALTER TABLE FKTABLE ADD CONSTRAINT fkdd2 FOREIGN KEY(ftest1) REFERENCES pktable
  ON DELETE CASCADE ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE FKTABLE ALTER CONSTRAINT fkdd2 DEFERRABLE INITIALLY DEFERRED;
ALTER TABLE FKTABLE ADD CONSTRAINT fkdi2 FOREIGN KEY(ftest1) REFERENCES pktable
  ON DELETE CASCADE ON UPDATE NO ACTION NOT DEFERRABLE;
ALTER TABLE FKTABLE ALTER CONSTRAINT fkdi2 DEFERRABLE INITIALLY IMMEDIATE;
SELECT conname, tgfoid::regproc, tgtype, tgdeferrable, tginitdeferred
FROM pg_trigger JOIN pg_constraint con ON con.oid = tgconstraint
WHERE tgrelid = 'pktable'::regclass
ORDER BY 1,2,3;
SELECT conname, tgfoid::regproc, tgtype, tgdeferrable, tginitdeferred
FROM pg_trigger JOIN pg_constraint con ON con.oid = tgconstraint
WHERE tgrelid = 'fktable'::regclass
ORDER BY 1,2,3;
create table atacc1 ( test int );
alter table atacc1 add constraint atacc_test1 check (test>3);
insert into atacc1 (test) values (4);
drop table atacc1;
create table atacc1 ( test int );
insert into atacc1 (test) values (2);
insert into atacc1 (test) values (4);
drop table atacc1;
create table atacc1 ( test int );
drop table atacc1;
create table atacc1 ( test int, test2 int, test3 int);
alter table atacc1 add constraint atacc_test1 check (test+test2<test3*4);
insert into atacc1 (test,test2,test3) values (4,4,5);
drop table atacc1;
create table atacc1 (test int check (test>3), test2 int);
alter table atacc1 add check (test2>test);
drop table atacc1;
create table atacc1 (test int);
create table atacc2 (test2 int);
create table atacc3 (test3 int) inherits (atacc1, atacc2);
alter table atacc2 add constraint foo check (test2>0);
insert into atacc2 (test2) values (3);
insert into atacc3 (test2) values (3);
drop table atacc3;
drop table atacc2;
drop table atacc1;
create table atacc1 (test int);
create table atacc2 (test2 int);
create table atacc3 (test3 int) inherits (atacc1, atacc2);
alter table atacc3 no inherit atacc2;
insert into atacc3 (test2) values (3);
select test2 from atacc2;
alter table atacc2 add constraint foo check (test2>0);
alter table atacc3 rename test2 to testx;
alter table atacc3 add test2 bool;
alter table atacc3 drop test2;
alter table atacc3 add test2 int;
update atacc3 set test2 = 4 where test2 is null;
alter table atacc3 add constraint foo check (test2>0);
alter table atacc3 inherit atacc2;
select test2 from atacc2;
drop table atacc2 cascade;
drop table atacc1;
create table atacc1 (test int);
create table atacc2 (test2 int) inherits (atacc1);
alter table atacc1 add constraint foo check (test>0) no inherit;
insert into atacc2 (test) values (-3);
insert into atacc1 (test) values (3);
drop table atacc2;
drop table atacc1;
create table atacc1 ( test int );
alter table atacc1 add constraint atacc_test1 unique (test);
insert into atacc1 (test) values (2);
insert into atacc1 (test) values (4);
drop table atacc1;
create table atacc1 ( test int );
insert into atacc1 (test) values (2);
insert into atacc1 (test) values (2);
insert into atacc1 (test) values (3);
drop table atacc1;
create table atacc1 ( test int );
drop table atacc1;
create table atacc1 ( test int, test2 int);
alter table atacc1 add constraint atacc_test1 unique (test, test2);
insert into atacc1 (test,test2) values (4,4);
insert into atacc1 (test,test2) values (4,5);
insert into atacc1 (test,test2) values (5,4);
insert into atacc1 (test,test2) values (5,5);
drop table atacc1;
create table atacc1 (test int, test2 int, unique(test));
alter table atacc1 add unique (test2);
insert into atacc1 (test2, test) values (3, 3);
drop table atacc1;
create table atacc1 ( id serial, test int);
alter table atacc1 add constraint atacc_test1 primary key (test);
insert into atacc1 (test) values (2);
insert into atacc1 (test) values (4);
alter table atacc1 drop constraint atacc_test1 restrict;
alter table atacc1 add constraint atacc_oid1 primary key(id);
drop table atacc1;
create table atacc1 ( test int );
insert into atacc1 (test) values (2);
insert into atacc1 (test) values (2);
insert into atacc1 (test) values (3);
drop table atacc1;
create table atacc1 ( test int );
insert into atacc1 (test) values (NULL);
insert into atacc1 (test) values (3);
drop table atacc1;
create table atacc1 ( test int );
drop table atacc1;
create table atacc1 ( test int );
insert into atacc1 (test) values (0);
alter table atacc1 add column test2 int default 0 primary key;
drop table atacc1;
create table atacc1 (a int);
insert into atacc1 values(1);
alter table atacc1
  add column b float8 not null default random(),
  add primary key(a);
drop table atacc1;
create table atacc1 (a int primary key);
alter table atacc1 add constraint atacc1_fkey foreign key (a) references atacc1 (a) not valid;
alter table atacc1 validate constraint atacc1_fkey, alter a type bigint;
drop table atacc1;
create table atacc1 (a bigint, b int);
insert into atacc1 values(1,1);
alter table atacc1 add constraint atacc1_chk check(b = 1) not valid;
alter table atacc1 validate constraint atacc1_chk, alter a type int;
drop table atacc1;
create table atacc1 (a bigint, b int);
insert into atacc1 values(1,2);
alter table atacc1 add constraint atacc1_chk check(b = 1) not valid;
drop table atacc1;
create table atacc1 ( test int, test2 int);
alter table atacc1 add constraint atacc_test1 primary key (test, test2);
insert into atacc1 (test,test2) values (4,4);
insert into atacc1 (test,test2) values (4,5);
insert into atacc1 (test,test2) values (5,4);
insert into atacc1 (test,test2) values (5,5);
drop table atacc1;
create table atacc1 (test int, test2 int, primary key(test));
insert into atacc1 (test2, test) values (3, 3);
drop table atacc1;
create table atacc1 (test int not null);
alter table atacc1 add constraint "atacc1_pkey" primary key (test);
alter table atacc1 drop constraint "atacc1_pkey";
alter table atacc1 alter test set not null;
delete from atacc1;
alter table atacc1 alter test set not null;
create view myview as select * from atacc1;
drop view myview;
drop table atacc1;
create table atacc1 (test_a int, test_b int);
insert into atacc1 values (null, 1);
alter table atacc1 add constraint atacc1_constr_or check(test_a is not null or test_b < 10);
alter table atacc1 drop constraint atacc1_constr_or;
alter table atacc1 add constraint atacc1_constr_invalid check(test_a is not null) not valid;
alter table atacc1 drop constraint atacc1_constr_invalid;
update atacc1 set test_a = 1;
alter table atacc1 add constraint atacc1_constr_a_valid check(test_a is not null);
alter table atacc1 alter test_a set not null;
delete from atacc1;
insert into atacc1 values (2, null);
alter table atacc1 alter test_a drop not null;
update atacc1 set test_b = 1;
alter table atacc1 alter test_b set not null, alter test_a set not null;
alter table atacc1 alter test_a drop not null, alter test_b drop not null;
alter table atacc1 add constraint atacc1_constr_b_valid check(test_b is not null);
alter table atacc1 alter test_b set not null, alter test_a set not null;
drop table atacc1;
create table parent (a int);
create table child (b varchar(255)) inherits (parent);
alter table parent alter a set not null;
alter table parent alter a drop not null;
insert into parent values (NULL);
insert into child (a, b) values (NULL, 'foo');
drop table child;
drop table parent;
create table def_test (
	c1	int4 default 5,
	c2	text default 'initial_default'
);
insert into def_test default values;
alter table def_test alter column c1 drop default;
insert into def_test default values;
alter table def_test alter column c2 drop default;
insert into def_test default values;
alter table def_test alter column c1 set default 10;
alter table def_test alter column c2 set default 'new_default';
insert into def_test default values;
select * from def_test;
alter table def_test alter column c2 set default 20;
create view def_view_test as select * from def_test;
create rule def_view_test_ins as
	on insert to def_view_test
	do instead insert into def_test select new.*;
insert into def_view_test default values;
alter table def_view_test alter column c1 set default 45;
insert into def_view_test default values;
alter table def_view_test alter column c2 set default 'view_default';
insert into def_view_test default values;
select * from def_view_test;
drop rule def_view_test_ins on def_view_test;
drop view def_view_test;
drop table def_test;
create table atacc1 (a int4 not null, b int4, c int4 not null, d int4);
insert into atacc1 values (1, 2, 3, 4);
alter table atacc1 drop a;
select * from atacc1;
select atacc1.* from atacc1;
select b,c,d from atacc1;
insert into atacc1 values (11, 12, 13);
insert into atacc1 (b,c,d) values (11,12,13);
delete from atacc1;
alter table atacc1 SET WITHOUT OIDS;
create view myview as select * from atacc1;
select * from myview;
drop view myview;
create table atacc2 (id int4 unique);
drop table atacc2;
insert into atacc1 values (21, 22, 23);
create table attest1 as select * from atacc1;
select * from attest1;
drop table attest1;
select * into attest2 from atacc1;
select * from attest2;
drop table attest2;
alter table atacc1 drop c;
alter table atacc1 drop d;
alter table atacc1 drop b;
select * from atacc1;
drop table atacc1;
create table atacc1 (id serial primary key, value int check (value < 10));
alter table atacc1 drop column value;
alter table atacc1 add column value int check (value < 10);
drop table atacc1;
create table parent (a int, b int, c int);
insert into parent values (1, 2, 3);
alter table parent drop a;
create table child (d varchar(255)) inherits (parent);
insert into child values (12, 13, 'testing');
select * from parent;
select * from child;
alter table parent drop c;
select * from parent;
select * from child;
drop table child;
drop table parent;
create table parent (a float8, b numeric(10,4), c text collate "C");
create table child (a double precision, b decimal(10,4)) inherits (parent);
drop table child;
drop table parent;
create table attest (a int4, b int4, c int4);
insert into attest values (1,2,3);
alter table attest drop a;
drop table attest;
create table dropColumn (a int, b int, e int);
create table dropColumnChild (c int) inherits (dropColumn);
create table dropColumnAnother (d int) inherits (dropColumnChild);
alter table only dropColumn drop column e;
alter table dropColumnChild drop column c;
alter table dropColumn drop column a;
create table renameColumn (a int);
create table renameColumnChild (b int) inherits (renameColumn);
create table renameColumnAnother (c int) inherits (renameColumnChild);
alter table renameColumn rename column a to d;
alter table renameColumnChild rename column b to a;
alter table if exists doesnt_exist_tab rename column a to d;
alter table if exists doesnt_exist_tab rename column b to a;
alter table renameColumn add column w int;
create table p1 (f1 int, f2 int);
create table c1 (f1 int not null) inherits(p1);
alter table p1 drop column f1;
select f1 from c1;
alter table c1 drop column f1;
drop table p1 cascade;
create table p1 (f1 int, f2 int);
create table c1 () inherits(p1);
alter table p1 drop column f1;
drop table p1 cascade;
create table p1 (f1 int, f2 int);
create table c1 () inherits(p1);
alter table only p1 drop column f1;
alter table c1 drop column f1;
drop table p1 cascade;
create table p1 (f1 int, f2 int);
create table c1 (f1 int not null) inherits(p1);
alter table only p1 drop column f1;
alter table c1 drop column f1;
drop table p1 cascade;
create table p1(id int, name text);
create table p2(id2 int, name text, height int);
create table c1(age int) inherits(p1,p2);
create table gc1() inherits (c1);
select relname, attname, attinhcount, attislocal
from pg_class join pg_attribute on (pg_class.oid = pg_attribute.attrelid)
where relname in ('p1','p2','c1','gc1') and attnum > 0 and not attisdropped
order by relname, attnum;
alter table only p1 drop column name;
alter table p2 drop column name;
alter table c1 drop column name;
alter table p2 drop column height;
create table dropColumnExists ();
alter table dropColumnExists drop column if exists non_existing;
select relname, attname, attinhcount, attislocal
from pg_class join pg_attribute on (pg_class.oid = pg_attribute.attrelid)
where relname in ('p1','p2','c1','gc1') and attnum > 0 and not attisdropped
order by relname, attnum;
drop table p1, p2 cascade;
create table depth0();
create table depth1(c text) inherits (depth0);
create table depth2() inherits (depth1);
alter table depth0 add c text;
select attrelid::regclass, attname, attinhcount, attislocal
from pg_attribute
where attnum > 0 and attrelid::regclass in ('depth0', 'depth1', 'depth2')
order by attrelid::regclass::text, attnum;
create table p1 (f1 int);
create table c1 (f2 text, f3 int) inherits (p1);
alter table p1 add column a1 int check (a1 > 0);
alter table p1 add column f2 text;
insert into p1 values (1,2,'abc');
insert into c1 values(11,'xyz',33,22);
select * from p1;
update p1 set a1 = a1 + 1, f2 = upper(f2);
select * from p1;
drop table p1 cascade;
create domain mytype as text;
create temp table foo (f1 text, f2 mytype, f3 text);
insert into foo values('bb','cc','dd');
select * from foo;
drop domain mytype cascade;
select * from foo;
insert into foo values('qq','rr');
select * from foo;
update foo set f3 = 'zz';
select * from foo;
select f3,max(f1) from foo group by f3;
alter table foo alter f1 TYPE varchar(10);
create table anothertab (atcol1 serial8, atcol2 boolean,
	constraint anothertab_chk check (atcol1 <= 3));
insert into anothertab (atcol1, atcol2) values (default, true);
insert into anothertab (atcol1, atcol2) values (default, false);
select * from anothertab;
alter table anothertab alter column atcol1 type integer;
select * from anothertab;
insert into anothertab (atcol1, atcol2) values (default, null);
select * from anothertab;
alter table anothertab alter column atcol2 type text
      using case when atcol2 is true then 'IT WAS TRUE'
                 when atcol2 is false then 'IT WAS FALSE'
                 else 'IT WAS NULL!' end;
select * from anothertab;
alter table anothertab alter column atcol1 drop default;
alter table anothertab drop constraint anothertab_chk;
alter table anothertab drop constraint IF EXISTS anothertab_chk;
alter table anothertab alter column atcol1 type boolean
        using case when atcol1 % 2 = 0 then true else false end;
select * from anothertab;
drop table anothertab;
create table anothertab(f1 int primary key, f2 int unique,
                        f3 int, f4 int, f5 int);
alter table anothertab
  add exclude using btree (f3 with =);
alter table anothertab
  add exclude using btree (f4 with =) where (f4 is not null);
alter table anothertab
  add exclude using btree (f4 with =) where (f5 > 0);
alter table anothertab
  add unique(f1,f4);
create index on anothertab(f2,f3);
create unique index on anothertab(f4);
alter table anothertab alter column f1 type bigint;
alter table anothertab
  alter column f2 type bigint,
  alter column f3 type bigint,
  alter column f4 type bigint;
alter table anothertab alter column f5 type bigint;
drop table anothertab;
create table another (f1 int, f2 text, f3 text);
insert into another values(1, 'one', 'uno');
insert into another values(2, 'two', 'due');
insert into another values(3, 'three', 'tre');
select * from another;
alter table another
  alter f1 type text using f2 || ' and ' || f3 || ' more',
  alter f2 type bigint using f1 * 10,
  drop column f3;
select * from another;
drop table another;
begin;
create table skip_wal_skip_rewrite_index (c varchar(10) primary key);
alter table skip_wal_skip_rewrite_index alter c type varchar(20);
commit;
create table at_tab1 (a int, b text);
create table at_tab2 (x int, y at_tab1);
drop table at_tab2;
create table at_tab2 (x int, y text, check((x,y)::at_tab1 = (1,'42')::at_tab1));
alter table at_tab1 alter column b type varchar;
drop table at_tab1, at_tab2;
create table at_tab1 (a int, b text) partition by list(a);
create table at_tab2 (x int, y at_tab1);
drop table at_tab1, at_tab2;
create table at_partitioned (a int, b text) partition by range (a);
create table at_part_1 partition of at_partitioned for values from (0) to (1000);
insert into at_partitioned values (512, '0.123');
create table at_part_2 (b text, a int);
insert into at_part_2 values ('1.234', 1024);
create index on at_partitioned (b);
create index on at_partitioned (a);
alter table at_partitioned attach partition at_part_2 for values from (1000) to (2000);
alter table at_partitioned alter column b type numeric using b::numeric;
drop table at_partitioned;
create table at_partitioned(id int, name varchar(64), unique (id, name))
  partition by hash(id);
comment on constraint at_partitioned_id_name_key on at_partitioned is 'parent constraint';
comment on index at_partitioned_id_name_key is 'parent index';
create table at_partitioned_0 partition of at_partitioned
  for values with (modulus 2, remainder 0);
comment on constraint at_partitioned_0_id_name_key on at_partitioned_0 is 'child 0 constraint';
comment on index at_partitioned_0_id_name_key is 'child 0 index';
create table at_partitioned_1 partition of at_partitioned
  for values with (modulus 2, remainder 1);
comment on constraint at_partitioned_1_id_name_key on at_partitioned_1 is 'child 1 constraint';
comment on index at_partitioned_1_id_name_key is 'child 1 index';
insert into at_partitioned values(1, 'foo');
insert into at_partitioned values(3, 'bar');
create temp table old_oids as
  select relname, oid as oldoid, relfilenode as oldfilenode
  from pg_class where relname like 'at_partitioned%';
select relname,
  c.oid = oldoid as orig_oid,
  case relfilenode
    when 0 then 'none'
    when c.oid then 'own'
    when oldfilenode then 'orig'
    else 'OTHER'
    end as storage,
  obj_description(c.oid, 'pg_class') as desc
  from pg_class c left join old_oids using (relname)
  where relname like 'at_partitioned%'
  order by relname;
select conname, obj_description(oid, 'pg_constraint') as desc
  from pg_constraint where conname like 'at_partitioned%'
  order by conname;
alter table at_partitioned alter column name type varchar(127);
select relname,
  c.oid = oldoid as orig_oid,
  case relfilenode
    when 0 then 'none'
    when c.oid then 'own'
    when oldfilenode then 'orig'
    else 'OTHER'
    end as storage,
  obj_description(c.oid, 'pg_class') as desc
  from pg_class c left join old_oids using (relname)
  where relname like 'at_partitioned%'
  order by relname;
select conname, obj_description(oid, 'pg_constraint') as desc
  from pg_constraint where conname like 'at_partitioned%'
  order by conname;
drop table at_partitioned;
create temp table recur1 (f1 int);
create domain array_of_recur1 as recur1[];
create temp table recur2 (f1 int, f2 recur1);
alter table recur1 add column f2 int;
create table test_storage (a text, c text storage plain);
select reltoastrelid <> 0 as has_toast_table
  from pg_class where oid = 'test_storage'::regclass;
alter table test_storage alter a set storage plain;
alter table test_storage add b int default random()::int;
select reltoastrelid <> 0 as has_toast_table
  from pg_class where oid = 'test_storage'::regclass;
alter table test_storage alter a set storage default;
select reltoastrelid <> 0 as has_toast_table
  from pg_class where oid = 'test_storage'::regclass;
create index test_storage_idx on test_storage (b, a);
alter table test_storage alter column a set storage external;
CREATE TABLE test_inh_check (a float check (a > 10.2), b float);
CREATE TABLE test_inh_check_child() INHERITS(test_inh_check);
select relname, conname, coninhcount, conislocal, connoinherit
  from pg_constraint c, pg_class r
  where relname like 'test_inh_check%' and c.conrelid = r.oid
  order by 1, 2;
ALTER TABLE test_inh_check ALTER COLUMN a TYPE numeric;
select relname, conname, coninhcount, conislocal, connoinherit
  from pg_constraint c, pg_class r
  where relname like 'test_inh_check%' and c.conrelid = r.oid
  order by 1, 2;
ALTER TABLE test_inh_check ADD CONSTRAINT bnoinherit CHECK (b > 100) NO INHERIT;
ALTER TABLE test_inh_check_child ADD CONSTRAINT blocal CHECK (b < 1000);
ALTER TABLE test_inh_check_child ADD CONSTRAINT bmerged CHECK (b > 1);
ALTER TABLE test_inh_check ADD CONSTRAINT bmerged CHECK (b > 1);
select relname, conname, coninhcount, conislocal, connoinherit
  from pg_constraint c, pg_class r
  where relname like 'test_inh_check%' and c.conrelid = r.oid
  order by 1, 2;
ALTER TABLE test_inh_check ALTER COLUMN b TYPE numeric;
select relname, conname, coninhcount, conislocal, connoinherit
  from pg_constraint c, pg_class r
  where relname like 'test_inh_check%' and c.conrelid = r.oid
  order by 1, 2;
CREATE TABLE test_type_diff (f1 int);
CREATE TABLE test_type_diff_c (extra smallint) INHERITS (test_type_diff);
ALTER TABLE test_type_diff ADD COLUMN f2 int;
INSERT INTO test_type_diff_c VALUES (1, 2, 3);
ALTER TABLE test_type_diff ALTER COLUMN f2 TYPE bigint USING f2::bigint;
CREATE TABLE test_type_diff2 (int_two int2, int_four int4, int_eight int8);
CREATE TABLE test_type_diff2_c1 (int_four int4, int_eight int8, int_two int2);
CREATE TABLE test_type_diff2_c2 (int_eight int8, int_two int2, int_four int4);
CREATE TABLE test_type_diff2_c3 (int_two int2, int_four int4, int_eight int8);
ALTER TABLE test_type_diff2_c1 INHERIT test_type_diff2;
ALTER TABLE test_type_diff2_c2 INHERIT test_type_diff2;
ALTER TABLE test_type_diff2_c3 INHERIT test_type_diff2;
INSERT INTO test_type_diff2_c1 VALUES (1, 2, 3);
INSERT INTO test_type_diff2_c2 VALUES (4, 5, 6);
INSERT INTO test_type_diff2_c3 VALUES (7, 8, 9);
ALTER TABLE test_type_diff2 ALTER COLUMN int_four TYPE int8 USING int_four::int8;
CREATE TABLE check_fk_presence_1 (id int PRIMARY KEY, t text);
CREATE TABLE check_fk_presence_2 (id int REFERENCES check_fk_presence_1, t text);
BEGIN;
ALTER TABLE check_fk_presence_2 DROP CONSTRAINT check_fk_presence_2_id_fkey;
ANALYZE check_fk_presence_2;
ROLLBACK;
DROP TABLE check_fk_presence_1, check_fk_presence_2;
create table at_base_table(id int, stuff text);
insert into at_base_table values (23, 'skidoo');
create view at_view_1 as select * from at_base_table bt;
create view at_view_2 as select *, to_json(v1) as j from at_view_1 v1;
explain (verbose, costs off) select * from at_view_2;
select * from at_view_2;
create or replace view at_view_1 as select *, 2+2 as more from at_base_table bt;
explain (verbose, costs off) select * from at_view_2;
select * from at_view_2;
drop view at_view_2;
drop view at_view_1;
drop table at_base_table;
begin;
rollback;
END;
CREATE TABLE rewrite_test(col text);
INSERT INTO rewrite_test VALUES ('something');
INSERT INTO rewrite_test VALUES (NULL);
DROP TABLE rewrite_test;
create type lockmodes as enum (
 'SIReadLock'
,'AccessShareLock'
,'RowShareLock'
,'RowExclusiveLock'
,'ShareUpdateExclusiveLock'
,'ShareLock'
,'ShareRowExclusiveLock'
,'ExclusiveLock'
,'AccessExclusiveLock'
);
create or replace view my_locks as
select case when c.relname like 'pg_toast%' then 'pg_toast' else c.relname end, max(mode::lockmodes) as max_lockmode
from pg_locks l join pg_class c on l.relation = c.oid
where virtualtransaction = (
        select virtualtransaction
        from pg_locks
        where transactionid = pg_current_xact_id()::xid)
and locktype = 'relation'
and relnamespace != (select oid from pg_namespace where nspname = 'pg_catalog')
and c.relname != 'my_locks'
group by c.relname;
create table alterlock (f1 int primary key, f2 text);
insert into alterlock values (1, 'foo');
create table alterlock2 (f3 int primary key, f1 int);
insert into alterlock2 values (1, 1);
begin;
alter table alterlock alter column f2 set statistics 150;
select * from my_locks order by 1;
rollback;
begin;
alter table alterlock cluster on alterlock_pkey;
select * from my_locks order by 1;
commit;
begin;
alter table alterlock set without cluster;
select * from my_locks order by 1;
commit;
begin;
alter table alterlock set (fillfactor = 100);
select * from my_locks order by 1;
commit;
begin;
alter table alterlock reset (fillfactor);
select * from my_locks order by 1;
commit;
begin;
alter table alterlock set (toast.autovacuum_enabled = off);
select * from my_locks order by 1;
commit;
begin;
alter table alterlock set (autovacuum_enabled = off);
select * from my_locks order by 1;
commit;
begin;
alter table alterlock alter column f2 set (n_distinct = 1);
select * from my_locks order by 1;
rollback;
begin;
alter table alterlock set (autovacuum_enabled = off, fillfactor = 80);
select * from my_locks order by 1;
commit;
begin;
alter table alterlock alter column f2 set storage extended;
select * from my_locks order by 1;
rollback;
begin;
alter table alterlock alter column f2 set default 'x';
select * from my_locks order by 1;
rollback;
begin;
rollback;
begin;
select * from my_locks order by 1;
alter table alterlock2 add foreign key (f1) references alterlock (f1);
select * from my_locks order by 1;
rollback;
begin;
alter table alterlock2
add constraint alterlock2nv foreign key (f1) references alterlock (f1) NOT VALID;
select * from my_locks order by 1;
commit;
begin;
alter table alterlock2 validate constraint alterlock2nv;
select * from my_locks order by 1;
rollback;
create or replace view my_locks as
select case when c.relname like 'pg_toast%' then 'pg_toast' else c.relname end, max(mode::lockmodes) as max_lockmode
from pg_locks l join pg_class c on l.relation = c.oid
where virtualtransaction = (
        select virtualtransaction
        from pg_locks
        where transactionid = pg_current_xact_id()::xid)
and locktype = 'relation'
and relnamespace != (select oid from pg_namespace where nspname = 'pg_catalog')
and c.relname = 'my_locks'
group by c.relname;
alter table my_locks reset (autovacuum_enabled);
alter view my_locks reset (autovacuum_enabled);
begin;
alter view my_locks set (security_barrier=off);
select * from my_locks order by 1;
alter view my_locks reset (security_barrier);
rollback;
begin;
alter table my_locks set (security_barrier=off);
select * from my_locks order by 1;
alter table my_locks reset (security_barrier);
rollback;
drop table alterlock2;
drop table alterlock;
drop view my_locks;
drop type lockmodes;
create schema alter1;
create schema alter2;
create table alter1.t1(f1 serial primary key, f2 int check (f2 > 0));
create view alter1.v1 as select * from alter1.t1;
create function alter1.plus1(int) returns int as 'select $1+1' language sql;
create domain alter1.posint integer check (value > 0);
create type alter1.ctype as (f1 int, f2 text);
create function alter1.same(alter1.ctype, alter1.ctype) returns boolean language sql
as 'select $1.f1 is not distinct from $2.f1 and $1.f2 is not distinct from $2.f2';
create operator alter1.=(procedure = alter1.same, leftarg  = alter1.ctype, rightarg = alter1.ctype);
create conversion alter1.latin1_to_utf8 for 'latin1' to 'utf8' from iso8859_1_to_utf8;
insert into alter1.t1(f2) values(11);
insert into alter1.t1(f2) values(12);
alter table alter1.t1 set schema alter1;
alter table alter1.t1 set schema alter2;
alter table alter1.v1 set schema alter2;
alter function alter1.plus1(int) set schema alter2;
alter domain alter1.posint set schema alter2;
alter operator alter1.=(alter1.ctype, alter1.ctype) set schema alter2;
alter function alter1.same(alter1.ctype, alter1.ctype) set schema alter2;
alter type alter1.ctype set schema alter1;
alter type alter1.ctype set schema alter2;
alter conversion alter1.latin1_to_utf8 set schema alter2;
drop schema alter1;
insert into alter2.t1(f2) values(13);
insert into alter2.t1(f2) values(14);
select * from alter2.t1;
select * from alter2.v1;
select alter2.plus1(41);
drop schema alter2 cascade;
CREATE TYPE test_type AS (a int);
ALTER TYPE test_type ADD ATTRIBUTE b text;
ALTER TYPE test_type ALTER ATTRIBUTE b SET DATA TYPE varchar;
ALTER TYPE test_type ALTER ATTRIBUTE b SET DATA TYPE integer;
ALTER TYPE test_type DROP ATTRIBUTE b;
ALTER TYPE test_type DROP ATTRIBUTE IF EXISTS c;
ALTER TYPE test_type DROP ATTRIBUTE a, ADD ATTRIBUTE d boolean;
ALTER TYPE test_type RENAME ATTRIBUTE d TO dd;
DROP TYPE test_type;
CREATE TYPE test_type1 AS (a int, b text);
CREATE TABLE test_tbl1 (x int, y test_type1);
DROP TABLE test_tbl1;
CREATE TABLE test_tbl1 (x int, y text);
CREATE INDEX test_tbl1_idx ON test_tbl1((row(x,y)::test_type1));
DROP TABLE test_tbl1;
DROP TYPE test_type1;
CREATE TYPE test_type2 AS (a int, b text);
CREATE TABLE test_tbl2 OF test_type2;
CREATE TABLE test_tbl2_subclass () INHERITS (test_tbl2);
ALTER TYPE test_type2 ADD ATTRIBUTE c text CASCADE;
ALTER TYPE test_type2 ALTER ATTRIBUTE b TYPE varchar CASCADE;
ALTER TYPE test_type2 DROP ATTRIBUTE b CASCADE;
ALTER TYPE test_type2 RENAME ATTRIBUTE a TO aa CASCADE;
DROP TABLE test_tbl2_subclass, test_tbl2;
DROP TYPE test_type2;
CREATE TYPE test_typex AS (a int, b text);
CREATE TABLE test_tblx (x int, y test_typex check ((y).a > 0));
ALTER TYPE test_typex DROP ATTRIBUTE a CASCADE;
DROP TABLE test_tblx;
DROP TYPE test_typex;
CREATE TYPE test_type3 AS (a int);
CREATE TABLE test_tbl3 (c) AS SELECT '(1)'::test_type3;
ALTER TYPE test_type3 DROP ATTRIBUTE a, ADD ATTRIBUTE b int;
CREATE TYPE test_type_empty AS ();
DROP TYPE test_type_empty;
CREATE TYPE tt_t0 AS (z inet, x int, y numeric(8,2));
ALTER TYPE tt_t0 DROP ATTRIBUTE z;
CREATE TABLE tt0 (x int NOT NULL, y numeric(8,2));
CREATE TABLE tt1 (x int, y bigint);
CREATE TABLE tt2 (x int, y numeric(9,2));
CREATE TABLE tt3 (y numeric(8,2), x int);
CREATE TABLE tt4 (x int);
CREATE TABLE tt5 (x int, y numeric(8,2), z int);
CREATE TABLE tt6 () INHERITS (tt0);
CREATE TABLE tt7 (x int, q text, y numeric(8,2));
ALTER TABLE tt7 DROP q;
ALTER TABLE tt0 OF tt_t0;
ALTER TABLE tt7 OF tt_t0;
CREATE TYPE tt_t1 AS (x int, y numeric(8,2));
ALTER TABLE tt7 OF tt_t1;
ALTER TABLE tt7 NOT OF;
CREATE TABLE test_drop_constr_parent (c text CHECK (c IS NOT NULL));
CREATE TABLE test_drop_constr_child () INHERITS (test_drop_constr_parent);
ALTER TABLE ONLY test_drop_constr_parent DROP CONSTRAINT "test_drop_constr_parent_c_check";
DROP TABLE test_drop_constr_parent CASCADE;
ALTER TABLE IF EXISTS tt8 ADD COLUMN f int;
ALTER TABLE IF EXISTS tt8 ADD CONSTRAINT xxx PRIMARY KEY(f);
ALTER TABLE IF EXISTS tt8 ADD CHECK (f BETWEEN 0 AND 10);
ALTER TABLE IF EXISTS tt8 ALTER COLUMN f SET DEFAULT 0;
ALTER TABLE IF EXISTS tt8 RENAME COLUMN f TO f1;
ALTER TABLE IF EXISTS tt8 SET SCHEMA alter2;
CREATE TABLE tt8(a int);
CREATE SCHEMA alter2;
ALTER TABLE IF EXISTS tt8 ADD COLUMN f int;
ALTER TABLE IF EXISTS tt8 ADD CONSTRAINT xxx PRIMARY KEY(f);
ALTER TABLE IF EXISTS tt8 ADD CHECK (f BETWEEN 0 AND 10);
ALTER TABLE IF EXISTS tt8 ALTER COLUMN f SET DEFAULT 0;
ALTER TABLE IF EXISTS tt8 RENAME COLUMN f TO f1;
ALTER TABLE IF EXISTS tt8 SET SCHEMA alter2;
DROP TABLE alter2.tt8;
DROP SCHEMA alter2;
CREATE TABLE tt9(c integer);
ALTER TABLE tt9 ADD CHECK(c > 1);
ALTER TABLE tt9 ADD CHECK(c > 2);
ALTER TABLE tt9 ADD CONSTRAINT foo CHECK(c > 3);
ALTER TABLE tt9 ADD UNIQUE(c);
ALTER TABLE tt9 ADD UNIQUE(c);
ALTER TABLE tt9 ADD CONSTRAINT tt9_c_key2 CHECK(c > 6);
ALTER TABLE tt9 ADD UNIQUE(c);
DROP TABLE tt9;
CREATE TABLE comment_test (
  id int,
  positive_col int CHECK (positive_col > 0),
  indexed_col int,
  CONSTRAINT comment_test_pk PRIMARY KEY (id));
CREATE INDEX comment_test_index ON comment_test(indexed_col);
COMMENT ON COLUMN comment_test.id IS 'Column ''id'' on comment_test';
COMMENT ON INDEX comment_test_index IS 'Simple index on comment_test';
COMMENT ON CONSTRAINT comment_test_positive_col_check ON comment_test IS 'CHECK constraint on comment_test.positive_col';
COMMENT ON CONSTRAINT comment_test_pk ON comment_test IS 'PRIMARY KEY constraint of comment_test';
COMMENT ON INDEX comment_test_pk IS 'Index backing the PRIMARY KEY of comment_test';
SELECT col_description('comment_test'::regclass, 1) as comment;
SELECT indexrelid::regclass::text as index, obj_description(indexrelid, 'pg_class') as comment FROM pg_index where indrelid = 'comment_test'::regclass ORDER BY 1, 2;
SELECT conname as constraint, obj_description(oid, 'pg_constraint') as comment FROM pg_constraint where conrelid = 'comment_test'::regclass ORDER BY 1, 2;
ALTER TABLE comment_test ALTER COLUMN indexed_col SET DATA TYPE int;
ALTER TABLE comment_test ALTER COLUMN indexed_col SET DATA TYPE text;
ALTER TABLE comment_test ALTER COLUMN id SET DATA TYPE int;
ALTER TABLE comment_test ALTER COLUMN id SET DATA TYPE text;
ALTER TABLE comment_test ALTER COLUMN positive_col SET DATA TYPE int;
ALTER TABLE comment_test ALTER COLUMN positive_col SET DATA TYPE bigint;
SELECT col_description('comment_test'::regclass, 1) as comment;
SELECT indexrelid::regclass::text as index, obj_description(indexrelid, 'pg_class') as comment FROM pg_index where indrelid = 'comment_test'::regclass ORDER BY 1, 2;
SELECT conname as constraint, obj_description(oid, 'pg_constraint') as comment FROM pg_constraint where conrelid = 'comment_test'::regclass ORDER BY 1, 2;
CREATE TABLE comment_test_child (
  id text CONSTRAINT comment_test_child_fk REFERENCES comment_test);
CREATE INDEX comment_test_child_fk ON comment_test_child(id);
COMMENT ON COLUMN comment_test_child.id IS 'Column ''id'' on comment_test_child';
COMMENT ON INDEX comment_test_child_fk IS 'Index backing the FOREIGN KEY of comment_test_child';
COMMENT ON CONSTRAINT comment_test_child_fk ON comment_test_child IS 'FOREIGN KEY constraint of comment_test_child';
ALTER TABLE comment_test ALTER COLUMN id SET DATA TYPE text;
SELECT col_description('comment_test_child'::regclass, 1) as comment;
SELECT indexrelid::regclass::text as index, obj_description(indexrelid, 'pg_class') as comment FROM pg_index where indrelid = 'comment_test_child'::regclass ORDER BY 1, 2;
SELECT conname as constraint, obj_description(oid, 'pg_constraint') as comment FROM pg_constraint where conrelid = 'comment_test_child'::regclass ORDER BY 1, 2;
CREATE TEMP TABLE filenode_mapping AS
SELECT
    oid, mapped_oid, reltablespace, relfilenode, relname
FROM pg_class,
    pg_filenode_relation(reltablespace, pg_relation_filenode(oid)) AS mapped_oid
WHERE relkind IN ('r', 'i', 'S', 't', 'm') AND mapped_oid IS DISTINCT FROM oid;
SELECT m.* FROM filenode_mapping m LEFT JOIN pg_class c ON c.oid = m.oid
WHERE c.oid IS NOT NULL OR m.mapped_oid IS NOT NULL;
SHOW allow_system_table_mods;
CREATE TABLE new_system_table(id serial primary key, othercol text);
ALTER TABLE new_system_table SET SCHEMA public;
ALTER TABLE new_system_table RENAME TO old_system_table;
CREATE INDEX old_system_table__othercol ON old_system_table (othercol);
INSERT INTO old_system_table(othercol) VALUES ('somedata'), ('otherdata');
UPDATE old_system_table SET id = -id;
DELETE FROM old_system_table WHERE othercol = 'somedata';
TRUNCATE old_system_table;
ALTER TABLE old_system_table DROP CONSTRAINT new_system_table_pkey;
ALTER TABLE old_system_table DROP COLUMN othercol;
DROP TABLE old_system_table;
CREATE UNLOGGED TABLE unlogged1(f1 SERIAL PRIMARY KEY, f2 TEXT);
SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^unlogged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^unlogged1'
UNION ALL
SELECT r.relname || ' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^unlogged1'
ORDER BY relname;
CREATE UNLOGGED TABLE unlogged2(f1 SERIAL PRIMARY KEY, f2 INTEGER REFERENCES unlogged1);
CREATE UNLOGGED TABLE unlogged3(f1 SERIAL PRIMARY KEY, f2 INTEGER REFERENCES unlogged3);
ALTER TABLE unlogged3 SET LOGGED;
ALTER TABLE unlogged1 SET LOGGED;
SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^unlogged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^unlogged1'
UNION ALL
SELECT r.relname || ' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^unlogged1'
ORDER BY relname;
ALTER TABLE unlogged1 SET LOGGED;
DROP TABLE unlogged3;
DROP TABLE unlogged2;
DROP TABLE unlogged1;
CREATE TABLE logged1(f1 SERIAL PRIMARY KEY, f2 TEXT);
SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^logged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^logged1'
UNION ALL
SELECT r.relname ||' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^logged1'
ORDER BY relname;
CREATE TABLE logged2(f1 SERIAL PRIMARY KEY, f2 INTEGER REFERENCES logged1);
CREATE TABLE logged3(f1 SERIAL PRIMARY KEY, f2 INTEGER REFERENCES logged3);
ALTER TABLE logged3 SET UNLOGGED;
ALTER TABLE logged2 SET UNLOGGED;
ALTER TABLE logged1 SET UNLOGGED;
SELECT relname, relkind, relpersistence FROM pg_class WHERE relname ~ '^logged1'
UNION ALL
SELECT r.relname || ' toast table', t.relkind, t.relpersistence FROM pg_class r JOIN pg_class t ON t.oid = r.reltoastrelid WHERE r.relname ~ '^logged1'
UNION ALL
SELECT r.relname || ' toast index', ri.relkind, ri.relpersistence FROM pg_class r join pg_class t ON t.oid = r.reltoastrelid JOIN pg_index i ON i.indrelid = t.oid JOIN pg_class ri ON ri.oid = i.indexrelid WHERE r.relname ~ '^logged1'
ORDER BY relname;
ALTER TABLE logged1 SET UNLOGGED;
DROP TABLE logged3;
DROP TABLE logged2;
DROP TABLE logged1;
CREATE TABLE test_add_column(c1 integer);
ALTER TABLE test_add_column
	ADD COLUMN c2 integer;
ALTER TABLE test_add_column
	ADD COLUMN IF NOT EXISTS c2 integer;
ALTER TABLE ONLY test_add_column
	ADD COLUMN IF NOT EXISTS c2 integer;
ALTER TABLE test_add_column
	ADD COLUMN IF NOT EXISTS c2 integer, 
	ADD COLUMN c3 integer primary key;
ALTER TABLE test_add_column
	ADD COLUMN IF NOT EXISTS c2 integer, 
	ADD COLUMN IF NOT EXISTS c3 integer primary key;
ALTER TABLE test_add_column
	ADD COLUMN IF NOT EXISTS c2 integer, 
	ADD COLUMN IF NOT EXISTS c3 integer, 
	ADD COLUMN c4 integer REFERENCES test_add_column;
ALTER TABLE test_add_column
	ADD COLUMN IF NOT EXISTS c4 integer REFERENCES test_add_column;
ALTER TABLE test_add_column
	ADD COLUMN IF NOT EXISTS c5 SERIAL CHECK (c5 > 8);
ALTER TABLE test_add_column
	ADD COLUMN IF NOT EXISTS c5 SERIAL CHECK (c5 > 10);
DROP TABLE test_add_column;
CREATE TABLE ataddindex(f1 INT);
INSERT INTO ataddindex VALUES (42), (43);
CREATE UNIQUE INDEX ataddindexi0 ON ataddindex(f1);
ALTER TABLE ataddindex
  ADD PRIMARY KEY USING INDEX ataddindexi0,
  ALTER f1 TYPE BIGINT;
DROP TABLE ataddindex;
CREATE TABLE ataddindex(f1 VARCHAR(10));
INSERT INTO ataddindex(f1) VALUES ('foo'), ('a');
ALTER TABLE ataddindex
  ALTER f1 SET DATA TYPE TEXT,
  ADD EXCLUDE ((f1 LIKE 'a') WITH =);
DROP TABLE ataddindex;
CREATE TABLE ataddindex(id int, ref_id int);
ALTER TABLE ataddindex
  ADD PRIMARY KEY (id),
  ADD FOREIGN KEY (ref_id) REFERENCES ataddindex;
DROP TABLE ataddindex;
CREATE TABLE ataddindex(id int, ref_id int);
ALTER TABLE ataddindex
  ADD UNIQUE (id),
  ADD FOREIGN KEY (ref_id) REFERENCES ataddindex (id);
DROP TABLE ataddindex;
CREATE TABLE atnotnull1 ();
ALTER TABLE atnotnull1
  ADD COLUMN a INT,
  ALTER a SET NOT NULL;
ALTER TABLE atnotnull1
  ADD COLUMN c INT,
  ADD PRIMARY KEY (c);
CREATE TABLE partitioned (
	a int,
	b int
) PARTITION BY RANGE (a, (a+b+1));
CREATE TABLE nonpartitioned (
	a int,
	b int
);
DROP TABLE partitioned, nonpartitioned;
CREATE TABLE unparted (
	a int
);
CREATE TABLE fail_part (like unparted);
DROP TABLE unparted, fail_part;
CREATE TABLE list_parted (
	a int NOT NULL,
	b char(2) COLLATE "C",
	CONSTRAINT check_a CHECK (a > 0)
) PARTITION BY LIST (a);
CREATE TABLE fail_part (LIKE list_parted);
DROP TABLE fail_part;
CREATE TABLE not_owned_by_me (LIKE list_parted);
CREATE TABLE owned_by_me (
	a int
) PARTITION BY LIST (a);
RESET SESSION AUTHORIZATION;
DROP TABLE owned_by_me, not_owned_by_me;
CREATE TABLE parent (LIKE list_parted);
CREATE TABLE child () INHERITS (parent);
DROP TABLE parent CASCADE;
CREATE TEMP TABLE temp_parted (a int) PARTITION BY LIST (a);
CREATE TABLE perm_part (a int);
DROP TABLE temp_parted, perm_part;
CREATE TYPE mytype AS (a int);
CREATE TABLE fail_part OF mytype;
DROP TYPE mytype CASCADE;
CREATE TABLE fail_part (like list_parted, c int);
DROP TABLE fail_part;
CREATE TABLE fail_part (a int NOT NULL);
DROP TABLE fail_part;
CREATE TABLE fail_part (
	b char(3),
	a int NOT NULL
);
ALTER TABLE fail_part ALTER b TYPE char (2) COLLATE "POSIX";
DROP TABLE fail_part;
CREATE TABLE fail_part (
	b char(2) COLLATE "C",
	a int NOT NULL
);
ALTER TABLE fail_part ADD CONSTRAINT check_a CHECK (a >= 0);
DROP TABLE fail_part;
CREATE TABLE part_1 (
	a int NOT NULL,
	b char(2) COLLATE "C",
	CONSTRAINT check_a CHECK (a > 0)
);
ALTER TABLE list_parted ATTACH PARTITION part_1 FOR VALUES IN (1);
SELECT attislocal, attinhcount FROM pg_attribute WHERE attrelid = 'part_1'::regclass AND attnum > 0;
SELECT conislocal, coninhcount FROM pg_constraint WHERE conrelid = 'part_1'::regclass AND conname = 'check_a';
CREATE TABLE fail_part (LIKE part_1 INCLUDING CONSTRAINTS);
DROP TABLE fail_part;
CREATE TABLE def_part (LIKE list_parted INCLUDING CONSTRAINTS);
ALTER TABLE list_parted ATTACH PARTITION def_part DEFAULT;
CREATE TABLE fail_def_part (LIKE part_1 INCLUDING CONSTRAINTS);
CREATE TABLE list_parted2 (
	a int,
	b char
) PARTITION BY LIST (a);
CREATE TABLE part_2 (LIKE list_parted2);
INSERT INTO part_2 VALUES (3, 'a');
DELETE FROM part_2;
ALTER TABLE list_parted2 ATTACH PARTITION part_2 FOR VALUES IN (2);
CREATE TABLE list_parted2_def PARTITION OF list_parted2 DEFAULT;
INSERT INTO list_parted2_def VALUES (11, 'z');
CREATE TABLE part_3 (LIKE list_parted2);
DELETE FROM list_parted2_def WHERE a = 11;
ALTER TABLE list_parted2 ATTACH PARTITION part_3 FOR VALUES IN (11);
CREATE TABLE part_3_4 (
	LIKE list_parted2,
	CONSTRAINT check_a CHECK (a IN (3))
);
ALTER TABLE list_parted2 ATTACH PARTITION part_3_4 FOR VALUES IN (3, 4);
ALTER TABLE list_parted2 DETACH PARTITION part_3_4;
ALTER TABLE part_3_4 ALTER a SET NOT NULL;
ALTER TABLE list_parted2 ATTACH PARTITION part_3_4 FOR VALUES IN (3, 4);
ALTER TABLE list_parted2_def ADD CONSTRAINT check_a CHECK (a IN (5, 6));
CREATE TABLE part_55_66 PARTITION OF list_parted2 FOR VALUES IN (55, 66);
CREATE TABLE range_parted (
	a int,
	b int
) PARTITION BY RANGE (a, b);
CREATE TABLE part1 (
	a int NOT NULL CHECK (a = 1),
	b int NOT NULL CHECK (b >= 1 AND b <= 10)
);
INSERT INTO part1 VALUES (1, 10);
DELETE FROM part1;
ALTER TABLE range_parted ATTACH PARTITION part1 FOR VALUES FROM (1, 1) TO (1, 10);
CREATE TABLE part2 (
	a int NOT NULL CHECK (a = 1),
	b int NOT NULL CHECK (b >= 10 AND b < 18)
);
ALTER TABLE range_parted ATTACH PARTITION part2 FOR VALUES FROM (1, 10) TO (1, 20);
CREATE TABLE partr_def1 PARTITION OF range_parted DEFAULT;
CREATE TABLE partr_def2 (LIKE part1 INCLUDING CONSTRAINTS);
INSERT INTO partr_def1 VALUES (2, 10);
CREATE TABLE part3 (LIKE range_parted);
ALTER TABLE range_parted ATTACH partition part3 FOR VALUES FROM (3, 10) TO (3, 20);
CREATE TABLE part_5 (
	LIKE list_parted2
) PARTITION BY LIST (b);
CREATE TABLE part_5_a PARTITION OF part_5 FOR VALUES IN ('a');
INSERT INTO part_5_a (a, b) VALUES (6, 'a');
DELETE FROM part_5_a WHERE a NOT IN (3);
ALTER TABLE part_5 ADD CONSTRAINT check_a CHECK (a IS NOT NULL AND a = 5);
ALTER TABLE list_parted2 ATTACH PARTITION part_5 FOR VALUES IN (5);
ALTER TABLE list_parted2 DETACH PARTITION part_5;
ALTER TABLE part_5 DROP CONSTRAINT check_a;
ALTER TABLE part_5 ADD CONSTRAINT check_a CHECK (a IN (5)), ALTER a SET NOT NULL;
ALTER TABLE list_parted2 ATTACH PARTITION part_5 FOR VALUES IN (5);
CREATE TABLE part_6 (
	c int,
	LIKE list_parted2,
	CONSTRAINT check_a CHECK (a IS NOT NULL AND a = 6)
);
ALTER TABLE part_6 DROP c;
ALTER TABLE list_parted2 ATTACH PARTITION part_6 FOR VALUES IN (6);
CREATE TABLE part_7 (
	LIKE list_parted2,
	CONSTRAINT check_a CHECK (a IS NOT NULL AND a = 7)
) PARTITION BY LIST (b);
CREATE TABLE part_7_a_null (
	c int,
	d int,
	e int,
	LIKE list_parted2,  
	CONSTRAINT check_b CHECK (b IS NULL OR b = 'a'),
	CONSTRAINT check_a CHECK (a IS NOT NULL AND a = 7)
);
ALTER TABLE part_7_a_null DROP c, DROP d, DROP e;
ALTER TABLE part_7 ATTACH PARTITION part_7_a_null FOR VALUES IN ('a', null);
ALTER TABLE list_parted2 ATTACH PARTITION part_7 FOR VALUES IN (7);
ALTER TABLE list_parted2 DETACH PARTITION part_7;
ALTER TABLE part_7 DROP CONSTRAINT check_a;
INSERT INTO part_7 (a, b) VALUES (8, null), (9, 'a');
SELECT tableoid::regclass, a, b FROM part_7 order by a;
ALTER TABLE part_5 DROP CONSTRAINT check_a;
CREATE TABLE part5_def PARTITION OF part_5 DEFAULT PARTITION BY LIST(a);
CREATE TABLE part5_def_p1 PARTITION OF part5_def FOR VALUES IN (5);
INSERT INTO part5_def_p1 VALUES (5, 'y');
CREATE TABLE part5_p1 (LIKE part_5);
DELETE FROM part5_def_p1 WHERE b = 'y';
ALTER TABLE part_5 ATTACH PARTITION part5_p1 FOR VALUES IN ('y');
CREATE TABLE quuux (a int, b text) PARTITION BY LIST (a);
CREATE TABLE quuux_default PARTITION OF quuux DEFAULT PARTITION BY LIST (b);
CREATE TABLE quuux_default1 PARTITION OF quuux_default (
	CONSTRAINT check_1 CHECK (a IS NOT NULL AND a = 1)
) FOR VALUES IN ('b');
CREATE TABLE quuux1 (a int, b text);
ALTER TABLE quuux ATTACH PARTITION quuux1 FOR VALUES IN (1);
CREATE TABLE quuux2 (a int, b text);
ALTER TABLE quuux ATTACH PARTITION quuux2 FOR VALUES IN (2);
DROP TABLE quuux1, quuux2;
CREATE TABLE quuux1 PARTITION OF quuux FOR VALUES IN (1);
CREATE TABLE quuux2 PARTITION OF quuux FOR VALUES IN (2);
DROP TABLE quuux;
CREATE TABLE regular_table (a int);
DROP TABLE regular_table;
CREATE TABLE not_a_part (a int);
DROP TABLE not_a_part;
ALTER TABLE list_parted2 DETACH PARTITION part_3_4;
SELECT attinhcount, attislocal FROM pg_attribute WHERE attrelid = 'part_3_4'::regclass AND attnum > 0;
SELECT coninhcount, conislocal FROM pg_constraint WHERE conrelid = 'part_3_4'::regclass AND conname = 'check_a';
DROP TABLE part_3_4;
CREATE TABLE range_parted2 (
    a int
) PARTITION BY RANGE(a);
CREATE TABLE part_rp PARTITION OF range_parted2 FOR VALUES FROM (0) to (100);
ALTER TABLE range_parted2 DETACH PARTITION part_rp;
DROP TABLE range_parted2;
SELECT * from part_rp;
DROP TABLE part_rp;
CREATE TABLE range_parted2 (
	a int
) PARTITION BY RANGE(a);
CREATE TABLE part_rp PARTITION OF range_parted2 FOR VALUES FROM (0) to (100);
BEGIN;
COMMIT;
CREATE TABLE part_rpd PARTITION OF range_parted2 DEFAULT;
DROP TABLE part_rpd;
ALTER TABLE range_parted2 DETACH PARTITION part_rp CONCURRENTLY;
CREATE TABLE part_rp100 PARTITION OF range_parted2 (CHECK (a>=123 AND a<133 AND a IS NOT NULL)) FOR VALUES FROM (100) to (200);
ALTER TABLE range_parted2 DETACH PARTITION part_rp100 CONCURRENTLY;
DROP TABLE range_parted2;
ALTER TABLE list_parted2 ALTER b SET NOT NULL;
ALTER TABLE list_parted2 ADD CONSTRAINT check_b CHECK (b <> 'zz');
CREATE TABLE parted_no_parts (a int) PARTITION BY LIST (a);
ALTER TABLE ONLY parted_no_parts ALTER a SET NOT NULL;
ALTER TABLE ONLY parted_no_parts ADD CONSTRAINT check_a CHECK (a > 0);
ALTER TABLE ONLY parted_no_parts ALTER a DROP NOT NULL;
ALTER TABLE ONLY parted_no_parts DROP CONSTRAINT check_a;
DROP TABLE parted_no_parts;
ALTER TABLE list_parted2 ALTER b SET NOT NULL, ADD CONSTRAINT check_a2 CHECK (a > 0);
CREATE TABLE inh_test (LIKE part_2);
ALTER TABLE list_parted DROP COLUMN b;
SELECT * FROM list_parted;
DROP TABLE list_parted, list_parted2, range_parted;
DROP TABLE fail_def_part;
create table p (a int, b int) partition by range (a, b);
create table p1 (b int, a int not null) partition by range (b);
create table p11 (like p1);
alter table p11 drop a;
alter table p11 add a int;
alter table p11 drop a;
alter table p11 add a int not null;
select attrelid::regclass, attname, attnum
from pg_attribute
where attname = 'a'
 and (attrelid = 'p'::regclass
   or attrelid = 'p1'::regclass
   or attrelid = 'p11'::regclass)
order by attrelid::regclass::text;
alter table p1 attach partition p11 for values from (2) to (5);
insert into p1 (a, b) values (2, 3);
drop table p;
drop table p1;
create table parted_validate_test (a int) partition by list (a);
create table parted_validate_test_1 partition of parted_validate_test for values in (0, 1);
alter table parted_validate_test add constraint parted_validate_test_chka check (a > 0) not valid;
alter table parted_validate_test validate constraint parted_validate_test_chka;
drop table parted_validate_test;
CREATE TABLE attmp(i integer);
INSERT INTO attmp VALUES (1);
ALTER TABLE attmp ALTER COLUMN i SET (n_distinct = 1, n_distinct_inherited = 2);
ALTER TABLE attmp ALTER COLUMN i RESET (n_distinct_inherited);
ANALYZE attmp;
DROP TABLE attmp;
create table defpart_attach_test (a int) partition by list (a);
create table defpart_attach_test1 partition of defpart_attach_test for values in (1);
create table defpart_attach_test_d (b int, a int);
alter table defpart_attach_test_d drop b;
insert into defpart_attach_test_d values (1), (2);
delete from defpart_attach_test_d where a = 1;
alter table defpart_attach_test_d add check (a > 1);
alter table defpart_attach_test attach partition defpart_attach_test_d default;
create table defpart_attach_test_2 (like defpart_attach_test_d);
drop table defpart_attach_test;
create table perm_part_parent (a int) partition by list (a);
create temp table temp_part_parent (a int) partition by list (a);
create table perm_part_child (a int);
create temp table temp_part_child (a int);
alter table temp_part_parent attach partition temp_part_child default;
drop table perm_part_parent cascade;
drop table temp_part_parent cascade;
create table tab_part_attach (a int) partition by list (a);
drop table tab_part_attach;
create table at_test_sql_partop_1 (a int);
create table bar1 (a integer, b integer not null default 1)
  partition by range (a);
create table bar2 (a integer);
insert into bar2 values (1);
alter table bar2 add column b integer not null default 1;
alter table bar1 attach partition bar2 default;
select * from bar1;
update bar1 set a = a + 1;
create table attbl (p1 int constraint pk_attbl primary key);
create table atref (c1 int references attbl(p1));
cluster attbl using pk_attbl;
alter table attbl alter column p1 set data type bigint;
alter table atref alter column c1 set data type bigint;
drop table attbl, atref;
create table attbl (p1 int constraint pk_attbl primary key);
alter table attbl replica identity using index pk_attbl;
create table atref (c1 int references attbl(p1));
alter table attbl alter column p1 set data type bigint;
alter table atref alter column c1 set data type bigint;
drop table attbl, atref;
create table alttype_cluster (a int);
alter table alttype_cluster add primary key (a);
create index alttype_cluster_ind on alttype_cluster (a);
alter table alttype_cluster cluster on alttype_cluster_ind;
select indexrelid::regclass, indisclustered from pg_index
  where indrelid = 'alttype_cluster'::regclass
  order by indexrelid::regclass::text;
alter table alttype_cluster alter a type bigint;
select indexrelid::regclass, indisclustered from pg_index
  where indrelid = 'alttype_cluster'::regclass
  order by indexrelid::regclass::text;
alter table alttype_cluster cluster on alttype_cluster_pkey;
select indexrelid::regclass, indisclustered from pg_index
  where indrelid = 'alttype_cluster'::regclass
  order by indexrelid::regclass::text;
alter table alttype_cluster alter a type int;
select indexrelid::regclass, indisclustered from pg_index
  where indrelid = 'alttype_cluster'::regclass
  order by indexrelid::regclass::text;
drop table alttype_cluster;
create table target_parted (a int, b int) partition by list (a);
create table attach_parted (a int, b int) partition by list (b);
create table attach_parted_part1 partition of attach_parted for values in (1);
insert into attach_parted_part1 values (1, 1);
alter table target_parted attach partition attach_parted for values in (1);
alter table target_parted detach partition attach_parted;
insert into attach_parted_part1 values (2, 1);
create schema alter1;
create schema alter2;
create table alter1.t1 (a int);
set client_min_messages = 'ERROR';
reset client_min_messages;
alter table alter1.t1 set schema alter2;
drop schema alter1 cascade;
drop schema alter2 cascade;