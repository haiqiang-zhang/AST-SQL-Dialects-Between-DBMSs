begin;
rollback;
create temporary table gexec_test(a int, b text, c date, d float);
prepare q as select repeat('x',2*n) as "0123456789abcdef", repeat('y',20-2*n) as "0123456789" from generate_series(1,10) as n;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
deallocate q;
create table psql_serial_tab (id serial);
select 1 where false;
CREATE SCHEMA tableam_display;
SET search_path TO tableam_display;
CREATE TABLE tbl_heap(f1 int, f2 char(100)) using heap;
RESET ROLE;
RESET search_path;
DROP SCHEMA tableam_display CASCADE;
select n, -n as m, n * 111 as x, '1e90'::float8 as f
from generate_series(0,3) n;
prepare q as
  select 'some|text' as "a|title", '        ' as "empty ", n as int
  from generate_series(1,2) as n;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
deallocate q;
prepare q as
  select 'some"text' as "a""title", E'  <foo>\n<bar>' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;
execute q;
execute q;
deallocate q;
select '\.' as data;
select '\' as d1, '' as d2;
prepare q as
  select 'some"text' as "a&title", E'  <foo>\n<bar>' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
deallocate q;
prepare q as
  select 'some\more_text' as "a$title", E'  #<foo>%&^~|\n{bar}' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
deallocate q;
prepare q as
  select 'some\more_text' as "a$title", E'  #<foo>%&^~|\n{bar}' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
deallocate q;
prepare q as
  select 'some\text' as "a\title", E'  <foo>\n<bar>' as "junk",
         '   ' as "empty", n as int
  from generate_series(1,2) as n;
execute q;
execute q;
execute q;
execute q;
execute q;
execute q;
deallocate q;
drop table psql_serial_tab;
select 'okay';
select 'still okay';
SELECT 1;
SELECT 1 AS stuff UNION SELECT 2;
create schema testpart;
set search_path to testpart;
create table testtable_apple(logdate date);
create table testtable_orange(logdate date);
create index testtable_apple_index on testtable_apple(logdate);
create index testtable_orange_index on testtable_orange(logdate);
create table testpart_apple(logdate date) partition by range(logdate);
create table testpart_orange(logdate date) partition by range(logdate);
create index testpart_apple_index on testpart_apple(logdate);
create index testpart_orange_index on testpart_orange(logdate);
drop table testtable_apple;
drop table testtable_orange;
drop table testpart_apple;
drop table testpart_orange;
create table parent_tab (id int) partition by range (id);
create index parent_index on parent_tab (id);
create table child_0_10 partition of parent_tab
  for values from (0) to (10);
create table child_10_20 partition of parent_tab
  for values from (10) to (20);
create table child_20_30 partition of parent_tab
  for values from (20) to (30);
insert into parent_tab values (generate_series(0,29));
create table child_30_40 partition of parent_tab
for values from (30) to (40)
  partition by range(id);
create table child_30_35 partition of child_30_40
  for values from (30) to (35);
create table child_35_40 partition of child_30_40
   for values from (35) to (40);
insert into parent_tab values (generate_series(30,39));
drop table parent_tab cascade;
drop schema testpart;
set search_path to default;
set role to default;
set work_mem = 10240;
reset work_mem;
begin;
end;
end;
rollback;
CREATE TABLE ac_test (a int);
INSERT INTO ac_test VALUES (1);
COMMIT;
SELECT * FROM ac_test;
COMMIT;
INSERT INTO ac_test VALUES (2);
ROLLBACK;
SELECT * FROM ac_test;
COMMIT;
BEGIN;
INSERT INTO ac_test VALUES (3);
COMMIT;
SELECT * FROM ac_test;
COMMIT;
BEGIN;
INSERT INTO ac_test VALUES (4);
ROLLBACK;
SELECT * FROM ac_test;
COMMIT;
DROP TABLE ac_test;
CREATE TABLE oer_test (a int);
BEGIN;
INSERT INTO oer_test VALUES (1);
COMMIT;
SELECT * FROM oer_test;
BEGIN;
INSERT INTO oer_test VALUES (4);
ROLLBACK;
SELECT * FROM oer_test;
BEGIN;
INSERT INTO oer_test VALUES (5);
COMMIT AND CHAIN;
INSERT INTO oer_test VALUES (6);
COMMIT;
SELECT * FROM oer_test;
DROP TABLE oer_test;
SELECT 2 AS two;
SELECT 7;
SELECT 10 AS ten;
ROLLBACK;
SELECT 'ok' AS "done";
SELECT 2 AS two;
CREATE TEMPORARY TABLE reload_output(
  lineno int NOT NULL GENERATED ALWAYS AS IDENTITY,
  line text
);
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;
SELECT 3 AS c;
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;
SELECT line FROM reload_output ORDER BY lineno;
DROP TABLE reload_output;
ROLLBACK;
COMMIT;
ROLLBACK;
COMMIT;
COMMIT;
CREATE FUNCTION psql_error(msg TEXT) RETURNS BOOLEAN AS $$
  BEGIN
    RAISE EXCEPTION 'error %', msg;
  END;
$$ LANGUAGE plpgsql;
BEGIN;
COMMIT;
BEGIN;
COMMIT;
COMMIT;
COMMIT;
DROP FUNCTION psql_error;
BEGIN;
ROLLBACK;
CREATE TABLE defprivs (a int);
DROP TABLE defprivs;
