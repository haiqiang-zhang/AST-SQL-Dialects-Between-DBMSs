CREATE TABLE PKTABLE ( ptest1 int PRIMARY KEY, ptest2 text );
CREATE TABLE FKTABLE ( ftest1 int REFERENCES PKTABLE MATCH FULL ON DELETE CASCADE ON UPDATE CASCADE, ftest2 int );
INSERT INTO PKTABLE VALUES (1, 'Test1');
INSERT INTO PKTABLE VALUES (2, 'Test2');
INSERT INTO PKTABLE VALUES (3, 'Test3');
INSERT INTO PKTABLE VALUES (4, 'Test4');
INSERT INTO PKTABLE VALUES (5, 'Test5');
INSERT INTO FKTABLE VALUES (1, 2);
INSERT INTO FKTABLE VALUES (2, 3);
INSERT INTO FKTABLE VALUES (3, 4);
INSERT INTO FKTABLE VALUES (NULL, 1);
SELECT * FROM FKTABLE;
DELETE FROM PKTABLE WHERE ptest1=1;
SELECT * FROM FKTABLE;
UPDATE PKTABLE SET ptest1=1 WHERE ptest1=2;
SELECT * FROM FKTABLE;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE ( ptest1 int, ptest2 int, ptest3 text, PRIMARY KEY(ptest1, ptest2) );
CREATE TABLE FKTABLE ( ftest1 int, ftest2 int, ftest3 int, CONSTRAINT constrname FOREIGN KEY(ftest1, ftest2)
                       REFERENCES PKTABLE MATCH FULL ON DELETE SET NULL ON UPDATE SET NULL);
COMMENT ON CONSTRAINT constrname ON FKTABLE IS 'fk constraint comment';
COMMENT ON CONSTRAINT constrname ON FKTABLE IS NULL;
INSERT INTO PKTABLE VALUES (1, 2, 'Test1');
INSERT INTO PKTABLE VALUES (1, 3, 'Test1-2');
INSERT INTO PKTABLE VALUES (2, 4, 'Test2');
INSERT INTO PKTABLE VALUES (3, 6, 'Test3');
INSERT INTO PKTABLE VALUES (4, 8, 'Test4');
INSERT INTO PKTABLE VALUES (5, 10, 'Test5');
INSERT INTO FKTABLE VALUES (1, 2, 4);
INSERT INTO FKTABLE VALUES (1, 3, 5);
INSERT INTO FKTABLE VALUES (2, 4, 8);
INSERT INTO FKTABLE VALUES (3, 6, 12);
INSERT INTO FKTABLE VALUES (NULL, NULL, 0);
SELECT * FROM FKTABLE;
DELETE FROM PKTABLE WHERE ptest1=1 and ptest2=2;
SELECT * FROM FKTABLE;
DELETE FROM PKTABLE WHERE ptest1=5 and ptest2=10;
SELECT * FROM FKTABLE;
UPDATE PKTABLE SET ptest1=1 WHERE ptest1=2;
SELECT * FROM FKTABLE;
UPDATE FKTABLE SET ftest1 = 1 WHERE ftest1 = 1;
ALTER TABLE PKTABLE ALTER COLUMN ptest1 TYPE bigint;
ALTER TABLE FKTABLE ALTER COLUMN ftest1 TYPE bigint;
SELECT * FROM PKTABLE;
SELECT * FROM FKTABLE;
DROP TABLE PKTABLE CASCADE;
DROP TABLE FKTABLE;
CREATE TABLE PKTABLE ( ptest1 int, ptest2 int, ptest3 text, PRIMARY KEY(ptest1, ptest2) );
CREATE TABLE FKTABLE ( ftest1 int DEFAULT -1, ftest2 int DEFAULT -2, ftest3 int, CONSTRAINT constrname2 FOREIGN KEY(ftest1, ftest2)
                       REFERENCES PKTABLE MATCH FULL ON DELETE SET DEFAULT ON UPDATE SET DEFAULT);
INSERT INTO PKTABLE VALUES (-1, -2, 'The Default!');
INSERT INTO PKTABLE VALUES (1, 2, 'Test1');
INSERT INTO PKTABLE VALUES (1, 3, 'Test1-2');
INSERT INTO PKTABLE VALUES (2, 4, 'Test2');
INSERT INTO PKTABLE VALUES (3, 6, 'Test3');
INSERT INTO PKTABLE VALUES (4, 8, 'Test4');
INSERT INTO PKTABLE VALUES (5, 10, 'Test5');
INSERT INTO FKTABLE VALUES (1, 2, 4);
INSERT INTO FKTABLE VALUES (1, 3, 5);
INSERT INTO FKTABLE VALUES (2, 4, 8);
INSERT INTO FKTABLE VALUES (3, 6, 12);
INSERT INTO FKTABLE VALUES (NULL, NULL, 0);
SELECT * FROM FKTABLE;
DELETE FROM PKTABLE WHERE ptest1=1 and ptest2=2;
SELECT * FROM FKTABLE;
DELETE FROM PKTABLE WHERE ptest1=5 and ptest2=10;
SELECT * FROM FKTABLE;
UPDATE PKTABLE SET ptest1=1 WHERE ptest1=2;
SELECT * FROM FKTABLE;
DROP TABLE PKTABLE CASCADE;
DROP TABLE FKTABLE;
CREATE TABLE PKTABLE ( ptest1 int PRIMARY KEY, ptest2 text );
CREATE TABLE FKTABLE ( ftest1 int REFERENCES PKTABLE MATCH FULL, ftest2 int );
INSERT INTO PKTABLE VALUES (1, 'Test1');
INSERT INTO PKTABLE VALUES (2, 'Test2');
INSERT INTO PKTABLE VALUES (3, 'Test3');
INSERT INTO PKTABLE VALUES (4, 'Test4');
INSERT INTO PKTABLE VALUES (5, 'Test5');
INSERT INTO FKTABLE VALUES (1, 2);
INSERT INTO FKTABLE VALUES (2, 3);
INSERT INTO FKTABLE VALUES (3, 4);
INSERT INTO FKTABLE VALUES (NULL, 1);
SELECT * FROM FKTABLE;
SELECT * FROM PKTABLE;
DELETE FROM PKTABLE WHERE ptest1=5;
SELECT * FROM PKTABLE;
UPDATE PKTABLE SET ptest1=0 WHERE ptest1=4;
SELECT * FROM PKTABLE;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE ( ptest1 int, ptest2 int, PRIMARY KEY(ptest1, ptest2) );
CREATE TABLE FKTABLE ( ftest1 int, ftest2 int );
INSERT INTO PKTABLE VALUES (1, 2);
INSERT INTO FKTABLE VALUES (1, NULL);
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE ( ptest1 int, ptest2 int, ptest3 int, ptest4 text, PRIMARY KEY(ptest1, ptest2, ptest3) );
CREATE TABLE FKTABLE ( ftest1 int, ftest2 int, ftest3 int, ftest4 int,  CONSTRAINT constrname3
			FOREIGN KEY(ftest1, ftest2, ftest3) REFERENCES PKTABLE);
