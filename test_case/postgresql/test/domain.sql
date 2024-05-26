comment on domain domaindroptest is 'About to drop this..';
create domain dependenttypetest domaindroptest;
drop domain domaindroptest cascade;
create domain domainvarchar varchar(5);
create domain domainnumeric numeric(8,2);
create domain domainint4 int4;
create domain domaintext text;
SELECT cast('123456' as domainvarchar);
create table basictest
           ( testint4 domainint4
           , testtext domaintext
           , testvarchar domainvarchar
           , testnumeric domainnumeric
           );
INSERT INTO basictest values ('88', 'haha', 'short', '123.12');
INSERT INTO basictest values ('88', 'haha', 'short', '123.1212');
select testtext || testvarchar as concat, testnumeric + 42 as sum
from basictest;
select pg_typeof(coalesce(4::domainint4, 7));
drop table basictest;
drop domain domainvarchar restrict;
drop domain domainnumeric restrict;
drop domain domainint4 restrict;
drop domain domaintext;
create domain positiveint int4 check(value > 0);
create domain weirdfloat float8 check((1 / value) < 10);
select pg_input_is_valid('1', 'positiveint');
select * from pg_input_error_info('junk', 'positiveint');
drop domain positiveint;
drop domain weirdfloat;
create domain domainint4arr int4[1];
create domain domainchar4arr varchar(4)[2][3];
create table domarrtest
           ( testint4arr domainint4arr
           , testchar4arr domainchar4arr
            );
INSERT INTO domarrtest values ('{2,2}', '{{"a","b"},{"c","d"}}');
INSERT INTO domarrtest values ('{{2,2},{2,2}}', '{{"a","b"}}');
INSERT INTO domarrtest values ('{2,2}', '{{"a","b"},{"c","d"},{"e","f"}}');
INSERT INTO domarrtest values ('{2,2}', '{{"a"},{"c"}}');
INSERT INTO domarrtest values (NULL, '{{"a","b","c"},{"d","e","f"}}');
INSERT INTO domarrtest (testint4arr[1], testint4arr[3]) values (11,22);
select * from domarrtest;
select testint4arr[1], testchar4arr[2:2] from domarrtest;
select array_dims(testint4arr), array_dims(testchar4arr) from domarrtest;
update domarrtest set
  testint4arr[1] = testint4arr[1] + 1,
  testint4arr[3] = testint4arr[3] - 1
where testchar4arr is null;
select * from domarrtest where testchar4arr is null;
drop table domarrtest;
drop domain domainint4arr restrict;
drop domain domainchar4arr restrict;
create domain dia as int[];
select '{1,2,3}'::dia;
drop domain dia;
create type comptype as (r float8, i float8);
create domain dcomptype as comptype;
create table dcomptable (d1 dcomptype unique);
insert into dcomptable values (row(1,2)::dcomptype);
insert into dcomptable values (row(3,4)::comptype);
insert into dcomptable (d1.r) values(11);
select * from dcomptable;
select (d1).r, (d1).i, (d1).* from dcomptable;
update dcomptable set d1.r = (d1).r + 1 where (d1).i > 0;
select * from dcomptable;
alter domain dcomptype add constraint c1 check ((value).r <= (value).i);
insert into dcomptable values (row(1,2)::comptype);
insert into dcomptable (d1.r) values(99);
insert into dcomptable (d1.r, d1.i) values(99, 100);
update dcomptable set d1.r = (d1).r - 1, d1.i = (d1).i + 1 where (d1).i > 0;
select * from dcomptable;
explain (verbose, costs off)
  update dcomptable set d1.r = (d1).r - 1, d1.i = (d1).i + 1 where (d1).i > 0;
create rule silly as on delete to dcomptable do instead
  update dcomptable set d1.r = (d1).r - 1, d1.i = (d1).i + 1 where (d1).i > 0;
