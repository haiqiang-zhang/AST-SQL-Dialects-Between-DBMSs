CREATE TABLE temptest(col int);
CREATE INDEX i_temptest ON temptest(col);
CREATE TEMP TABLE temptest(tcol int);
CREATE INDEX i_temptest ON temptest(tcol);
SELECT * FROM temptest;
DROP INDEX i_temptest;
DROP TABLE temptest;
SELECT * FROM temptest;
DROP INDEX i_temptest;
DROP TABLE temptest;
CREATE TABLE temptest(col int);
INSERT INTO temptest VALUES (1);
CREATE TEMP TABLE temptest(tcol float);
INSERT INTO temptest VALUES (2.1);
SELECT * FROM temptest;
DROP TABLE temptest;
SELECT * FROM temptest;
DROP TABLE temptest;
CREATE TEMP TABLE temptest(col int);
SELECT * FROM temptest;
CREATE INDEX ON temptest(bit_length(''));
BEGIN;
INSERT INTO temptest VALUES (1);
INSERT INTO temptest VALUES (2);
SELECT * FROM temptest;
COMMIT;
SELECT * FROM temptest;
DROP TABLE temptest;
BEGIN;
CREATE TEMP TABLE temptest(col) ON COMMIT DELETE ROWS AS SELECT 1;
SELECT * FROM temptest;
COMMIT;
SELECT * FROM temptest;
DROP TABLE temptest;
BEGIN;
CREATE TEMP TABLE temptest(col int) ON COMMIT DROP;
INSERT INTO temptest VALUES (1);
INSERT INTO temptest VALUES (2);
SELECT * FROM temptest;
COMMIT;
BEGIN;
CREATE TEMP TABLE temptest(col) ON COMMIT DROP AS SELECT 1;
SELECT * FROM temptest;
COMMIT;
BEGIN;
COMMIT;
BEGIN;
CREATE TEMP TABLE temptest1(col int PRIMARY KEY);
CREATE TEMP TABLE temptest2(col int REFERENCES temptest1)
  ON COMMIT DELETE ROWS;
INSERT INTO temptest1 VALUES (1);
INSERT INTO temptest2 VALUES (1);
COMMIT;
SELECT * FROM temptest1;
SELECT * FROM temptest2;
BEGIN;
CREATE TEMP TABLE temptest3(col int PRIMARY KEY) ON COMMIT DELETE ROWS;
CREATE TEMP TABLE temptest4(col int REFERENCES temptest3);
create table public.whereami (f1 text);
insert into public.whereami values ('public');
create temp table whereami (f1 text);
insert into whereami values ('temp');
create function public.whoami() returns text
  as $$select 'public'::text$$ language sql;
create function pg_temp.whoami() returns text
  as $$select 'temp'::text$$ language sql;
select * from whereami;
select whoami();
set search_path = pg_temp, public;
select * from whereami;
set search_path = public, pg_temp;
select * from whereami;
select pg_temp.whoami();
drop table public.whereami;
set search_path = pg_temp, public;
create domain pg_temp.nonempty as text check (value <> '');
reset search_path;
begin;
create temp table temp_parted_oncommit (a int)
  partition by list (a) on commit delete rows;
create temp table temp_parted_oncommit_1
  partition of temp_parted_oncommit
  for values in (1) on commit delete rows;
insert into temp_parted_oncommit values (1);
begin;
create temp table temp_parted_oncommit_test (a int)
  partition by list (a) on commit drop;
create temp table temp_parted_oncommit_test1
  partition of temp_parted_oncommit_test
  for values in (1) on commit delete rows;
create temp table temp_parted_oncommit_test2
  partition of temp_parted_oncommit_test
  for values in (2) on commit drop;
insert into temp_parted_oncommit_test values (1), (2);
select relname from pg_class where relname ~ '^temp_parted_oncommit_test';
begin;
select relname from pg_class where relname ~ '^temp_parted_oncommit_test'
  order by relname;
begin;
create temp table temp_inh_oncommit_test (a int) on commit drop;
create temp table temp_inh_oncommit_test1 ()
  inherits(temp_inh_oncommit_test) on commit delete rows;
insert into temp_inh_oncommit_test1 values (1);
select relname from pg_class where relname ~ '^temp_inh_oncommit_test';
begin;
select relname from pg_class where relname ~ '^temp_inh_oncommit_test';
begin;
create function pg_temp.twophase_func() returns void as
  $$ select '2pc_func'::text $$ language sql;