INSERT INTO PKTABLE VALUES (1, 2, 3, 'test1');
INSERT INTO PKTABLE VALUES (1, 3, 3, 'test2');
INSERT INTO PKTABLE VALUES (2, 3, 4, 'test3');
INSERT INTO PKTABLE VALUES (2, 4, 5, 'test4');
INSERT INTO FKTABLE VALUES (1, 2, 3, 1);
INSERT INTO FKTABLE VALUES (NULL, 2, 3, 2);
INSERT INTO FKTABLE VALUES (2, NULL, 3, 3);
INSERT INTO FKTABLE VALUES (NULL, 2, 7, 4);
INSERT INTO FKTABLE VALUES (NULL, 3, 4, 5);
SELECT * from FKTABLE;
UPDATE PKTABLE set ptest1=1 WHERE ptest2=3;
DELETE FROM PKTABLE where ptest1=2;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE ( ptest1 int, ptest2 int, ptest3 int, ptest4 text, UNIQUE(ptest1, ptest2, ptest3) );
CREATE TABLE FKTABLE ( ftest1 int, ftest2 int, ftest3 int, ftest4 int,  CONSTRAINT constrname3
			FOREIGN KEY(ftest1, ftest2, ftest3) REFERENCES PKTABLE (ptest1, ptest2, ptest3));
INSERT INTO PKTABLE VALUES (1, 2, 3, 'test1');
INSERT INTO PKTABLE VALUES (1, 3, NULL, 'test2');
INSERT INTO PKTABLE VALUES (2, NULL, 4, 'test3');
INSERT INTO FKTABLE VALUES (1, 2, 3, 1);
DELETE FROM PKTABLE WHERE ptest1 = 2;
SELECT * FROM PKTABLE;
SELECT * FROM FKTABLE;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE ( ptest1 int, ptest2 int, ptest3 int, ptest4 text, PRIMARY KEY(ptest1, ptest2, ptest3) );
CREATE TABLE FKTABLE ( ftest1 int, ftest2 int, ftest3 int, ftest4 int,  CONSTRAINT constrname3
			FOREIGN KEY(ftest1, ftest2, ftest3) REFERENCES PKTABLE
			ON DELETE CASCADE ON UPDATE CASCADE);
INSERT INTO PKTABLE VALUES (1, 2, 3, 'test1');
INSERT INTO PKTABLE VALUES (1, 3, 3, 'test2');
INSERT INTO PKTABLE VALUES (2, 3, 4, 'test3');
INSERT INTO PKTABLE VALUES (2, 4, 5, 'test4');
INSERT INTO FKTABLE VALUES (1, 2, 3, 1);
INSERT INTO FKTABLE VALUES (NULL, 2, 3, 2);
INSERT INTO FKTABLE VALUES (2, NULL, 3, 3);
INSERT INTO FKTABLE VALUES (NULL, 2, 7, 4);
INSERT INTO FKTABLE VALUES (NULL, 3, 4, 5);
SELECT * from FKTABLE;
UPDATE PKTABLE set ptest2=5 where ptest2=2;
UPDATE PKTABLE set ptest1=1 WHERE ptest2=3;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DELETE FROM PKTABLE where ptest1=1 and ptest2=5 and ptest3=3;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DELETE FROM PKTABLE where ptest1=2;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE ( ptest1 int, ptest2 int, ptest3 int, ptest4 text, PRIMARY KEY(ptest1, ptest2, ptest3) );
CREATE TABLE FKTABLE ( ftest1 int DEFAULT 0, ftest2 int, ftest3 int, ftest4 int,  CONSTRAINT constrname3
			FOREIGN KEY(ftest1, ftest2, ftest3) REFERENCES PKTABLE
			ON DELETE SET DEFAULT ON UPDATE SET NULL);
INSERT INTO PKTABLE VALUES (1, 2, 3, 'test1');
INSERT INTO PKTABLE VALUES (1, 3, 3, 'test2');
INSERT INTO PKTABLE VALUES (2, 3, 4, 'test3');
INSERT INTO PKTABLE VALUES (2, 4, 5, 'test4');
INSERT INTO FKTABLE VALUES (1, 2, 3, 1);
INSERT INTO FKTABLE VALUES (2, 3, 4, 1);
INSERT INTO FKTABLE VALUES (NULL, 2, 3, 2);
INSERT INTO FKTABLE VALUES (2, NULL, 3, 3);
INSERT INTO FKTABLE VALUES (NULL, 2, 7, 4);
INSERT INTO FKTABLE VALUES (NULL, 3, 4, 5);
SELECT * from FKTABLE;
UPDATE PKTABLE set ptest2=5 where ptest2=2;
UPDATE PKTABLE set ptest2=2 WHERE ptest2=3 and ptest1=1;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DELETE FROM PKTABLE where ptest1=2 and ptest2=3 and ptest3=4;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DELETE FROM PKTABLE where ptest2=5;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE ( ptest1 int, ptest2 int, ptest3 int, ptest4 text, PRIMARY KEY(ptest1, ptest2, ptest3) );
CREATE TABLE FKTABLE ( ftest1 int DEFAULT 0, ftest2 int DEFAULT -1, ftest3 int DEFAULT -2, ftest4 int, CONSTRAINT constrname3
			FOREIGN KEY(ftest1, ftest2, ftest3) REFERENCES PKTABLE
			ON DELETE SET NULL ON UPDATE SET DEFAULT);