create function makedcomp(r float8, i float8) returns dcomptype
as 'select row(r, i)' language sql;
select makedcomp(1,2);
select * from makedcomp(1,2) m;
select m, m is not null from makedcomp(1,2) m;
drop function makedcomp(float8, float8);
drop table dcomptable;
drop type comptype cascade;
create type comptype as (r float8, i float8);
create domain dcomptype as comptype;
alter domain dcomptype add constraint c1 check ((value).r > 0);
comment on constraint c1 on domain dcomptype is 'random commentary';
alter type comptype alter attribute r type bigint;
alter type comptype drop attribute i;
select conname, obj_description(oid, 'pg_constraint') from pg_constraint
  where contypid = 'dcomptype'::regtype;
drop type comptype cascade;
create type comptype as (r float8, i float8);
create domain dcomptypea as comptype[];
create table dcomptable (d1 dcomptypea unique);
insert into dcomptable values (array[row(1,2)]::dcomptypea);
insert into dcomptable values (array[row(3,4), row(5,6)]::comptype[]);
insert into dcomptable values (array[row(7,8)::comptype, row(9,10)::comptype]);
insert into dcomptable (d1[1]) values(row(9,10));
insert into dcomptable (d1[1].r) values(11);
select * from dcomptable;
select d1[2], d1[1].r, d1[1].i from dcomptable;
update dcomptable set d1[2] = row(d1[2].i, d1[2].r);
select * from dcomptable;
update dcomptable set d1[1].r = d1[1].r + 1 where d1[1].i > 0;
select * from dcomptable;
alter domain dcomptypea add constraint c1 check (value[1].r <= value[1].i);
insert into dcomptable values (array[row(1,2)]::comptype[]);
insert into dcomptable (d1[1].r) values(99);
insert into dcomptable (d1[1].r, d1[1].i) values(99, 100);
update dcomptable set d1[1].r = d1[1].r - 1, d1[1].i = d1[1].i + 1
  where d1[1].i > 0;
select * from dcomptable;
explain (verbose, costs off)
  update dcomptable set d1[1].r = d1[1].r - 1, d1[1].i = d1[1].i + 1
    where d1[1].i > 0;
create rule silly as on delete to dcomptable do instead
  update dcomptable set d1[1].r = d1[1].r - 1, d1[1].i = d1[1].i + 1
    where d1[1].i > 0;
drop table dcomptable;
drop type comptype cascade;
create domain posint as int check (value > 0);
create table pitable (f1 posint[]);
insert into pitable values(array[42]);
update pitable set f1[1] = f1[1] + 1;
select * from pitable;
drop table pitable;
create domain vc4 as varchar(4);
create table vc4table (f1 vc4[]);
insert into vc4table values(array['too long']::vc4[]);
select * from vc4table;
drop table vc4table;
drop type vc4;
create domain dposinta as posint[];
create table dposintatable (f1 dposinta[]);
insert into dposintatable values(array[array[42]::dposinta]);
select f1, f1[1], (f1[1])[1] from dposintatable;
update dposintatable set f1[2] = array[99];
select f1, f1[1], (f1[2])[1] from dposintatable;
drop table dposintatable;
drop domain posint cascade;
create type comptype as (cf1 int, cf2 int);
create domain dcomptype as comptype check ((value).cf1 > 0);
create table dcomptable (f1 dcomptype[]);
insert into dcomptable values (null);
update dcomptable set f1[1].cf2 = 5;
table dcomptable;
update dcomptable set f1[1].cf1 = 1;
table dcomptable;
alter domain dcomptype drop constraint dcomptype_check;
update dcomptable set f1[1].cf1 = -1;
table dcomptable;
drop table dcomptable;
drop type comptype cascade;
create domain dnotnull varchar(15) NOT NULL;
create domain dnull    varchar(15);
create domain dcheck   varchar(15) NOT NULL CHECK (VALUE = 'a' OR VALUE = 'c' OR VALUE = 'd');
create table nulltest
           ( col1 dnotnull
           , col2 dnotnull NULL  
           , col3 dnull    NOT NULL
           , col4 dnull
           , col5 dcheck CHECK (col5 IN ('c', 'd'))
           );
