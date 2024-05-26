SELECT trigger_name, event_manipulation, event_object_schema, event_object_table,
       action_order, action_condition, action_orientation, action_timing,
       action_reference_old_table, action_reference_new_table
  FROM information_schema.triggers
  WHERE event_object_table in ('pkeys', 'fkeys', 'fkeys2')
  ORDER BY trigger_name COLLATE "C", 2;
DROP TABLE pkeys;
DROP TABLE fkeys;
DROP TABLE fkeys2;
create table trigtest (f1 int, f2 text);
insert into trigtest values(1, 'foo');
select * from trigtest;
update trigtest set f2 = f2 || 'bar';
select * from trigtest;
delete from trigtest;
select * from trigtest;
insert into trigtest values(1, 'foo');
select * from trigtest;
update trigtest set f2 = f2 || 'bar';
select * from trigtest;
delete from trigtest;
select * from trigtest;
insert into trigtest values(1, 'foo');
select * from trigtest;
update trigtest set f2 = f2 || 'bar';
select * from trigtest;
delete from trigtest;
select * from trigtest;
insert into trigtest values(1, 'foo');
select * from trigtest;
update trigtest set f2 = f2 || 'bar';
select * from trigtest;
delete from trigtest;
select * from trigtest;
drop table trigtest;
create table trigtest (
  a integer,
  b bool default true not null,
  c text default 'xyzzy' not null);
insert into trigtest values(1);
select * from trigtest;
alter table trigtest add column d integer default 42 not null;
select * from trigtest;
update trigtest set a = 2 where a = 1 returning *;
select * from trigtest;
alter table trigtest drop column b;
select * from trigtest;
update trigtest set a = 2 where a = 1 returning *;
select * from trigtest;
drop table trigtest;
create sequence ttdummy_seq increment 10 start 0 minvalue 0;
create table tttest (
	price_id	int4,
	price_val	int4,
	price_on	int4,
	price_off	int4 default 999999
);
insert into tttest values (1, 1, null);
insert into tttest values (2, 2, null);
insert into tttest values (3, 3, 0);
select * from tttest;
delete from tttest where price_id = 2;
select * from tttest;
select * from tttest where price_off = 999999;
update tttest set price_val = 30 where price_id = 3;
select * from tttest;
update tttest set price_id = 5 where price_id = 3;
select * from tttest;
delete from tttest where price_id = 5;
update tttest set price_off = 999999 where price_val = 30;
select * from tttest;
update tttest set price_id = 5 where price_id = 3;
select * from tttest;
update tttest set price_on = -1 where price_id = 1;
update tttest set price_on = -1 where price_id = 1;
select * from tttest;
select * from tttest where price_on <= 35 and price_off > 35 and price_id = 5;
drop table tttest;
drop sequence ttdummy_seq;
CREATE TABLE log_table (tstamp timestamp default timeofday()::timestamp);
CREATE TABLE main_table (a int unique, b int);
END;
INSERT INTO main_table (a, b) VALUES (5, 10) ON CONFLICT (a)
  DO UPDATE SET b = EXCLUDED.b;
INSERT INTO main_table DEFAULT VALUES;
UPDATE main_table SET a = a + 1 WHERE b < 30;
UPDATE main_table SET a = a + 2 WHERE b > 100;
ALTER TABLE main_table DROP CONSTRAINT main_table_a_key;
SELECT trigger_name, event_manipulation, event_object_schema, event_object_table,
       action_order, action_condition, action_orientation, action_timing,
       action_reference_old_table, action_reference_new_table
  FROM information_schema.triggers
  WHERE event_object_table IN ('main_table')
  ORDER BY trigger_name COLLATE "C", 2;