INSERT INTO PKTABLE VALUES (1, 2, 3, 'test1');
INSERT INTO PKTABLE VALUES (1, 3, 3, 'test2');
INSERT INTO PKTABLE VALUES (2, 3, 4, 'test3');
INSERT INTO PKTABLE VALUES (2, 4, 5, 'test4');
INSERT INTO PKTABLE VALUES (2, -1, 5, 'test5');
INSERT INTO FKTABLE VALUES (1, 2, 3, 1);
INSERT INTO FKTABLE VALUES (2, 3, 4, 1);
INSERT INTO FKTABLE VALUES (2, 4, 5, 1);
INSERT INTO FKTABLE VALUES (NULL, 2, 3, 2);
INSERT INTO FKTABLE VALUES (2, NULL, 3, 3);
INSERT INTO FKTABLE VALUES (NULL, 2, 7, 4);
INSERT INTO FKTABLE VALUES (NULL, 3, 4, 5);
SELECT * from FKTABLE;
UPDATE PKTABLE set ptest1=0, ptest2=-1, ptest3=-2 where ptest2=2;
UPDATE PKTABLE set ptest2=10 where ptest2=4;
UPDATE PKTABLE set ptest2=2 WHERE ptest2=3 and ptest1=1;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DELETE FROM PKTABLE where ptest1=2 and ptest2=3 and ptest3=4;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DELETE FROM PKTABLE where ptest2=-1 and ptest3=5;
SELECT * from PKTABLE;
SELECT * from FKTABLE;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE (tid int, id int, PRIMARY KEY (tid, id));
CREATE TABLE FKTABLE (
  tid int, id int,
  fk_id_del_set_null int,
  fk_id_del_set_default int DEFAULT 0,
  FOREIGN KEY (tid, fk_id_del_set_null) REFERENCES PKTABLE ON DELETE SET NULL (fk_id_del_set_null),
  FOREIGN KEY (tid, fk_id_del_set_default) REFERENCES PKTABLE ON DELETE SET DEFAULT (fk_id_del_set_default)
);
SELECT pg_get_constraintdef(oid) FROM pg_constraint WHERE conrelid = 'fktable'::regclass::oid ORDER BY oid;
INSERT INTO PKTABLE VALUES (1, 0), (1, 1), (1, 2);
INSERT INTO FKTABLE VALUES
  (1, 1, 1, NULL),
  (1, 2, NULL, 2);
DELETE FROM PKTABLE WHERE id = 1 OR id = 2;
SELECT * FROM FKTABLE ORDER BY id;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE (ptest1 int PRIMARY KEY, someoid oid);
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE (ptest1 int, ptest2 int, UNIQUE(ptest1, ptest2));
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE (ptest1 int PRIMARY KEY);
INSERT INTO PKTABLE VALUES(42);
CREATE TABLE FKTABLE (ftest1 int8 REFERENCES pktable);
INSERT INTO FKTABLE VALUES(42);
UPDATE FKTABLE SET ftest1 = ftest1;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE (ptest1 numeric PRIMARY KEY);
INSERT INTO PKTABLE VALUES(42);
CREATE TABLE FKTABLE (ftest1 int REFERENCES pktable);
INSERT INTO FKTABLE VALUES(42);
UPDATE FKTABLE SET ftest1 = ftest1;
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE (ptest1 int, ptest2 inet, PRIMARY KEY(ptest1, ptest2));
CREATE TABLE FKTABLE (ftest1 int, ftest2 inet, FOREIGN KEY(ftest2, ftest1) REFERENCES pktable(ptest2, ptest1));
DROP TABLE FKTABLE;
CREATE TABLE FKTABLE (ftest1 int, ftest2 inet, FOREIGN KEY(ftest1, ftest2) REFERENCES pktable(ptest1, ptest2));
DROP TABLE FKTABLE;
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE (ptest1 int, ptest2 inet, ptest3 int, ptest4 inet, PRIMARY KEY(ptest1, ptest2), FOREIGN KEY(ptest3,
ptest4) REFERENCES pktable(ptest1, ptest2));
DROP TABLE PKTABLE;
CREATE TABLE PKTABLE (ptest1 int, ptest2 inet, ptest3 int, ptest4 inet, PRIMARY KEY(ptest1, ptest2), FOREIGN KEY(ptest3,
ptest4) REFERENCES pktable);
DROP TABLE PKTABLE;
create table pktable_base (base1 int not null);
create table pktable (ptest1 int, primary key(base1), unique(base1, ptest1)) inherits (pktable_base);
create table fktable (ftest1 int references pktable(base1));
insert into pktable(base1) values (1);
insert into pktable(base1) values (2);
insert into pktable(base1) values (3);
insert into fktable(ftest1) values (3);
update pktable set base1=base1*4 where base1<3;
delete from pktable where base1>3;
drop table fktable;
delete from pktable;
create table fktable (ftest1 int, ftest2 int, foreign key(ftest1, ftest2) references pktable(base1, ptest1));
insert into pktable(base1, ptest1) values (1, 1);
insert into pktable(base1, ptest1) values (2, 2);
insert into pktable(base1,ptest1) values (3, 1);
insert into fktable(ftest1, ftest2) values (3, 1);
update pktable set base1=base1*4 where base1<3;
delete from pktable where base1>3;
drop table fktable;
drop table pktable;
drop table pktable_base;
create table pktable_base(base1 int not null, base2 int);
create table pktable(ptest1 int, ptest2 int, primary key(base1, ptest1), foreign key(base2, ptest2) references
                                             pktable(base1, ptest1)) inherits (pktable_base);