INSERT INTO nulltest values ('a', 'b', 'c', 'd', 'c');
INSERT INTO nulltest values ('a', 'b', 'c', NULL, 'd');
drop table nulltest;
drop domain dnotnull restrict;
drop domain dnull restrict;
drop domain dcheck restrict;
create domain ddef1 int4 DEFAULT 3;
create domain ddef2 oid DEFAULT '12';
create domain ddef3 text DEFAULT 5;
create sequence ddef4_seq;
create domain ddef4 int4 DEFAULT nextval('ddef4_seq');
create domain ddef5 numeric(8,2) NOT NULL DEFAULT '12.12';
create table defaulttest
            ( col1 ddef1
            , col2 ddef2
            , col3 ddef3
            , col4 ddef4 PRIMARY KEY
            , col5 ddef1 NOT NULL DEFAULT NULL
            , col6 ddef2 DEFAULT '88'
            , col7 ddef4 DEFAULT 8000
            , col8 ddef5
            );
alter table defaulttest alter column col5 drop default;
insert into defaulttest default values;
alter table defaulttest alter column col5 set default null;
alter table defaulttest alter column col5 drop default;
insert into defaulttest default values;
insert into defaulttest default values;
drop table defaulttest cascade;
create domain dnotnulltest integer;
create table domnotnull
( col1 dnotnulltest
, col2 dnotnulltest
);
insert into domnotnull default values;
update domnotnull set col1 = 5;
update domnotnull set col2 = 6;
alter domain dnotnulltest set not null;
alter domain dnotnulltest drop not null;
update domnotnull set col1 = null;
drop domain dnotnulltest cascade;
create table domdeftest (col1 ddef1);
insert into domdeftest default values;
select * from domdeftest;
alter domain ddef1 set default '42';
insert into domdeftest default values;
select * from domdeftest;
alter domain ddef1 drop default;
insert into domdeftest default values;
select * from domdeftest;
drop table domdeftest;
create domain con as integer;
create table domcontest (col1 con);
insert into domcontest values (1);
insert into domcontest values (2);
alter domain con add constraint t check (VALUE < 34);
alter domain con add check (VALUE > 0);
insert into domcontest values (5);
alter domain con drop constraint t;
insert into domcontest values (42);
alter domain con drop constraint if exists nonexistent;
create domain connotnull integer;
create table domconnotnulltest
( col1 connotnull
, col2 connotnull
);
insert into domconnotnulltest default values;
update domconnotnulltest set col1 = 5;
update domconnotnulltest set col2 = 6;
select count(*) from pg_constraint where contypid = 'connotnull'::regtype and contype = 'n';
update domconnotnulltest set col1 = null;
update domconnotnulltest set col1 = null;
drop domain connotnull cascade;
drop table domconnotnulltest;
create domain things AS INT;
CREATE TABLE thethings (stuff things);
INSERT INTO thethings (stuff) VALUES (55);
ALTER DOMAIN things ADD CONSTRAINT meow CHECK (VALUE < 11) NOT VALID;
UPDATE thethings SET stuff = 10;
ALTER DOMAIN things VALIDATE CONSTRAINT meow;
create table domtab (col1 integer);
create domain dom as integer;
create view domview as select cast(col1 as dom) from domtab;
insert into domtab (col1) values (null);
insert into domtab (col1) values (5);
select * from domview;
alter domain dom set not null;
alter domain dom drop not null;
select * from domview;
alter domain dom add constraint domchkgt6 check(value > 6);
alter domain dom drop constraint domchkgt6 restrict;
select * from domview;
drop domain ddef1 restrict;
drop domain ddef2 restrict;
drop domain ddef3 restrict;
drop domain ddef4 restrict;
drop domain ddef5 restrict;
drop sequence ddef4_seq;
create domain vchar4 varchar(4);
create domain dinter vchar4 check (substring(VALUE, 1, 1) = 'x');
create domain dtop dinter check (substring(VALUE, 2, 1) = '1');
select 'x123'::dtop;
select 'x1234'::dtop;
create temp table dtest(f1 dtop);
insert into dtest values('x123');
drop table dtest;
drop domain vchar4 cascade;
create domain str_domain as text not null;
create table domain_test (a int, b int);
insert into domain_test values (1, 2);
insert into domain_test values (1, 2);
create domain str_domain2 as text check (value <> 'foo') default 'foo';
create domain pos_int as int4 check (value > 0) not null;
prepare s1 as select $1::pos_int = 10 as "is_ten";
execute s1(10);
create domain posint as int4;
create type ddtest1 as (f1 posint);
create table ddtest2(f1 ddtest1);
insert into ddtest2 values(row(-1));
drop table ddtest2;
create table ddtest2(f1 ddtest1[]);
insert into ddtest2 values('{(-1)}');
drop table ddtest2;
create domain ddtest1d as ddtest1;
create table ddtest2(f1 ddtest1d);
insert into ddtest2 values('(-1)');
drop table ddtest2;
drop domain ddtest1d;
create domain ddtest1d as ddtest1[];
create table ddtest2(f1 ddtest1d);
insert into ddtest2 values('{(-1)}');
drop table ddtest2;
drop domain ddtest1d;
create type rposint as range (subtype = posint);
create table ddtest2(f1 rposint);
insert into ddtest2 values('(-1,3]');
drop table ddtest2;
drop type rposint;
alter domain posint add constraint c1 check(value >= 0);
create domain posint2 as posint check (value % 2 = 0);
create table ddtest2(f1 posint2);
insert into ddtest2 values(2);
alter domain posint add constraint c2 check(value > 0);
drop table ddtest2;
drop type ddtest1;
drop domain posint cascade;
create domain mynums as numeric(4,2)[1];
create domain mynums2 as mynums;
create domain orderedpair as int[2] check (value[1] < value[2]);
select array[1,2]::orderedpair;
create temp table op (f1 orderedpair);
insert into op values (array[1,2]);
update op set f1[2] = 3;
select * from op;
create or replace function array_elem_check(int) returns int as $$
declare
  x orderedpair := '{1,2}';
