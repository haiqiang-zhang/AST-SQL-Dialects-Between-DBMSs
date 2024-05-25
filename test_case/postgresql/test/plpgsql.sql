create unique index Room_rno on Room using btree (roomno bpchar_ops);
create table WSlot (
    slotname	char(20),
    roomno	char(8),
    slotlink	char(20),
    backlink	char(20)
);
create unique index WSlot_name on WSlot using btree (slotname bpchar_ops);
create table PField (
    name	text,
    comment	text
);
create unique index PField_name on PField using btree (name text_ops);
create table PSlot (
    slotname	char(20),
    pfname	text,
    slotlink	char(20),
    backlink	char(20)
);
create unique index PSlot_name on PSlot using btree (slotname bpchar_ops);
create table PLine (
    slotname	char(20),
    phonenumber	char(20),
    comment	text,
    backlink	char(20)
);
create unique index PLine_name on PLine using btree (slotname bpchar_ops);
create table Hub (
    name	char(14),
    comment	text,
    nslots	integer
);
create unique index Hub_name on Hub using btree (name bpchar_ops);
create table HSlot (
    slotname	char(20),
    hubname	char(14),
    slotno	integer,
    slotlink	char(20)
);
create unique index HSlot_name on HSlot using btree (slotname bpchar_ops);
create index HSlot_hubname on HSlot using btree (hubname bpchar_ops);
create table System (
    name	text,
    comment	text
);
create unique index System_name on System using btree (name text_ops);
create table IFace (
    slotname	char(20),
    sysname	text,
    ifname	text,
    slotlink	char(20)
);
create unique index IFace_name on IFace using btree (slotname bpchar_ops);
create table PHone (
    slotname	char(20),
    comment	text,
    slotlink	char(20)
);
create unique index PHone_name on PHone using btree (slotname bpchar_ops);
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
insert into Room values ('001', 'Entrance');
insert into Room values ('002', 'Office');
insert into Room values ('003', 'Office');
insert into Room values ('004', 'Technical');
insert into Room values ('101', 'Office');
insert into Room values ('102', 'Conference');
insert into Room values ('103', 'Restroom');
insert into Room values ('104', 'Technical');
insert into Room values ('105', 'Office');
insert into Room values ('106', 'Office');
insert into WSlot values ('WS.001.1a', '001', '', '');
insert into WSlot values ('WS.001.1b', '001', '', '');
insert into WSlot values ('WS.001.2a', '001', '', '');
insert into WSlot values ('WS.001.2b', '001', '', '');
insert into WSlot values ('WS.001.3a', '001', '', '');
insert into WSlot values ('WS.001.3b', '001', '', '');
insert into WSlot values ('WS.002.1a', '002', '', '');
insert into WSlot values ('WS.002.1b', '002', '', '');
insert into WSlot values ('WS.002.2a', '002', '', '');
insert into WSlot values ('WS.002.2b', '002', '', '');
insert into WSlot values ('WS.002.3a', '002', '', '');
insert into WSlot values ('WS.002.3b', '002', '', '');
insert into WSlot values ('WS.003.1a', '003', '', '');
insert into WSlot values ('WS.003.1b', '003', '', '');
insert into WSlot values ('WS.003.2a', '003', '', '');
insert into WSlot values ('WS.003.2b', '003', '', '');
insert into WSlot values ('WS.003.3a', '003', '', '');
insert into WSlot values ('WS.003.3b', '003', '', '');
insert into WSlot values ('WS.101.1a', '101', '', '');
insert into WSlot values ('WS.101.1b', '101', '', '');
insert into WSlot values ('WS.101.2a', '101', '', '');
insert into WSlot values ('WS.101.2b', '101', '', '');
insert into WSlot values ('WS.101.3a', '101', '', '');
insert into WSlot values ('WS.101.3b', '101', '', '');
insert into WSlot values ('WS.102.1a', '102', '', '');
insert into WSlot values ('WS.102.1b', '102', '', '');
insert into WSlot values ('WS.102.2a', '102', '', '');
insert into WSlot values ('WS.102.2b', '102', '', '');
insert into WSlot values ('WS.102.3a', '102', '', '');
insert into WSlot values ('WS.102.3b', '102', '', '');
insert into WSlot values ('WS.105.1a', '105', '', '');
insert into WSlot values ('WS.105.1b', '105', '', '');
insert into WSlot values ('WS.105.2a', '105', '', '');
insert into WSlot values ('WS.105.2b', '105', '', '');
insert into WSlot values ('WS.105.3a', '105', '', '');
insert into WSlot values ('WS.105.3b', '105', '', '');
insert into WSlot values ('WS.106.1a', '106', '', '');
insert into WSlot values ('WS.106.1b', '106', '', '');
insert into WSlot values ('WS.106.2a', '106', '', '');
insert into WSlot values ('WS.106.2b', '106', '', '');
insert into WSlot values ('WS.106.3a', '106', '', '');
insert into WSlot values ('WS.106.3b', '106', '', '');
insert into PField values ('PF0_1', 'Wallslots basement');
insert into PSlot values ('PS.base.a1', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a2', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a3', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a4', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a5', 'PF0_1', '', '');
insert into PSlot values ('PS.base.a6', 'PF0_1', '', '');
insert into PSlot values ('PS.base.b1', 'PF0_1', '', 'WS.002.1a');
insert into PSlot values ('PS.base.b2', 'PF0_1', '', 'WS.002.1b');
insert into PSlot values ('PS.base.b3', 'PF0_1', '', 'WS.002.2a');
insert into PSlot values ('PS.base.b4', 'PF0_1', '', 'WS.002.2b');
insert into PSlot values ('PS.base.b5', 'PF0_1', '', 'WS.002.3a');
insert into PSlot values ('PS.base.b6', 'PF0_1', '', 'WS.002.3b');
insert into PSlot values ('PS.base.c1', 'PF0_1', '', 'WS.003.1a');
insert into PSlot values ('PS.base.c2', 'PF0_1', '', 'WS.003.1b');
insert into PSlot values ('PS.base.c3', 'PF0_1', '', 'WS.003.2a');
insert into PSlot values ('PS.base.c4', 'PF0_1', '', 'WS.003.2b');
insert into PSlot values ('PS.base.c5', 'PF0_1', '', 'WS.003.3a');
insert into PSlot values ('PS.base.c6', 'PF0_1', '', 'WS.003.3b');
insert into PField values ('PF0_X', 'Phonelines basement');
insert into PSlot values ('PS.base.ta1', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta2', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta3', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta4', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta5', 'PF0_X', '', '');
insert into PSlot values ('PS.base.ta6', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb1', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb2', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb3', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb4', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb5', 'PF0_X', '', '');
insert into PSlot values ('PS.base.tb6', 'PF0_X', '', '');
insert into PField values ('PF1_1', 'Wallslots first floor');
insert into PSlot values ('PS.first.a1', 'PF1_1', '', 'WS.101.1a');
insert into PSlot values ('PS.first.a2', 'PF1_1', '', 'WS.101.1b');
insert into PSlot values ('PS.first.a3', 'PF1_1', '', 'WS.101.2a');
insert into PSlot values ('PS.first.a4', 'PF1_1', '', 'WS.101.2b');
insert into PSlot values ('PS.first.a5', 'PF1_1', '', 'WS.101.3a');
insert into PSlot values ('PS.first.a6', 'PF1_1', '', 'WS.101.3b');
insert into PSlot values ('PS.first.b1', 'PF1_1', '', 'WS.102.1a');
insert into PSlot values ('PS.first.b2', 'PF1_1', '', 'WS.102.1b');
insert into PSlot values ('PS.first.b3', 'PF1_1', '', 'WS.102.2a');
insert into PSlot values ('PS.first.b4', 'PF1_1', '', 'WS.102.2b');
insert into PSlot values ('PS.first.b5', 'PF1_1', '', 'WS.102.3a');
insert into PSlot values ('PS.first.b6', 'PF1_1', '', 'WS.102.3b');
insert into PSlot values ('PS.first.c1', 'PF1_1', '', 'WS.105.1a');
insert into PSlot values ('PS.first.c2', 'PF1_1', '', 'WS.105.1b');
insert into PSlot values ('PS.first.c3', 'PF1_1', '', 'WS.105.2a');
insert into PSlot values ('PS.first.c4', 'PF1_1', '', 'WS.105.2b');
insert into PSlot values ('PS.first.c5', 'PF1_1', '', 'WS.105.3a');
insert into PSlot values ('PS.first.c6', 'PF1_1', '', 'WS.105.3b');
insert into PSlot values ('PS.first.d1', 'PF1_1', '', 'WS.106.1a');
insert into PSlot values ('PS.first.d2', 'PF1_1', '', 'WS.106.1b');
insert into PSlot values ('PS.first.d3', 'PF1_1', '', 'WS.106.2a');
insert into PSlot values ('PS.first.d4', 'PF1_1', '', 'WS.106.2b');
insert into PSlot values ('PS.first.d5', 'PF1_1', '', 'WS.106.3a');
insert into PSlot values ('PS.first.d6', 'PF1_1', '', 'WS.106.3b');
update PSlot set backlink = 'WS.001.1a' where slotname = 'PS.base.a1';
update PSlot set backlink = 'WS.001.1b' where slotname = 'PS.base.a3';
select * from WSlot where roomno = '001' order by slotname;
select * from PSlot where slotname ~ 'PS.base.a' order by slotname;
update PSlot set backlink = 'WS.001.2a' where slotname = 'PS.base.a3';
select * from WSlot where roomno = '001' order by slotname;
select * from PSlot where slotname ~ 'PS.base.a' order by slotname;
update PSlot set backlink = 'WS.001.1b' where slotname = 'PS.base.a2';
select * from WSlot where roomno = '001' order by slotname;
select * from PSlot where slotname ~ 'PS.base.a' order by slotname;
update WSlot set backlink = 'PS.base.a4' where slotname = 'WS.001.2b';
update WSlot set backlink = 'PS.base.a6' where slotname = 'WS.001.3a';
select * from WSlot where roomno = '001' order by slotname;
select * from PSlot where slotname ~ 'PS.base.a' order by slotname;
update WSlot set backlink = 'PS.base.a6' where slotname = 'WS.001.3b';
select * from WSlot where roomno = '001' order by slotname;
select * from PSlot where slotname ~ 'PS.base.a' order by slotname;
update WSlot set backlink = 'PS.base.a5' where slotname = 'WS.001.3a';
select * from WSlot where roomno = '001' order by slotname;
select * from PSlot where slotname ~ 'PS.base.a' order by slotname;
insert into PField values ('PF1_2', 'Phonelines first floor');
insert into PSlot values ('PS.first.ta1', 'PF1_2', '', '');
insert into PSlot values ('PS.first.ta2', 'PF1_2', '', '');
insert into PSlot values ('PS.first.ta3', 'PF1_2', '', '');
insert into PSlot values ('PS.first.ta4', 'PF1_2', '', '');
insert into PSlot values ('PS.first.ta5', 'PF1_2', '', '');
insert into PSlot values ('PS.first.ta6', 'PF1_2', '', '');
insert into PSlot values ('PS.first.tb1', 'PF1_2', '', '');
insert into PSlot values ('PS.first.tb2', 'PF1_2', '', '');
insert into PSlot values ('PS.first.tb3', 'PF1_2', '', '');
insert into PSlot values ('PS.first.tb4', 'PF1_2', '', '');
insert into PSlot values ('PS.first.tb5', 'PF1_2', '', '');
insert into PSlot values ('PS.first.tb6', 'PF1_2', '', '');
update PField set name = 'PF0_2' where name = 'PF0_X';
select * from PSlot order by slotname;
select * from WSlot order by slotname;
insert into PLine values ('PL.001', '-0', 'Central call', 'PS.base.ta1');
insert into PLine values ('PL.002', '-101', '', 'PS.base.ta2');
insert into PLine values ('PL.003', '-102', '', 'PS.base.ta3');
insert into PLine values ('PL.004', '-103', '', 'PS.base.ta5');
insert into PLine values ('PL.005', '-104', '', 'PS.base.ta6');
insert into PLine values ('PL.006', '-106', '', 'PS.base.tb2');
insert into PLine values ('PL.007', '-108', '', 'PS.base.tb3');
insert into PLine values ('PL.008', '-109', '', 'PS.base.tb4');
insert into PLine values ('PL.009', '-121', '', 'PS.base.tb5');
insert into PLine values ('PL.010', '-122', '', 'PS.base.tb6');
insert into PLine values ('PL.015', '-134', '', 'PS.first.ta1');
insert into PLine values ('PL.016', '-137', '', 'PS.first.ta3');
insert into PLine values ('PL.017', '-139', '', 'PS.first.ta4');
insert into PLine values ('PL.018', '-362', '', 'PS.first.tb1');
insert into PLine values ('PL.019', '-363', '', 'PS.first.tb2');
insert into PLine values ('PL.020', '-364', '', 'PS.first.tb3');
insert into PLine values ('PL.021', '-365', '', 'PS.first.tb5');
insert into PLine values ('PL.022', '-367', '', 'PS.first.tb6');
insert into PLine values ('PL.028', '-501', 'Fax entrance', 'PS.base.ta2');
insert into PLine values ('PL.029', '-502', 'Fax first floor', 'PS.first.ta1');
insert into PHone values ('PH.hc001', 'Hicom standard', 'WS.001.1a');
update PSlot set slotlink = 'PS.base.ta1' where slotname = 'PS.base.a1';
insert into PHone values ('PH.hc002', 'Hicom standard', 'WS.002.1a');
update PSlot set slotlink = 'PS.base.ta5' where slotname = 'PS.base.b1';
insert into PHone values ('PH.hc003', 'Hicom standard', 'WS.002.2a');
update PSlot set slotlink = 'PS.base.tb2' where slotname = 'PS.base.b3';
insert into PHone values ('PH.fax001', 'Canon fax', 'WS.001.2a');
update PSlot set slotlink = 'PS.base.ta2' where slotname = 'PS.base.a3';
insert into Hub values ('base.hub1', 'Patchfield PF0_1 hub', 16);
insert into System values ('orion', 'PC');
insert into IFace values ('IF', 'orion', 'eth0', 'WS.002.1b');
update PSlot set slotlink = 'HS.base.hub1.1' where slotname = 'PS.base.b2';
update PSlot set backlink = 'WS.not.there' where slotname = 'PS.base.a1';
update PSlot set backlink = 'XX.illegal' where slotname = 'PS.base.a1';
update PSlot set slotlink = 'PS.not.there' where slotname = 'PS.base.a1';
update PSlot set slotlink = 'XX.illegal' where slotname = 'PS.base.a1';
insert into HSlot values ('HS', 'base.hub1', 1, '');
delete from HSlot;
END;
CREATE TABLE found_test_tbl (a int);
update found_test_tbl set a = 100 where a = 1;
delete from found_test_tbl where a = 9999;
end;
select * from found_test_tbl;
END;
END;
END;
END;
END;
create table perform_test (
	a	INT,
	b	INT
);
END;
END;
SELECT * FROM perform_test;
drop table perform_test;
create temp table users(login text, id serial);
insert into users values('user1');
create table rc_test (a int, b int);
begin;
commit;
end;
end;
end;
END;
END;
END;
end;
end;
end;
end;
end;
create table eifoo (i integer, y integer);
create type eitype as (i integer, y integer);
end;
drop table eifoo cascade;
drop type eitype cascade;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
create temp table foo (f1 int, f2 int);
insert into foo values (1,2), (3,4);
select * from foo;
set plpgsql.print_strict_params to true;
reset plpgsql.print_strict_params;
set plpgsql.extra_warnings to 'all';
set plpgsql.extra_warnings to 'none';
set plpgsql.extra_errors to 'all';
set plpgsql.extra_errors to 'none';
set plpgsql.extra_warnings to 'shadowed_variables';
set plpgsql.extra_warnings to 'shadowed_variables';
set plpgsql.extra_errors to 'shadowed_variables';
reset plpgsql.extra_errors;
reset plpgsql.extra_warnings;
set plpgsql.extra_warnings to 'too_many_rows';
end;
set plpgsql.extra_errors to 'too_many_rows';
end;
reset plpgsql.extra_errors;
reset plpgsql.extra_warnings;
set plpgsql.extra_warnings to 'strict_multi_assignment';
set plpgsql.extra_errors to 'strict_multi_assignment';
create table test_01(a int, b int, c int);
alter table test_01 drop column a;
insert into test_01 values(10,20);
end;
end;
end;
drop table test_01;
reset plpgsql.extra_errors;
reset plpgsql.extra_warnings;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
create type record_type as (x text, y int, z boolean);
end;
end;
end;
create temp table forc_test as
  select n as i, n as j from generate_series(1,10) n;
end;
select * from forc_test;
end;
select * from forc_test;
end;
end;
end;
create table tabwithcols(a int, b int, c int, d int);
insert into tabwithcols values(10,20,30,40),(50,60,70,80);
end;
alter table tabwithcols drop column b;
alter table tabwithcols drop column d;
alter table tabwithcols add column d int;
drop table tabwithcols;
create type compostype as (x int, y varchar);
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
drop type compostype;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
END;
END;
END;
END;
end;
end;
end;
create function error1(text) returns text language sql as
$$ SELECT relname::text FROM pg_class c WHERE c.oid = $1::regclass $$;
BEGIN;
create table public.stuffs (stuff text);
SAVEPOINT a;
ROLLBACK TO a;
rollback;
drop function error1(text);
create function sql_to_date(integer) returns date as $$
select $1::text::date
$$ language sql immutable strict;
begin;
commit;
drop function sql_to_date(integer) cascade;
begin;
end;
set standard_conforming_strings = off;
set standard_conforming_strings = on;
end;
end;
end;
end;
end;
end;
end;
end;
set plpgsql.variable_conflict = error;
end;
end;
end;
end;
end;
end;
end;
create type xy_tuple AS (x int, y int);
end;
end;
end;
drop type xy_tuple;
create temp table rtype (id int, ar text[]);
create domain orderedarray as int[2]
  constraint sorted check (value[1] < value[2]);
select '{1,2}'::orderedarray;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
end;
set plpgsql.check_asserts = off;
end;
reset plpgsql.check_asserts;
end;
end;
end;
end;
end;
end;
CREATE TABLE transition_table_base (id int PRIMARY KEY, val text);
END;
INSERT INTO transition_table_base VALUES (1, 'One'), (2, 'Two');
INSERT INTO transition_table_base VALUES (3, 'Three'), (4, 'Four');
END;
UPDATE transition_table_base
  SET val = '*' || val || '*'
  WHERE id BETWEEN 2 AND 3;
CREATE TABLE transition_table_level1
(
      level1_no serial NOT NULL ,
      level1_node_name varchar(255),
       PRIMARY KEY (level1_no)
) WITHOUT OIDS;
CREATE TABLE transition_table_level2
(
      level2_no serial NOT NULL ,
      parent_no int NOT NULL,
      level1_node_name varchar(255),
       PRIMARY KEY (level2_no)
) WITHOUT OIDS;
CREATE TABLE transition_table_status
(
      level int NOT NULL,
      node_no int NOT NULL,
      status int,
       PRIMARY KEY (level, node_no)
) WITHOUT OIDS;
END;
END;
END;
INSERT INTO transition_table_level1 (level1_no)
  SELECT generate_series(1,200);
ANALYZE transition_table_level1;
INSERT INTO transition_table_level2 (level2_no, parent_no)
  SELECT level2_no, level2_no / 50 + 1 AS parent_no
    FROM generate_series(1,9999) level2_no;
ANALYZE transition_table_level2;
INSERT INTO transition_table_status (level, node_no, status)
  SELECT 1, level1_no, 0 FROM transition_table_level1;
INSERT INTO transition_table_status (level, node_no, status)
  SELECT 2, level2_no, 0 FROM transition_table_level2;
ANALYZE transition_table_status;
INSERT INTO transition_table_level1(level1_no)
  SELECT generate_series(201,1000);
ANALYZE transition_table_level1;
END;
DELETE FROM transition_table_level2
  WHERE level2_no BETWEEN 301 AND 305;
DELETE FROM transition_table_level1
  WHERE level1_no = 25;
UPDATE transition_table_level1 SET level1_no = -1
  WHERE level1_no = 30;
INSERT INTO transition_table_level2 (level2_no, parent_no)
  VALUES (10000, 10000);
UPDATE transition_table_level2 SET parent_no = 2000
  WHERE level2_no = 40;
DELETE FROM transition_table_level1
  WHERE level1_no BETWEEN 201 AND 1000;
DELETE FROM transition_table_level1
  WHERE level1_no BETWEEN 100000000 AND 100000010;
SELECT count(*) FROM transition_table_level1;
DELETE FROM transition_table_level2
  WHERE level2_no BETWEEN 211 AND 220;
SELECT count(*) FROM transition_table_level2;
CREATE TABLE alter_table_under_transition_tables
(
  id int PRIMARY KEY,
  name text
);
END;
INSERT INTO alter_table_under_transition_tables
  VALUES (1, '1'), (2, '2'), (3, '3');
UPDATE alter_table_under_transition_tables
  SET name = name || name;
ALTER TABLE alter_table_under_transition_tables
  ALTER COLUMN name TYPE int USING name::integer;
UPDATE alter_table_under_transition_tables
  SET name = (name::text || name::text)::integer;
ALTER TABLE alter_table_under_transition_tables
  DROP column name;
UPDATE alter_table_under_transition_tables
  SET id = id;
CREATE TABLE multi_test (i int);
INSERT INTO multi_test VALUES (1);
UPDATE multi_test SET i = i;
DROP TABLE multi_test;
CREATE TABLE partitioned_table (a int, b text) PARTITION BY LIST (a);
CREATE TABLE pt_part1 PARTITION OF partitioned_table FOR VALUES IN (1);
CREATE TABLE pt_part2 PARTITION OF partitioned_table FOR VALUES IN (2);
INSERT INTO partitioned_table VALUES (1, 'Row 1');
INSERT INTO partitioned_table VALUES (2, 'Row 2');
CREATE OR REPLACE FUNCTION get_from_partitioned_table(partitioned_table.a%type)
RETURNS partitioned_table AS $$
DECLARE
    a_val partitioned_table.a%TYPE;
    result partitioned_table%ROWTYPE;
BEGIN
    a_val := $1;
    SELECT * INTO result FROM partitioned_table WHERE a = a_val;
    RETURN result;
END; $$ LANGUAGE plpgsql;
SELECT * FROM get_from_partitioned_table(1) AS t;
CREATE OR REPLACE FUNCTION list_partitioned_table()
RETURNS SETOF public.partitioned_table.a%TYPE AS $$
DECLARE
    row public.partitioned_table%ROWTYPE;
    a_val public.partitioned_table.a%TYPE;
BEGIN
    FOR row IN SELECT * FROM public.partitioned_table ORDER BY a LOOP
        a_val := row.a;
        RETURN NEXT a_val;
    END LOOP;
    RETURN;
END; $$ LANGUAGE plpgsql;
SELECT * FROM list_partitioned_table() AS t;