insert into pktable (base1, ptest1, base2, ptest2) values (1, 1, 1, 1);
insert into pktable (base1, ptest1, base2, ptest2) values (2, 1, 1, 1);
insert into pktable (base1, ptest1, base2, ptest2) values (2, 2, 2, 1);
insert into pktable (base1, ptest1, base2, ptest2) values (1, 3, 2, 2);
delete from pktable where base2=2;
delete from pktable where base1=2;
drop table pktable;
drop table pktable_base;
create table pktable_base(base1 int not null);
create table pktable(ptest1 inet, primary key(base1, ptest1)) inherits (pktable_base);
drop table pktable;
drop table pktable_base;
create table pktable_base(base1 int not null, base2 int);
drop table pktable_base;
CREATE TABLE pktable (
	id		INT4 PRIMARY KEY,
	other	INT4
);
CREATE TABLE fktable (
	id		INT4 PRIMARY KEY,
	fk		INT4 REFERENCES pktable DEFERRABLE
);
BEGIN;
SET CONSTRAINTS ALL DEFERRED;
INSERT INTO fktable VALUES (10, 15);
INSERT INTO pktable VALUES (15, 0);
COMMIT;
DROP TABLE fktable, pktable;
CREATE TABLE pktable (
	id		INT4 PRIMARY KEY,
	other	INT4
);
CREATE TABLE fktable (
	id		INT4 PRIMARY KEY,
	fk		INT4 REFERENCES pktable DEFERRABLE INITIALLY DEFERRED
);
BEGIN;
INSERT INTO fktable VALUES (100, 200);
INSERT INTO pktable VALUES (200, 500);
COMMIT;
BEGIN;
SET CONSTRAINTS ALL IMMEDIATE;
COMMIT;
DROP TABLE fktable, pktable;
CREATE TABLE pktable (
	id		INT4 PRIMARY KEY,
	other	INT4
);
CREATE TABLE fktable (
	id		INT4 PRIMARY KEY,
	fk		INT4 REFERENCES pktable DEFERRABLE
);
BEGIN;
SET CONSTRAINTS ALL DEFERRED;
INSERT INTO fktable VALUES (1000, 2000);
BEGIN;
create temp table selfref (
    a int primary key,
    b int,
    foreign key (b) references selfref (a)
        on update cascade on delete cascade
);
insert into selfref (a, b)
values
    (0, 0),
    (1, 1);
begin;
update selfref set a = 123 where a = 0;
select a, b from selfref;
update selfref set a = 456 where a = 123;
select a, b from selfref;
create temp table defp (f1 int primary key);
create temp table defc (f1 int default 0
                        references defp on delete set default);
insert into defp values (0), (1), (2);
insert into defc values (2);
select * from defc;
delete from defp where f1 = 2;
select * from defc;
alter table defc alter column f1 set default 1;
delete from defp where f1 = 0;
select * from defc;
create temp table pp (f1 int primary key);
create temp table cc (f1 int references pp on update no action on delete no action);
insert into pp values(12);
insert into pp values(11);
update pp set f1=f1+1;
insert into cc values(13);
update pp set f1=f1+1;
drop table pp, cc;
create temp table pp (f1 int primary key);
create temp table cc (f1 int references pp on update restrict on delete restrict);
insert into pp values(12);
insert into pp values(11);
update pp set f1=f1+1;
insert into cc values(13);
drop table pp, cc;
create temp table t1 (a integer primary key, b text);
create temp table t2 (a integer primary key, b integer references t1);
create rule r1 as on delete to t1 do delete from t2 where t2.b = old.a;
explain (costs off) delete from t1 where a = 1;
delete from t1 where a = 1;
create table pktable2 (a int, b int, c int, d int, e int, primary key (d, e));
create table fktable2 (d int, e int, foreign key (d, e) references pktable2);
insert into pktable2 values (1, 2, 3, 4, 5);
insert into fktable2 values (4, 5);
drop table pktable2, fktable2;
create table pktable1 (a int primary key);
create table pktable2 (a int, b int, primary key (a, b));
create table fktable2 (
  a int,
  b int,
  very_very_long_column_name_to_exceed_63_characters int,
  foreign key (very_very_long_column_name_to_exceed_63_characters) references pktable1,
  foreign key (a, very_very_long_column_name_to_exceed_63_characters) references pktable2,
  foreign key (a, very_very_long_column_name_to_exceed_63_characters) references pktable2
);
select conname from pg_constraint where conrelid = 'fktable2'::regclass order by conname;
drop table pktable1, pktable2, fktable2;
create table pktable2(f1 int primary key);
create table fktable2(f1 int references pktable2 deferrable initially deferred);
insert into pktable2 values(1);
begin;
insert into fktable2 values(1);
savepoint x;
delete from fktable2;
rollback to x;
begin;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
CREATE TABLE fk_partitioned_fk_2 (a int, b int) PARTITION BY RANGE (b);
CREATE TABLE fk_partitioned_fk_2_1 PARTITION OF fk_partitioned_fk_2 FOR VALUES FROM (0) TO (1000);
CREATE TABLE fk_partitioned_fk_2_2 PARTITION OF fk_partitioned_fk_2 FOR VALUES FROM (1000) TO (2000);
INSERT INTO fk_partitioned_fk_2 VALUES (1600, 601), (1600, 1601);
create table other_partitioned_fk(a int, b int) partition by list (a);
create table other_partitioned_fk_1 partition of other_partitioned_fk
  for values in (2048);
insert into other_partitioned_fk
  select 2048, x from generate_series(1,10) x;
reset role;
drop table other_partitioned_fk;
reset role;
CREATE TABLE parted_self_fk (
    id bigint NOT NULL PRIMARY KEY,
    id_abc bigint,
    FOREIGN KEY (id_abc) REFERENCES parted_self_fk(id)
)
PARTITION BY RANGE (id);
CREATE TABLE part1_self_fk (
    id bigint NOT NULL PRIMARY KEY,
    id_abc bigint
);
ALTER TABLE parted_self_fk ATTACH PARTITION part1_self_fk FOR VALUES FROM (0) TO (10);
CREATE TABLE part2_self_fk PARTITION OF parted_self_fk FOR VALUES FROM (10) TO (20);
CREATE TABLE part3_self_fk (	
	id bigint NOT NULL PRIMARY KEY,
	id_abc bigint
) PARTITION BY RANGE (id);
CREATE TABLE part32_self_fk PARTITION OF part3_self_fk FOR VALUES FROM (20) TO (30);
ALTER TABLE parted_self_fk ATTACH PARTITION part3_self_fk FOR VALUES FROM (20) TO (40);
CREATE TABLE part33_self_fk (
	id bigint NOT NULL PRIMARY KEY,
	id_abc bigint
);
ALTER TABLE part3_self_fk ATTACH PARTITION part33_self_fk FOR VALUES FROM (30) TO (40);
SELECT cr.relname, co.conname, co.contype, co.convalidated,
       p.conname AS conparent, p.convalidated, cf.relname AS foreignrel