INSERT INTO main_table (a) VALUES (123), (456);
UPDATE main_table SET a = 50, b = 60;
SELECT * FROM main_table ORDER BY a, b;
SELECT pg_get_triggerdef(oid, true) FROM pg_trigger WHERE tgrelid = 'main_table'::regclass AND tgname = 'modified_a';
SELECT count(*) FROM pg_trigger WHERE tgrelid = 'main_table'::regclass AND tgname = 'modified_a';
create table table_with_oids(a int);
insert into table_with_oids values (1);
update table_with_oids set a = a + 1;
drop table table_with_oids;
UPDATE main_table SET a = 50;
UPDATE main_table SET b = 10;
CREATE TABLE some_t (some_col boolean NOT NULL);
END;
INSERT INTO some_t VALUES (TRUE);
UPDATE some_t SET some_col = TRUE;
UPDATE some_t SET some_col = FALSE;
UPDATE some_t SET some_col = TRUE;
DROP TABLE some_t;
ALTER TABLE main_table DROP COLUMN b;
begin;
rollback;
create table trigtest (i serial primary key);
create table trigtest2 (i int references trigtest(i) on delete cascade);
end;
insert into trigtest default values;
insert into trigtest default values;
alter table trigtest disable trigger user;
insert into trigtest default values;
insert into trigtest default values;
insert into trigtest default values;
insert into trigtest default values;
insert into trigtest2 values(1);
insert into trigtest2 values(2);
delete from trigtest where i=2;
select * from trigtest2;
delete from trigtest where i=1;
select * from trigtest2;
insert into trigtest default values;
select *  from trigtest;
drop table trigtest2;
drop table trigtest;
CREATE TABLE trigger_test (
        i int,
        v varchar
);
end;
insert into trigger_test values(1,'insert');
update trigger_test set v = 'update' where i = 1;
delete from trigger_test;
DROP TABLE trigger_test;
CREATE TABLE trigger_test (f1 int, f2 text, f3 text);
INSERT INTO trigger_test VALUES(1, 'foo', 'bar');
INSERT INTO trigger_test VALUES(2, 'baz', 'quux');
UPDATE trigger_test SET f3 = 'bar';
UPDATE trigger_test SET f3 = NULL;
UPDATE trigger_test SET f3 = NULL;
UPDATE trigger_test SET f3 = 'bar';
UPDATE trigger_test SET f3 = NULL;
UPDATE trigger_test SET f3 = NULL;
DROP TABLE trigger_test;
end;
CREATE TABLE serializable_update_tab (
	id int,
	filler  text,
	description text
);
INSERT INTO serializable_update_tab SELECT a, repeat('xyzxz', 100), 'new'
	FROM generate_series(1, 50) a;
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
UPDATE serializable_update_tab SET description = 'no no', id = 1 WHERE id = 1;
COMMIT;
SELECT description FROM serializable_update_tab WHERE id = 1;
DROP TABLE serializable_update_tab;
CREATE TABLE min_updates_test (
	f1	text,
	f2 int,
	f3 int);
INSERT INTO min_updates_test VALUES ('a',1,2),('b','2',null);
CREATE TRIGGER z_min_update
BEFORE UPDATE ON min_updates_test
FOR EACH ROW EXECUTE PROCEDURE suppress_redundant_updates_trigger();
UPDATE min_updates_test SET f1 = f1;
UPDATE min_updates_test SET f2 = f2 + 1;
UPDATE min_updates_test SET f3 = 2 WHERE f3 is null;
SELECT * FROM min_updates_test;
DROP TABLE min_updates_test;
end;
CREATE TABLE country_table (
    country_id        serial primary key,
    country_name    text unique not null,
    continent        text not null
);
INSERT INTO country_table (country_name, continent)
    VALUES ('Japan', 'Asia'),
           ('UK', 'Europe'),
           ('USA', 'North America')
    RETURNING *;
CREATE TABLE city_table (
    city_id        serial primary key,
    city_name    text not null,
    population    bigint,
    country_id    int references country_table
);
CREATE VIEW city_view AS
    SELECT city_id, city_name, population, country_name, continent
    FROM city_table ci
    LEFT JOIN country_table co ON co.country_id = ci.country_id;
end;
end;
end;
CREATE VIEW european_city_view AS
    SELECT * FROM city_view WHERE continent = 'Europe';
CREATE RULE european_city_insert_rule AS ON INSERT TO european_city_view
DO INSTEAD INSERT INTO city_view
VALUES (NEW.city_id, NEW.city_name, NEW.population, NEW.country_name, NEW.continent)
RETURNING *;
CREATE RULE european_city_update_rule AS ON UPDATE TO european_city_view
DO INSTEAD UPDATE city_view SET
    city_name = NEW.city_name,
    population = NEW.population,
    country_name = NEW.country_name
WHERE city_id = OLD.city_id
RETURNING NEW.*;
CREATE RULE european_city_delete_rule AS ON DELETE TO european_city_view
DO INSTEAD DELETE FROM city_view WHERE city_id = OLD.city_id RETURNING *;
SELECT * FROM city_view;
DROP TABLE city_table CASCADE;
DROP TABLE country_table;
create table depth_a (id int not null primary key);
create table depth_b (id int not null primary key);
create table depth_c (id int not null primary key);
end;
end;
end;
end;
select pg_trigger_depth();
insert into depth_a values (1);
insert into depth_a values (2);
drop table depth_a, depth_b, depth_c;
create temp table parent (
    aid int not null primary key,
    val1 text,
    val2 text,
    val3 text,
    val4 text,
    bcnt int not null default 0);
