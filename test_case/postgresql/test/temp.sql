

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


CREATE TEMP TABLE temptest(col int) ON COMMIT DELETE ROWS;

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

SELECT * FROM temptest;

BEGIN;
CREATE TEMP TABLE temptest(col) ON COMMIT DROP AS SELECT 1;

SELECT * FROM temptest;
COMMIT;

SELECT * FROM temptest;

BEGIN;
do $$
begin
  execute format($cmd$
    CREATE TEMP TABLE temptest (col text CHECK (col < %L)) ON COMMIT DROP
  $cmd$,
    (SELECT string_agg(g.i::text || ':' || random()::text, '|')
     FROM generate_series(1, 100) g(i)));
end$$;

SELECT * FROM temptest;
COMMIT;

SELECT * FROM temptest;


CREATE TABLE temptest(col int) ON COMMIT DELETE ROWS;
CREATE TABLE temptest(col) ON COMMIT DELETE ROWS AS SELECT 1;

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
COMMIT;


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
select whoami();

set search_path = public, pg_temp;
select * from whereami;
select whoami();

select pg_temp.whoami();

drop table public.whereami;

set search_path = pg_temp, public;
create domain pg_temp.nonempty as text check (value <> '');
select nonempty('');
select pg_temp.nonempty('');
select ''::nonempty;

reset search_path;

begin;
create temp table temp_parted_oncommit (a int)
  partition by list (a) on commit delete rows;
create temp table temp_parted_oncommit_1
  partition of temp_parted_oncommit
  for values in (1) on commit delete rows;
insert into temp_parted_oncommit values (1);
commit;
select * from temp_parted_oncommit;
drop table temp_parted_oncommit;

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
commit;
select relname from pg_class where relname ~ '^temp_parted_oncommit_test';
begin;
create temp table temp_parted_oncommit_test (a int)
  partition by list (a) on commit delete rows;
create temp table temp_parted_oncommit_test1
  partition of temp_parted_oncommit_test
  for values in (1) on commit preserve rows;
create temp table temp_parted_oncommit_test2
  partition of temp_parted_oncommit_test
  for values in (2) on commit drop;
insert into temp_parted_oncommit_test values (1), (2);
commit;
select * from temp_parted_oncommit_test;
select relname from pg_class where relname ~ '^temp_parted_oncommit_test'
  order by relname;
drop table temp_parted_oncommit_test;

begin;
create temp table temp_inh_oncommit_test (a int) on commit drop;
create temp table temp_inh_oncommit_test1 ()
  inherits(temp_inh_oncommit_test) on commit delete rows;
insert into temp_inh_oncommit_test1 values (1);
commit;
select relname from pg_class where relname ~ '^temp_inh_oncommit_test';
begin;
create temp table temp_inh_oncommit_test (a int) on commit delete rows;
create temp table temp_inh_oncommit_test1 ()
  inherits(temp_inh_oncommit_test) on commit drop;
insert into temp_inh_oncommit_test1 values (1);
insert into temp_inh_oncommit_test values (1);
commit;
select * from temp_inh_oncommit_test;
select relname from pg_class where relname ~ '^temp_inh_oncommit_test';
drop table temp_inh_oncommit_test;


begin;
create function pg_temp.twophase_func() returns void as
  $$ select '2pc_func'::text $$ language sql;
prepare transaction 'twophase_func';
create function pg_temp.twophase_func() returns void as
  $$ select '2pc_func'::text $$ language sql;
begin;
drop function pg_temp.twophase_func();
prepare transaction 'twophase_func';
begin;
create operator pg_temp.@@ (leftarg = int4, rightarg = int4, procedure = int4mi);
prepare transaction 'twophase_operator';

begin;
create type pg_temp.twophase_type as (a int);
prepare transaction 'twophase_type';
begin;
create view pg_temp.twophase_view as select 1;
prepare transaction 'twophase_view';
begin;
create sequence pg_temp.twophase_seq;
prepare transaction 'twophase_sequence';

create temp table twophase_tab (a int);
begin;
select a from twophase_tab;
prepare transaction 'twophase_tab';
begin;
insert into twophase_tab values (1);
prepare transaction 'twophase_tab';
begin;
lock twophase_tab in access exclusive mode;
prepare transaction 'twophase_tab';
begin;
drop table twophase_tab;
prepare transaction 'twophase_tab';

SET search_path TO 'pg_temp';
BEGIN;
SELECT current_schema() ~ 'pg_temp' AS is_temp_schema;
PREPARE TRANSACTION 'twophase_search';