FROM pg_constraint co
JOIN pg_class cr ON cr.oid = co.conrelid
LEFT JOIN pg_class cf ON cf.oid = co.confrelid
LEFT JOIN pg_constraint p ON p.oid = co.conparentid
WHERE cr.oid IN (SELECT relid FROM pg_partition_tree('parted_self_fk'))
ORDER BY co.contype, cr.relname, co.conname, p.conname;
ALTER TABLE parted_self_fk DETACH PARTITION part2_self_fk;
ALTER TABLE parted_self_fk ATTACH PARTITION part2_self_fk FOR VALUES FROM (10) TO (20);
ALTER TABLE parted_self_fk DETACH PARTITION part2_self_fk;
ALTER TABLE parted_self_fk ATTACH PARTITION part2_self_fk FOR VALUES FROM (10) TO (20);
SELECT cr.relname, co.conname, co.contype, co.convalidated,
       p.conname AS conparent, p.convalidated, cf.relname AS foreignrel
FROM pg_constraint co
JOIN pg_class cr ON cr.oid = co.conrelid
LEFT JOIN pg_class cf ON cf.oid = co.confrelid
LEFT JOIN pg_constraint p ON p.oid = co.conparentid
WHERE cr.oid IN (SELECT relid FROM pg_partition_tree('parted_self_fk'))
ORDER BY co.contype, cr.relname, co.conname, p.conname;
create schema fkpart0
  create table pkey (a int primary key)
  create table fk_part (a int) partition by list (a)
  create table fk_part_1 partition of fk_part
      (foreign key (a) references fkpart0.pkey) for values in (1)
  create table fk_part_23 partition of fk_part
      (foreign key (a) references fkpart0.pkey) for values in (2, 3)
      partition by list (a)
  create table fk_part_23_2 partition of fk_part_23 for values in (2);
alter table fkpart0.fk_part add foreign key (a) references fkpart0.pkey;
create table fkpart0.fk_part_4 partition of fkpart0.fk_part for values in (4);
create table fkpart0.fk_part_56 partition of fkpart0.fk_part
    for values in (5,6) partition by list (a);
create table fkpart0.fk_part_56_5 partition of fkpart0.fk_part_56
    for values in (5);
create schema fkpart1
  create table pkey (a int primary key)
  create table fk_part (a int) partition by list (a)
  create table fk_part_1 partition of fk_part for values in (1) partition by list (a)
  create table fk_part_1_1 partition of fk_part_1 for values in (1);
alter table fkpart1.fk_part add foreign key (a) references fkpart1.pkey;
insert into fkpart1.pkey values (1);
insert into fkpart1.fk_part values (1);
alter table fkpart1.fk_part detach partition fkpart1.fk_part_1;
create table fkpart1.fk_part_1_2 partition of fkpart1.fk_part_1 for values in (2);
create schema fkpart2
  create table pkey (a int primary key)
  create table fk_part (a int, constraint fkey foreign key (a) references fkpart2.pkey) partition by list (a)
  create table fk_part_1 partition of fkpart2.fk_part for values in (1) partition by list (a)
  create table fk_part_1_1 (a int, constraint my_fkey foreign key (a) references fkpart2.pkey);
alter table fkpart2.fk_part_1 attach partition fkpart2.fk_part_1_1 for values in (1);
alter table fkpart2.fk_part detach partition fkpart2.fk_part_1;
alter table fkpart2.fk_part_1 drop constraint fkey;
create schema fkpart3
  create table pkey (a int primary key)
  create table fk_part (a int, constraint fkey foreign key (a) references fkpart3.pkey deferrable initially immediate) partition by list (a)
  create table fk_part_1 partition of fkpart3.fk_part for values in (1) partition by list (a)
  create table fk_part_1_1 partition of fkpart3.fk_part_1 for values in (1)
  create table fk_part_2 partition of fkpart3.fk_part for values in (2);