create temp table child (
    bid int not null primary key,
    aid int not null,
    val1 text);
end;
end;
end;
end;
insert into parent values (1, 'a', 'a', 'a', 'a', 0);
insert into child values (10, 1, 'b');
select * from parent;
select * from child;
update parent set val1 = 'b' where aid = 1;
merge into parent p using (values (1)) as v(id) on p.aid = v.id
  when matched then update set val1 = 'b';
select * from parent;
select * from child;
delete from parent where aid = 1;
merge into parent p using (values (1)) as v(id) on p.aid = v.id
  when matched then delete;
select * from parent;
select * from child;
end;
delete from parent where aid = 1;
select * from parent;
select * from child;
drop table parent, child;
create temp table self_ref_trigger (
    id int primary key,
    parent int references self_ref_trigger,
    data text,
    nchildren int not null default 0
);
end;
end;
insert into self_ref_trigger values (1, null, 'root');
insert into self_ref_trigger values (2, 1, 'root child A');
insert into self_ref_trigger values (3, 1, 'root child B');
insert into self_ref_trigger values (4, 2, 'grandchild 1');
insert into self_ref_trigger values (5, 3, 'grandchild 2');
update self_ref_trigger set data = 'root!' where id = 1;
select * from self_ref_trigger;
delete from self_ref_trigger;
select * from self_ref_trigger;
drop table self_ref_trigger;
create table stmt_trig_on_empty_upd (a int);
create table stmt_trig_on_empty_upd1 () inherits (stmt_trig_on_empty_upd);
end;
update stmt_trig_on_empty_upd set a = a where false returning a+1 as aa;
update stmt_trig_on_empty_upd1 set a = a where false returning a+1 as aa;
drop table stmt_trig_on_empty_upd cascade;
create table trigger_ddl_table (
   col1 integer,
   col2 integer
);
insert into trigger_ddl_table values (1, 42);
insert into trigger_ddl_table values (1, 42);
drop table trigger_ddl_table;
create table upsert (key int4 primary key, color text);
end;
end;
insert into upsert values(1, 'black') on conflict (key) do update set color = 'updated ' || upsert.color;
insert into upsert values(2, 'red') on conflict (key) do update set color = 'updated ' || upsert.color;
insert into upsert values(3, 'orange') on conflict (key) do update set color = 'updated ' || upsert.color;
insert into upsert values(4, 'green') on conflict (key) do update set color = 'updated ' || upsert.color;
insert into upsert values(5, 'purple') on conflict (key) do update set color = 'updated ' || upsert.color;
insert into upsert values(6, 'white') on conflict (key) do update set color = 'updated ' || upsert.color;
insert into upsert values(7, 'pink') on conflict (key) do update set color = 'updated ' || upsert.color;
insert into upsert values(8, 'yellow') on conflict (key) do update set color = 'updated ' || upsert.color;
select * from upsert;
drop table upsert;
create table my_table (i int);
create view my_view as select * from my_table;
drop view my_view;
drop table my_table;
create table parted_trig (a int) partition by list (a);
drop table parted_trig;
create table trigpart (a int, b int) partition by range (a);
create table trigpart1 partition of trigpart for values from (0) to (1000);
create table trigpart2 partition of trigpart for values from (1000) to (2000);
create table trigpart3 (like trigpart);
alter table trigpart attach partition trigpart3 for values from (2000) to (3000);
create table trigpart4 partition of trigpart for values from (3000) to (4000) partition by range (a);
create table trigpart41 partition of trigpart4 for values from (3000) to (3500);
create table trigpart42 (like trigpart);
alter table trigpart4 attach partition trigpart42 for values from (3500) to (4000);
select tgrelid::regclass, tgname, tgfoid::regproc from pg_trigger
  where tgrelid::regclass::text like 'trigpart%' order by tgrelid::regclass::text;
drop table trigpart2;
select tgrelid::regclass, tgname, tgfoid::regproc from pg_trigger
  where tgrelid::regclass::text like 'trigpart%' order by tgrelid::regclass::text;
select tgrelid::regclass, tgname, tgfoid::regproc from pg_trigger
  where tgrelid::regclass::text like 'trigpart%' order by tgrelid::regclass::text;