begin
  x[2] := $1;
  return x[2];
end$$ language plpgsql;
select array_elem_check(3);
drop function array_elem_check(int);
create domain di as int;
create function dom_check(int) returns di as $$
declare d di;
begin
  d := $1::di;
  return d;
end
$$ language plpgsql immutable;
select dom_check(0);
alter domain di add constraint pos check (value > 0);
alter domain di drop constraint pos;
create or replace function dom_check(int) returns di as $$
declare d di;
begin
  d := $1;
  return d;
end
$$ language plpgsql immutable;
alter domain di add constraint pos check (value > 0);
alter domain di drop constraint pos;
drop function dom_check(int);
drop domain di;
create function sql_is_distinct_from(anyelement, anyelement)
returns boolean language sql
as 'select $1 is distinct from $2 limit 1';
create domain inotnull int
  check (sql_is_distinct_from(value, null));
select 1::inotnull;
create table dom_table (x inotnull);
insert into dom_table values ('1');
insert into dom_table values (1);
drop table dom_table;
drop domain inotnull;
drop function sql_is_distinct_from(anyelement, anyelement);
create domain testdomain1 as int;
alter domain testdomain1 rename to testdomain2;
alter type testdomain2 rename to testdomain3;
drop domain testdomain3;
create domain testdomain1 as int constraint unsigned check (value > 0);
alter domain testdomain1 rename constraint unsigned to unsigned_foo;
alter domain testdomain1 drop constraint unsigned_foo;
drop domain testdomain1;
SELECT * FROM information_schema.column_domain_usage
  WHERE domain_name IN ('con', 'dom', 'pos_int', 'things')
  ORDER BY domain_name;
SELECT * FROM information_schema.domain_constraints
  WHERE domain_name IN ('con', 'dom', 'pos_int', 'things')
  ORDER BY constraint_name;
SELECT * FROM information_schema.domains
  WHERE domain_name IN ('con', 'dom', 'pos_int', 'things')
  ORDER BY domain_name;
SELECT * FROM information_schema.check_constraints
  WHERE (constraint_schema, constraint_name)
        IN (SELECT constraint_schema, constraint_name
            FROM information_schema.domain_constraints
            WHERE domain_name IN ('con', 'dom', 'pos_int', 'things'))
  ORDER BY constraint_name;