begin;
set constraints fkpart3.fkey deferred;
insert into fkpart3.fk_part values (1);
insert into fkpart3.pkey values (1);
commit;
begin;
set constraints fkpart3.fkey deferred;
delete from fkpart3.pkey;
delete from fkpart3.fk_part;
commit;
drop schema fkpart0, fkpart1, fkpart2, fkpart3 cascade;
CREATE SCHEMA fkpart3;
SET search_path TO fkpart3;
CREATE TABLE pk (a int PRIMARY KEY) PARTITION BY RANGE (a);
CREATE TABLE pk1 PARTITION OF pk FOR VALUES FROM (0) TO (1000);
CREATE TABLE pk2 (b int, a int);
ALTER TABLE pk2 DROP COLUMN b;
ALTER TABLE pk2 ALTER a SET NOT NULL;
ALTER TABLE pk ATTACH PARTITION pk2 FOR VALUES FROM (1000) TO (2000);
CREATE TABLE fk (a int) PARTITION BY RANGE (a);
CREATE TABLE fk1 PARTITION OF fk FOR VALUES FROM (0) TO (750);
ALTER TABLE fk ADD FOREIGN KEY (a) REFERENCES pk;
CREATE TABLE fk2 (b int, a int);
ALTER TABLE fk2 DROP COLUMN b;
ALTER TABLE fk ATTACH PARTITION fk2 FOR VALUES FROM (750) TO (3500);
CREATE TABLE pk3 PARTITION OF pk FOR VALUES FROM (2000) TO (3000);
CREATE TABLE pk4 (LIKE pk);
ALTER TABLE pk ATTACH PARTITION pk4 FOR VALUES FROM (3000) TO (4000);
CREATE TABLE pk5 (c int, b int, a int NOT NULL) PARTITION BY RANGE (a);
ALTER TABLE pk5 DROP COLUMN b, DROP COLUMN c;
CREATE TABLE pk51 PARTITION OF pk5 FOR VALUES FROM (4000) TO (4500);
CREATE TABLE pk52 PARTITION OF pk5 FOR VALUES FROM (4500) TO (5000);
ALTER TABLE pk ATTACH PARTITION pk5 FOR VALUES FROM (4000) TO (5000);
CREATE TABLE fk3 PARTITION OF fk FOR VALUES FROM (3500) TO (5000);
INSERT into pk VALUES (1), (1000), (2000), (3000), (4000), (4500);
INSERT into fk VALUES (1), (1000), (2000), (3000), (4000), (4500);
DELETE FROM fk;
UPDATE pk SET a = 2 WHERE a = 1;
DELETE FROM pk WHERE a = 2;
UPDATE pk SET a = 1002 WHERE a = 1000;
DELETE FROM pk WHERE a = 1002;
UPDATE pk SET a = 2002 WHERE a = 2000;
DELETE FROM pk WHERE a = 2002;
UPDATE pk SET a = 3002 WHERE a = 3000;
DELETE FROM pk WHERE a = 3002;
UPDATE pk SET a = 4002 WHERE a = 4000;
DELETE FROM pk WHERE a = 4002;
UPDATE pk SET a = 4502 WHERE a = 4500;
DELETE FROM pk WHERE a = 4502;
CREATE SCHEMA fkpart4;
SET search_path TO fkpart4;
CREATE TABLE droppk (a int PRIMARY KEY) PARTITION BY RANGE (a);
CREATE TABLE droppk1 PARTITION OF droppk FOR VALUES FROM (0) TO (1000);
CREATE TABLE droppk_d PARTITION OF droppk DEFAULT;
CREATE TABLE droppk2 PARTITION OF droppk FOR VALUES FROM (1000) TO (2000)
  PARTITION BY RANGE (a);
CREATE TABLE droppk21 PARTITION OF droppk2 FOR VALUES FROM (1000) TO (1400);
CREATE TABLE droppk2_d PARTITION OF droppk2 DEFAULT;
INSERT into droppk VALUES (1), (1000), (1500), (2000);
CREATE TABLE dropfk (a int REFERENCES droppk);
INSERT into dropfk VALUES (1), (1000), (1500), (2000);
DELETE FROM dropfk;
ALTER TABLE droppk2 DETACH PARTITION droppk21;
CREATE SCHEMA fkpart5;
SET search_path TO fkpart5;
CREATE TABLE pk (a int PRIMARY KEY) PARTITION BY LIST (a);
CREATE TABLE pk1 PARTITION OF pk FOR VALUES IN (1) PARTITION BY LIST (a);
CREATE TABLE pk11 PARTITION OF pk1 FOR VALUES IN (1);
CREATE TABLE fk (a int) PARTITION BY LIST (a);
CREATE TABLE fk1 PARTITION OF fk FOR VALUES IN (1) PARTITION BY LIST (a);
CREATE TABLE fk11 PARTITION OF fk1 FOR VALUES IN (1);
ALTER TABLE fk ADD FOREIGN KEY (a) REFERENCES pk;
CREATE TABLE pk2 PARTITION OF pk FOR VALUES IN (2);
CREATE TABLE pk3 (a int NOT NULL) PARTITION BY LIST (a);
CREATE TABLE pk31 PARTITION OF pk3 FOR VALUES IN (31);
CREATE TABLE pk32 (b int, a int NOT NULL);
ALTER TABLE pk32 DROP COLUMN b;
ALTER TABLE pk3 ATTACH PARTITION pk32 FOR VALUES IN (32);
ALTER TABLE pk ATTACH PARTITION pk3 FOR VALUES IN (31, 32);
CREATE TABLE fk2 PARTITION OF fk FOR VALUES IN (2);
CREATE TABLE fk3 (b int, a int);
ALTER TABLE fk3 DROP COLUMN b;
ALTER TABLE fk ATTACH PARTITION fk3 FOR VALUES IN (3);
SELECT pg_describe_object('pg_constraint'::regclass, oid, 0), confrelid::regclass,
       CASE WHEN conparentid <> 0 THEN pg_describe_object('pg_constraint'::regclass, conparentid, 0) ELSE 'TOP' END
FROM pg_catalog.pg_constraint
WHERE conrelid IN (SELECT relid FROM pg_partition_tree('fk'))
ORDER BY conrelid::regclass::text, conname;
CREATE TABLE fk4 (LIKE fk);
INSERT INTO fk4 VALUES (50);
CREATE SCHEMA fkpart9;
SET search_path TO fkpart9;
CREATE TABLE pk (a int PRIMARY KEY) PARTITION BY LIST (a);
CREATE TABLE pk1 PARTITION OF pk FOR VALUES IN (1, 2) PARTITION BY LIST (a);
CREATE TABLE pk11 PARTITION OF pk1 FOR VALUES IN (1);
CREATE TABLE pk3 PARTITION OF pk FOR VALUES IN (3);
CREATE TABLE fk (a int REFERENCES pk DEFERRABLE INITIALLY IMMEDIATE);
BEGIN;
SET CONSTRAINTS fk_a_fkey DEFERRED;
INSERT INTO fk VALUES (1);
BEGIN;
SET CONSTRAINTS fk_a_fkey DEFERRED;
INSERT INTO fk VALUES (1);
INSERT INTO pk VALUES (1);
COMMIT;
BEGIN;
SET CONSTRAINTS fk_a_fkey DEFERRED;
DELETE FROM pk WHERE a = 1;
DELETE FROM fk WHERE a = 1;
COMMIT;
CREATE TABLE pt(f1 int, f2 int, f3 int, PRIMARY KEY(f1,f2));
CREATE TABLE ref(f1 int, f2 int, f3 int)
  PARTITION BY list(f1);
CREATE TABLE ref1 PARTITION OF ref FOR VALUES IN (1);
CREATE TABLE ref2 PARTITION OF ref FOR VALUES in (2);
ALTER TABLE ref ADD FOREIGN KEY(f1,f2) REFERENCES pt;
ALTER TABLE ref ALTER CONSTRAINT ref_f1_f2_fkey
  DEFERRABLE INITIALLY DEFERRED;