alter table trigpart detach partition trigpart3;
alter table trigpart detach partition trigpart4;
drop table trigpart4;
alter table trigpart attach partition trigpart3 for values from (2000) to (3000);
alter table trigpart detach partition trigpart3;
alter table trigpart attach partition trigpart3 for values from (2000) to (3000);
drop table trigpart3;
select tgrelid::regclass::text, tgname, tgfoid::regproc, tgenabled, tgisinternal from pg_trigger
  where tgname ~ '^trg1' order by 1;
create table trigpart3 (like trigpart);
alter table trigpart attach partition trigpart3 FOR VALUES FROM (2000) to (3000);
drop table trigpart3;
drop table trigpart;
create table parted_stmt_trig (a int) partition by list (a);
create table parted_stmt_trig1 partition of parted_stmt_trig for values in (1);
create table parted_stmt_trig2 partition of parted_stmt_trig for values in (2);
create table parted2_stmt_trig (a int) partition by list (a);
create table parted2_stmt_trig1 partition of parted2_stmt_trig for values in (1);
create table parted2_stmt_trig2 partition of parted2_stmt_trig for values in (2);
end;
with ins (a) as (
  insert into parted2_stmt_trig values (1), (2) returning a
) insert into parted_stmt_trig select a from ins returning tableoid::regclass, a;
with upd as (
  update parted2_stmt_trig set a = a
) update parted_stmt_trig  set a = a;
delete from parted_stmt_trig;
insert into parted_stmt_trig values (1);
insert into parted_stmt_trig values (1);
drop table parted_stmt_trig, parted2_stmt_trig;
create table parted_trig (a int) partition by range (a);
create table parted_trig_1 partition of parted_trig for values from (0) to (1000)
   partition by range (a);
create table parted_trig_1_1 partition of parted_trig_1 for values from (0) to (100);
create table parted_trig_2 partition of parted_trig for values from (1000) to (2000);
insert into parted_trig values (50), (1500);
drop table parted_trig;
create table parted_trig (a int) partition by list (a);
create table parted_trig1 partition of parted_trig for values in (1);
create table parted_trig2 partition of parted_trig for values in (2);
insert into parted_trig values (1);
end;
update parted_trig set a = 2 where a = 1;
merge into parted_trig using (select 1) as ss on true
  when matched and a = 2 then update set a = 1;
drop table parted_trig;
create table parted_trig (a int) partition by list (a);
create table parted_trig1 partition of parted_trig for values in (1);
end;
create table parted_trig2 partition of parted_trig for values in (2);
create table parted_trig3 (like parted_trig);
alter table parted_trig attach partition parted_trig3 for values in (3);
insert into parted_trig values (1), (2), (3);
drop table parted_trig;
end;
end;
create table parted_irreg_ancestor (fd text, b text, fd2 int, fd3 int, a int)
  partition by range (b);
alter table parted_irreg_ancestor drop column fd,
  drop column fd2, drop column fd3;
create table parted_irreg (fd int, a int, fd2 int, b text)
  partition by range (b);
alter table parted_irreg drop column fd, drop column fd2;
alter table parted_irreg_ancestor attach partition parted_irreg
  for values from ('aaaa') to ('zzzz');
create table parted1_irreg (b text, fd int, a int);
alter table parted1_irreg drop column fd;
alter table parted_irreg attach partition parted1_irreg
  for values from ('aaaa') to ('bbbb');
insert into parted_irreg values (1, 'aardvark'), (2, 'aanimals');
insert into parted1_irreg values ('aardwolf', 2);
insert into parted_irreg_ancestor values ('aasvogel', 3);
drop table parted_irreg_ancestor;
create table parted (a int, b int, c text) partition by list (a);
create table parted_1 partition of parted for values in (1)
  partition by list (b);
create table parted_1_1 partition of parted_1 for values in (1);
end;
insert into parted values (1, 1, 'uno uno v1');
insert into parted values (1, 1, 'uno uno v2');
update parted set c = c || 'v3';
end;
insert into parted values (1, 1, 'uno uno v4');
update parted set c = c || 'v5';
end;
insert into parted values (1, 1, 'uno uno');
update parted set c = c || ' v6';
select tableoid::regclass, * from parted;
truncate table parted;
create table parted_2 partition of parted for values in (2);
insert into parted values (1, 1, 'uno uno v5');
update parted set a = 2;
select tableoid::regclass, * from parted;
end;
truncate table parted;
insert into parted values (1, 1, 'uno uno v6');
create table parted_3 partition of parted for values in (3);
update parted set a = a + 1;
select tableoid::regclass, * from parted;
select tableoid::regclass, * from parted;
drop table parted;
create table parted (a int, b int, c text) partition by list ((a + b));
end;
create table parted_1 partition of parted for values in (1, 2);
create table parted_2 partition of parted for values in (3, 4);
insert into parted values (0, 1, 'zero win');
insert into parted values (1, 1, 'one fail');
insert into parted values (1, 2, 'two fail');
select * from parted;
drop table parted;
create table parted_constr_ancestor (a int, b text)
  partition by range (b);
create table parted_constr (a int, b text)
  partition by range (b);
alter table parted_constr_ancestor attach partition parted_constr
  for values from ('aaaa') to ('zzzz');
create table parted1_constr (a int, b text);
alter table parted_constr attach partition parted1_constr
  for values from ('aaaa') to ('bbbb');
begin;
insert into parted_constr values (1, 'aardvark');
insert into parted1_constr values (2, 'aardwolf');
insert into parted_constr_ancestor values (3, 'aasvogel');
commit;
begin;
commit;
drop table parted_constr_ancestor;
create table parted_trigger (a int, b text) partition by range (a);
create table parted_trigger_1 partition of parted_trigger for values from (0) to (1000);
create table parted_trigger_2 (drp int, a int, b text);
alter table parted_trigger_2 drop column drp;
alter table parted_trigger attach partition parted_trigger_2 for values from (1000) to (2000);
create table parted_trigger_3 (b text, a int) partition by range (length(b));
create table parted_trigger_3_1 partition of parted_trigger_3 for values from (1) to (3);
create table parted_trigger_3_2 partition of parted_trigger_3 for values from (3) to (5);
alter table parted_trigger attach partition parted_trigger_3 for values from (2000) to (3000);
insert into parted_trigger values
    (0, 'a'), (1, 'bbb'), (2, 'bcd'), (3, 'c'),
	(1000, 'c'), (1001, 'ddd'), (1002, 'efg'), (1003, 'f'),
	(2000, 'e'), (2001, 'fff'), (2002, 'ghi'), (2003, 'h');
update parted_trigger set a = a + 2;
drop table parted_trigger;
create table parted_referenced (a int);
create table unparted_trigger (a int, b text);
create table parted_trigger (a int, b text) partition by range (a);
create table parted_trigger_1 partition of parted_trigger for values from (0) to (1000);
create table parted_trigger_2 (drp int, a int, b text);
alter table parted_trigger_2 drop column drp;
alter table parted_trigger attach partition parted_trigger_2 for values from (1000) to (2000);
create table parted_trigger_3 (b text, a int) partition by range (length(b));
create table parted_trigger_3_1 partition of parted_trigger_3 for values from (1) to (3);
create table parted_trigger_3_2 partition of parted_trigger_3 for values from (3) to (5);
alter table parted_trigger attach partition parted_trigger_3 for values from (2000) to (3000);
select tgname, conname, t.tgrelid::regclass, t.tgconstrrelid::regclass,
  c.conrelid::regclass, c.confrelid::regclass
  from pg_trigger t join pg_constraint c on (t.tgconstraint = c.oid)
  where tgname = 'parted_trigger'
  order by t.tgrelid::regclass::text;
drop table parted_referenced, parted_trigger, unparted_trigger;
create table parted_trigger (a int, b text) partition by range (a);
create table parted_trigger_1 partition of parted_trigger for values from (0) to (1000);
create table parted_trigger_2 (drp int, a int, b text);
alter table parted_trigger_2 drop column drp;
alter table parted_trigger attach partition parted_trigger_2 for values from (1000) to (2000);
create table parted_trigger_3 (b text, a int) partition by range (length(b));
create table parted_trigger_3_1 partition of parted_trigger_3 for values from (1) to (4);
create table parted_trigger_3_2 partition of parted_trigger_3 for values from (4) to (8);
alter table parted_trigger attach partition parted_trigger_3 for values from (2000) to (3000);
insert into parted_trigger values (0, 'a'), (1000, 'c'), (2000, 'e'), (2001, 'eeee');
update parted_trigger set a = a + 2;
update parted_trigger set b = b || 'b';
drop table parted_trigger;
create table trg_clone (a int) partition by range (a);
create table trg_clone1 partition of trg_clone for values from (0) to (1000);
alter table trg_clone add constraint uniq unique (a) deferrable;
create table trg_clone2 partition of trg_clone for values from (1000) to (2000);
create table trg_clone3 partition of trg_clone for values from (2000) to (3000)
  partition by range (a);