INSERT INTO pt VALUES(1,2,3);
INSERT INTO ref VALUES(1,2,3);
BEGIN;
DELETE FROM pt;
DELETE FROM ref;
ABORT;
DROP TABLE pt, ref;
CREATE TABLE pt(f1 int, f2 int, f3 int, PRIMARY KEY(f1,f2));
CREATE TABLE ref(f1 int, f2 int, f3 int)
  PARTITION BY list(f1);
CREATE TABLE ref1_2 PARTITION OF ref FOR VALUES IN (1, 2) PARTITION BY list (f2);
CREATE TABLE ref1 PARTITION OF ref1_2 FOR VALUES IN (1);
CREATE TABLE ref2 PARTITION OF ref1_2 FOR VALUES IN (2) PARTITION BY list (f2);
CREATE TABLE ref22 PARTITION OF ref2 FOR VALUES IN (2);
ALTER TABLE ref ADD FOREIGN KEY(f1,f2) REFERENCES pt;
INSERT INTO pt VALUES(1,2,3);
INSERT INTO ref VALUES(1,2,3);
ALTER TABLE ref ALTER CONSTRAINT ref_f1_f2_fkey
  DEFERRABLE INITIALLY DEFERRED;
BEGIN;
DELETE FROM pt;
DELETE FROM ref;
ABORT;
DROP TABLE pt, ref;
CREATE TABLE pt(f1 int, f2 int, f3 int, PRIMARY KEY(f1,f2))
  PARTITION BY LIST(f1);
CREATE TABLE pt1 PARTITION OF pt FOR VALUES IN (1);
CREATE TABLE pt2 PARTITION OF pt FOR VALUES IN (2);
CREATE TABLE ref(f1 int, f2 int, f3 int);
ALTER TABLE ref ADD FOREIGN KEY(f1,f2) REFERENCES pt;
ALTER TABLE ref ALTER CONSTRAINT ref_f1_f2_fkey
  DEFERRABLE INITIALLY DEFERRED;
INSERT INTO pt VALUES(1,2,3);
INSERT INTO ref VALUES(1,2,3);
BEGIN;
DELETE FROM pt;
DELETE FROM ref;
ABORT;
DROP TABLE pt, ref;
CREATE TABLE pt(f1 int, f2 int, f3 int, PRIMARY KEY(f1,f2))
  PARTITION BY LIST(f1);
CREATE TABLE pt1_2 PARTITION OF pt FOR VALUES IN (1, 2) PARTITION BY LIST (f1);
CREATE TABLE pt1 PARTITION OF pt1_2 FOR VALUES IN (1);
CREATE TABLE pt2 PARTITION OF pt1_2 FOR VALUES IN (2);
CREATE TABLE ref(f1 int, f2 int, f3 int);
ALTER TABLE ref ADD FOREIGN KEY(f1,f2) REFERENCES pt;
ALTER TABLE ref ALTER CONSTRAINT ref_f1_f2_fkey
  DEFERRABLE INITIALLY DEFERRED;
INSERT INTO pt VALUES(1,2,3);
INSERT INTO ref VALUES(1,2,3);
BEGIN;
DELETE FROM pt;
DELETE FROM ref;
ABORT;
DROP TABLE pt, ref;
DROP SCHEMA fkpart9 CASCADE;
CREATE SCHEMA fkpart6;
SET search_path TO fkpart6;
CREATE TABLE pk (a int PRIMARY KEY) PARTITION BY RANGE (a);
CREATE TABLE pk1 PARTITION OF pk FOR VALUES FROM (1) TO (100) PARTITION BY RANGE (a);
CREATE TABLE pk11 PARTITION OF pk1 FOR VALUES FROM (1) TO (50);
CREATE TABLE pk12 PARTITION OF pk1 FOR VALUES FROM (50) TO (100);
CREATE TABLE fk (a int) PARTITION BY RANGE (a);
CREATE TABLE fk1 PARTITION OF fk FOR VALUES FROM (1) TO (100) PARTITION BY RANGE (a);
CREATE TABLE fk11 PARTITION OF fk1 FOR VALUES FROM (1) TO (10);
CREATE TABLE fk12 PARTITION OF fk1 FOR VALUES FROM (10) TO (100);
ALTER TABLE fk ADD FOREIGN KEY (a) REFERENCES pk ON UPDATE CASCADE ON DELETE CASCADE;
CREATE TABLE fk_d PARTITION OF fk DEFAULT;
INSERT INTO pk VALUES (1);
INSERT INTO fk VALUES (1);
UPDATE pk SET a = 20;
SELECT tableoid::regclass, * FROM fk;
DELETE FROM pk WHERE a = 20;
SELECT tableoid::regclass, * FROM fk;
DROP TABLE fk;
TRUNCATE TABLE pk;
INSERT INTO pk VALUES (20), (50);
CREATE TABLE fk (a int) PARTITION BY RANGE (a);
CREATE TABLE fk1 PARTITION OF fk FOR VALUES FROM (1) TO (100) PARTITION BY RANGE (a);
CREATE TABLE fk11 PARTITION OF fk1 FOR VALUES FROM (1) TO (10);
CREATE TABLE fk12 PARTITION OF fk1 FOR VALUES FROM (10) TO (100);
ALTER TABLE fk ADD FOREIGN KEY (a) REFERENCES pk ON UPDATE SET NULL ON DELETE SET NULL;
CREATE TABLE fk_d PARTITION OF fk DEFAULT;
INSERT INTO fk VALUES (20), (50);
UPDATE pk SET a = 21 WHERE a = 20;
DELETE FROM pk WHERE a = 50;
SELECT tableoid::regclass, * FROM fk;
DROP TABLE fk;
TRUNCATE TABLE pk;
INSERT INTO pk VALUES (20), (30), (50);
CREATE TABLE fk (id int, a int DEFAULT 50) PARTITION BY RANGE (a);
CREATE TABLE fk1 PARTITION OF fk FOR VALUES FROM (1) TO (100) PARTITION BY RANGE (a);
CREATE TABLE fk11 PARTITION OF fk1 FOR VALUES FROM (1) TO (10);
CREATE TABLE fk12 PARTITION OF fk1 FOR VALUES FROM (10) TO (100);
ALTER TABLE fk ADD FOREIGN KEY (a) REFERENCES pk ON UPDATE SET DEFAULT ON DELETE SET DEFAULT;
CREATE TABLE fk_d PARTITION OF fk DEFAULT;
INSERT INTO fk VALUES (1, 20), (2, 30);
DELETE FROM pk WHERE a = 20 RETURNING *;
UPDATE pk SET a = 90 WHERE a = 30 RETURNING *;
SELECT tableoid::regclass, * FROM fk;
DROP TABLE fk;
TRUNCATE TABLE pk;
INSERT INTO pk VALUES (20), (30);
CREATE TABLE fk (a int DEFAULT 50) PARTITION BY RANGE (a);
CREATE TABLE fk1 PARTITION OF fk FOR VALUES FROM (1) TO (100) PARTITION BY RANGE (a);
CREATE TABLE fk11 PARTITION OF fk1 FOR VALUES FROM (1) TO (10);
CREATE TABLE fk12 PARTITION OF fk1 FOR VALUES FROM (10) TO (100);
ALTER TABLE fk ADD FOREIGN KEY (a) REFERENCES pk ON UPDATE RESTRICT ON DELETE RESTRICT;
CREATE TABLE fk_d PARTITION OF fk DEFAULT;
INSERT INTO fk VALUES (20), (30);
SELECT tableoid::regclass, * FROM fk;
DROP TABLE fk;
CREATE SCHEMA fkpart7
  CREATE TABLE pkpart (a int) PARTITION BY LIST (a)
  CREATE TABLE pkpart1 PARTITION OF pkpart FOR VALUES IN (1);