create table trg_clone_3_3 partition of trg_clone3 for values from (2000) to (2100);
drop table trg_clone;
create table parent (a int);
create table child1 () inherits (parent);
select tgrelid::regclass, tgname, tgenabled from pg_trigger
  where tgrelid in ('parent'::regclass, 'child1'::regclass)
  order by tgrelid::regclass::text;
select tgrelid::regclass, tgname, tgenabled from pg_trigger
  where tgrelid in ('parent'::regclass, 'child1'::regclass)
  order by tgrelid::regclass::text;
drop table parent, child1;
create table parent (a int) partition by list (a);
create table child1 partition of parent for values in (1);
select tgrelid::regclass, tgname, tgenabled from pg_trigger
  where tgrelid in ('parent'::regclass, 'child1'::regclass)
  order by tgrelid::regclass::text, tgname;
select tgrelid::regclass, tgname, tgenabled from pg_trigger
  where tgrelid in ('parent'::regclass, 'child1'::regclass)
  order by tgrelid::regclass::text, tgname;
select tgrelid::regclass, tgname, tgenabled from pg_trigger
  where tgrelid in ('parent'::regclass, 'child1'::regclass)
  order by tgrelid::regclass::text, tgname;
alter table parent disable trigger user;
select tgrelid::regclass, tgname, tgenabled from pg_trigger
  where tgrelid in ('parent'::regclass, 'child1'::regclass)
  order by tgrelid::regclass::text, tgname;
drop table parent, child1;
create table parent (a int primary key, f int references parent)
  partition by list (a);
create table child1 partition of parent for values in (1);
select tgrelid::regclass, rtrim(tgname, '0123456789') as tgname,
  tgfoid::regproc, tgenabled
  from pg_trigger where tgrelid in ('parent'::regclass, 'child1'::regclass)
  order by tgrelid::regclass::text, tgfoid;
select tgrelid::regclass, rtrim(tgname, '0123456789') as tgname,
  tgfoid::regproc, tgenabled
  from pg_trigger where tgrelid in ('parent'::regclass, 'child1'::regclass)
  order by tgrelid::regclass::text, tgfoid;
drop table parent, child1;
CREATE TABLE trgfire (i int) PARTITION BY RANGE (i);
CREATE TABLE trgfire1 PARTITION OF trgfire FOR VALUES FROM (1) TO (10);
INSERT INTO trgfire VALUES (1);
INSERT INTO trgfire VALUES (1);
CREATE TABLE trgfire2 PARTITION OF trgfire FOR VALUES FROM (10) TO (20);
INSERT INTO trgfire VALUES (11);
CREATE TABLE trgfire3 (LIKE trgfire);
ALTER TABLE trgfire ATTACH PARTITION trgfire3 FOR VALUES FROM (20) TO (30);
INSERT INTO trgfire VALUES (21);
CREATE TABLE trgfire4 PARTITION OF trgfire FOR VALUES FROM (30) TO (40) PARTITION BY LIST (i);
CREATE TABLE trgfire4_30 PARTITION OF trgfire4 FOR VALUES IN (30);
INSERT INTO trgfire VALUES (30);
CREATE TABLE trgfire5 (LIKE trgfire) PARTITION BY LIST (i);
CREATE TABLE trgfire5_40 PARTITION OF trgfire5 FOR VALUES IN (40);
ALTER TABLE trgfire ATTACH PARTITION trgfire5 FOR VALUES FROM (40) TO (50);
INSERT INTO trgfire VALUES (40);
SELECT tgrelid::regclass, tgenabled FROM pg_trigger
  WHERE tgrelid::regclass IN (SELECT oid from pg_class where relname LIKE 'trgfire%')
  ORDER BY tgrelid::regclass::text;
INSERT INTO trgfire VALUES (1);
INSERT INTO trgfire VALUES (11);
INSERT INTO trgfire VALUES (21);
INSERT INTO trgfire VALUES (30);
INSERT INTO trgfire VALUES (40);
DROP TABLE trgfire;
end;
end;
end;
create table parent (a text, b int) partition by list (a);
create table child1 partition of parent for values in ('AAA');
create table child2 (x int, a text, b int);
alter table child2 drop column x;
alter table parent attach partition child2 for values in ('BBB');
create table child3 (b int, a text);
alter table parent attach partition child3 for values in ('CCC');
SELECT trigger_name, event_manipulation, event_object_schema, event_object_table,
       action_order, action_condition, action_orientation, action_timing,
       action_reference_old_table, action_reference_new_table
  FROM information_schema.triggers
  WHERE event_object_table IN ('parent', 'child1', 'child2', 'child3')
  ORDER BY trigger_name COLLATE "C", 2;
insert into child1 values ('AAA', 42);
insert into child2 values ('BBB', 42);
insert into child3 values (42, 'CCC');
update parent set b = b + 1;
delete from parent;
insert into parent values ('AAA', 42);
insert into parent values ('BBB', 42);
insert into parent values ('CCC', 42);
delete from child1;
delete from child2;
delete from child3;
delete from parent;
end;
insert into parent values ('AAA', 42), ('BBB', 42), ('CCC', 66);
insert into child1 values ('AAA', 42);
update parent set b = b + 1;
delete from parent;
insert into child1 values ('AAA', 42);
delete from child1;
delete from child2;
delete from child3;
delete from parent;
drop table child1, child2, child3, parent;
create table parent (a text, b int);
create table child () inherits (parent);
alter table child no inherit parent;
alter table child inherit parent;
drop table child, parent;
create table table1 (a int);
create table table2 (a text);
with wcte as (insert into table1 values (42))
  insert into table2 values ('hello world');
with wcte as (insert into table1 values (43))
  insert into table1 values (44);
select * from table1;
select * from table2;
drop table table1;
drop table table2;
create table my_table (a int primary key, b text);
insert into my_table values (1, 'AAA'), (2, 'BBB')
  on conflict (a) do
  update set b = my_table.b || ':' || excluded.b;
insert into my_table values (1, 'AAA'), (2, 'BBB'), (3, 'CCC'), (4, 'DDD')
  on conflict (a) do
  update set b = my_table.b || ':' || excluded.b;
insert into my_table values (3, 'CCC'), (4, 'DDD')
  on conflict (a) do
  update set b = my_table.b || ':' || excluded.b;
create table iocdu_tt_parted (a int primary key, b text) partition by list (a);
create table iocdu_tt_parted1 partition of iocdu_tt_parted for values in (1);
create table iocdu_tt_parted2 partition of iocdu_tt_parted for values in (2);
create table iocdu_tt_parted3 partition of iocdu_tt_parted for values in (3);
create table iocdu_tt_parted4 partition of iocdu_tt_parted for values in (4);
insert into iocdu_tt_parted values (1, 'AAA'), (2, 'BBB')
  on conflict (a) do
  update set b = iocdu_tt_parted.b || ':' || excluded.b;
insert into iocdu_tt_parted values (1, 'AAA'), (2, 'BBB'), (3, 'CCC'), (4, 'DDD')
  on conflict (a) do
  update set b = iocdu_tt_parted.b || ':' || excluded.b;
insert into iocdu_tt_parted values (3, 'CCC'), (4, 'DDD')
  on conflict (a) do
  update set b = iocdu_tt_parted.b || ':' || excluded.b;
drop table iocdu_tt_parted;
drop table my_table;
create table refd_table (a int primary key, b text);
create table trig_table (a int, b text,
  foreign key (a) references refd_table on update cascade on delete cascade
);
insert into refd_table values
  (1, 'one'),
  (2, 'two'),
  (3, 'three');
insert into trig_table values
  (1, 'one a'),
  (1, 'one b'),
  (2, 'two a'),
  (2, 'two b'),
  (3, 'three a'),
  (3, 'three b');
update refd_table set a = 11 where b = 'one';
select * from trig_table;
delete from refd_table where length(b) = 3;
select * from trig_table;
drop table refd_table, trig_table;
create table self_ref (a int primary key,
                       b int references self_ref(a) on delete cascade);
insert into self_ref values (1, null), (2, 1), (3, 2);
delete from self_ref where a = 1;
insert into self_ref values (1, null), (2, 1), (3, 2), (4, 3);
delete from self_ref where a = 1;
drop table self_ref;
create table merge_target_table (a int primary key, b text);
create table merge_source_table (a int, b text);
insert into merge_source_table
  values (1, 'initial1'), (2, 'initial2'),
		 (3, 'initial3'), (4, 'initial4');
merge into merge_target_table t
using merge_source_table s
on t.a = s.a
when not matched then
  insert values (a, b);
merge into merge_target_table t
using merge_source_table s
on t.a = s.a
when matched and s.a <= 2 then
	update set b = t.b || ' updated by merge'
when matched and s.a > 2 then
	delete