ALTER TABLE fkpart7.pkpart1 ADD PRIMARY KEY (a);
ALTER TABLE fkpart7.pkpart ADD PRIMARY KEY (a);
CREATE TABLE fkpart7.fk (a int REFERENCES fkpart7.pkpart);
DROP SCHEMA fkpart7 CASCADE;
CREATE SCHEMA fkpart8
  CREATE TABLE tbl1(f1 int PRIMARY KEY)
  CREATE TABLE tbl2(f1 int REFERENCES tbl1 DEFERRABLE INITIALLY DEFERRED) PARTITION BY RANGE(f1)
  CREATE TABLE tbl2_p1 PARTITION OF tbl2 FOR VALUES FROM (minvalue) TO (maxvalue);
INSERT INTO fkpart8.tbl1 VALUES(1);
BEGIN;
INSERT INTO fkpart8.tbl2 VALUES(1);
COMMIT;
DROP SCHEMA fkpart8 CASCADE;
CREATE SCHEMA fkpart9
  CREATE TABLE pk (a INT PRIMARY KEY) PARTITION BY RANGE (a)
  CREATE TABLE fk (
    fk_a INT REFERENCES pk(a) ON DELETE CASCADE
  )
  CREATE TABLE pk1 PARTITION OF pk FOR VALUES FROM (30) TO (50) PARTITION BY RANGE (a)
  CREATE TABLE pk11 PARTITION OF pk1 FOR VALUES FROM (30) TO (40);
INSERT INTO fkpart9.pk VALUES (35);
INSERT INTO fkpart9.fk VALUES (35);
DELETE FROM fkpart9.pk WHERE a=35;
SELECT * FROM fkpart9.pk;
SELECT * FROM fkpart9.fk;
DROP SCHEMA fkpart9 CASCADE;
CREATE SCHEMA fkpart10
  CREATE TABLE tbl1(f1 int PRIMARY KEY) PARTITION BY RANGE(f1)
  CREATE TABLE tbl1_p1 PARTITION OF tbl1 FOR VALUES FROM (minvalue) TO (1)
  CREATE TABLE tbl1_p2 PARTITION OF tbl1 FOR VALUES FROM (1) TO (maxvalue)
  CREATE TABLE tbl2(f1 int REFERENCES tbl1 DEFERRABLE INITIALLY DEFERRED)
  CREATE TABLE tbl3(f1 int PRIMARY KEY) PARTITION BY RANGE(f1)
  CREATE TABLE tbl3_p1 PARTITION OF tbl3 FOR VALUES FROM (minvalue) TO (1)
  CREATE TABLE tbl3_p2 PARTITION OF tbl3 FOR VALUES FROM (1) TO (maxvalue)
  CREATE TABLE tbl4(f1 int REFERENCES tbl3 DEFERRABLE INITIALLY DEFERRED);
INSERT INTO fkpart10.tbl1 VALUES (0), (1);
INSERT INTO fkpart10.tbl2 VALUES (0), (1);
INSERT INTO fkpart10.tbl3 VALUES (-2), (-1), (0);
INSERT INTO fkpart10.tbl4 VALUES (-2), (-1);
BEGIN;
DELETE FROM fkpart10.tbl1 WHERE f1 = 0;
UPDATE fkpart10.tbl1 SET f1 = 2 WHERE f1 = 1;
INSERT INTO fkpart10.tbl1 VALUES (0), (1);
COMMIT;
BEGIN;
UPDATE fkpart10.tbl1 SET f1 = 3 WHERE f1 = 0;
UPDATE fkpart10.tbl3 SET f1 = f1 * -1;
INSERT INTO fkpart10.tbl1 VALUES (4);
BEGIN;
UPDATE fkpart10.tbl3 SET f1 = f1 * -1;
UPDATE fkpart10.tbl3 SET f1 = f1 + 3;
UPDATE fkpart10.tbl1 SET f1 = 3 WHERE f1 = 0;
INSERT INTO fkpart10.tbl1 VALUES (0);
BEGIN;
UPDATE fkpart10.tbl3 SET f1 = f1 * -1;
COMMIT;
CREATE TABLE fkpart10.tbl5(f1 int REFERENCES fkpart10.tbl3);
INSERT INTO fkpart10.tbl5 VALUES (-2), (-1);
BEGIN;
COMMIT;
DELETE FROM fkpart10.tbl5;
BEGIN;
UPDATE fkpart10.tbl3 SET f1 = f1 * -3;