when not matched then
  insert values (a, b);
merge into merge_target_table t
using merge_source_table s
on t.a = s.a
when matched and s.a <= 2 then
	update set b = t.b || ' updated again by merge'
when matched and s.a > 2 then
	delete
when not matched then
  insert values (a, b);
drop table merge_source_table, merge_target_table;
create table my_table (id integer);
end;
end;
insert into my_table values (1);
insert into my_table values (2);
table my_table;
drop table my_table;
create table parted_trig (a int) partition by range (a);
create table parted_trig_1 partition of parted_trig
       for values from (0) to (1000) partition by range (a);
create table parted_trig_1_1 partition of parted_trig_1 for values from (0) to (100);
create table parted_trig_2 partition of parted_trig for values from (1000) to (2000);
create table default_parted_trig partition of parted_trig default;
insert into parted_trig (a) values (50);
insert into parted_trig (a) values (50);
insert into parted_trig (a) values (50);
insert into parted_trig (a) values (50);
insert into parted_trig (a) values (50);
insert into parted_trig (a) values (50);
insert into parted_trig (a) values (50);
insert into parted_trig (a) values (50);
drop table parted_trig;
create table trigger_parted (a int primary key) partition by list (a);
create table trigger_parted_p1 partition of trigger_parted for values in (1)
  partition by list (a);
create table trigger_parted_p1_1 partition of trigger_parted_p1 for values in (1);
create table trigger_parted_p2 partition of trigger_parted for values in (2)
  partition by list (a);
create table trigger_parted_p2_2 partition of trigger_parted_p2 for values in (2);
create table convslot_test_parent (col1 text primary key);
create table convslot_test_child (col1 text primary key,
	foreign key (col1) references convslot_test_parent(col1) on delete cascade on update cascade
);
alter table convslot_test_child add column col2 text not null default 'tutu';
insert into convslot_test_parent(col1) values ('1');
insert into convslot_test_child(col1) values ('1');
insert into convslot_test_parent(col1) values ('3');
insert into convslot_test_child(col1) values ('3');
end;
end;
update convslot_test_parent set col1 = col1 || '1';
end;
update convslot_test_parent set col1 = col1 || '1';
delete from convslot_test_parent;
drop table convslot_test_child, convslot_test_parent;
create table convslot_test_parent (id int primary key, val int)
partition by range (id);
create table convslot_test_part (val int, id int not null);
alter table convslot_test_parent
  attach partition convslot_test_part for values from (1) to (1000);
create function convslot_trig4() returns trigger as
$$begin raise exception 'BOOM!'; end$$ language plpgsql;
create trigger convslot_test_parent_update
    after update on convslot_test_parent
    referencing old table as old_rows new table as new_rows
    for each statement execute procedure convslot_trig4();
insert into convslot_test_parent (id, val) values (1, 2);
begin;
savepoint svp;
rollback to savepoint svp;
rollback;
drop table convslot_test_parent;
drop function convslot_trig4();
create table grandparent (id int, primary key (id)) partition by range (id);
create table middle partition of grandparent for values from (1) to (10)
partition by range (id);
create table chi partition of middle for values from (1) to (5);
create table cho partition of middle for values from (6) to (10);
create function f () returns trigger as
$$ begin return new; end; $$
language plpgsql;
create trigger a after insert on grandparent
for each row execute procedure f();
alter trigger a on grandparent rename to b;
select tgrelid::regclass, tgname,
(select tgname from pg_trigger tr where tr.oid = pg_trigger.tgparentid) parent_tgname
from pg_trigger where tgrelid in (select relid from pg_partition_tree('grandparent'))
order by tgname, tgrelid::regclass::text COLLATE "C";
create trigger c after insert on middle
for each row execute procedure f();
create trigger p after insert on grandparent for each statement execute function f();
create trigger p after insert on middle for each statement execute function f();
alter trigger p on grandparent rename to q;
select tgrelid::regclass, tgname,
(select tgname from pg_trigger tr where tr.oid = pg_trigger.tgparentid) parent_tgname
from pg_trigger where tgrelid in (select relid from pg_partition_tree('grandparent'))
order by tgname, tgrelid::regclass::text COLLATE "C";
drop table grandparent;
create table parent (a int);
create table child () inherits (parent);
create trigger parenttrig after insert on parent
for each row execute procedure f();
create trigger parenttrig after insert on child
for each row execute procedure f();
alter trigger parenttrig on parent rename to anothertrig;
drop table parent, child;
drop function f();
