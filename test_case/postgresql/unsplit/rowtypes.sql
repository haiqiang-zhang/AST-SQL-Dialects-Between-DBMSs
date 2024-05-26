create type complex as (r float8, i float8);
create temp table fullname (first text, last text);
create type quad as (c1 complex, c2 complex);
select (1.1,2.2)::complex, row((3.3,4.4),(5.5,null))::quad;
select row('Joe', 'Blow')::fullname, '(Joe,Blow)'::fullname;
select '(Joe,von Blow)'::fullname, '(Joe,d''Blow)'::fullname;
select '(Joe,"von""Blow")'::fullname, E'(Joe,d\\\\Blow)'::fullname;
select '(Joe,"Blow,Jr")'::fullname;
select '(Joe,)'::fullname;
select ' (Joe,Blow)  '::fullname;
SELECT pg_input_is_valid('(1,2)', 'complex');
SELECT * FROM pg_input_error_info('(1,zed)', 'complex');
create temp table quadtable(f1 int, q quad);
insert into quadtable values (1, ((3.3,4.4),(5.5,6.6)));
insert into quadtable values (2, ((null,4.4),(5.5,6.6)));
select * from quadtable;
select f1, (q).c1, (qq.q).c1.i from quadtable qq;
create temp table people (fn fullname, bd date);
insert into people values ('(Joe,Blow)', '1984-01-10');
select * from people;
alter table fullname add column suffix text default null;
select * from people;
update people set fn.suffix = 'Jr';
select * from people;
insert into quadtable (f1, q.c1.r, q.c2.i) values(44,55,66);
update quadtable set q.c1.r = 12 where f1 = 2;
select * from quadtable;
create temp table pp (f1 text);
insert into pp values (repeat('abcdefghijkl', 100000));
insert into people select ('Jim', f1, null)::fullname, current_date from pp;
select (fn).first, substr((fn).last, 1, 20), length((fn).last) from people;
update people set fn.first = 'Jack';
select ROW(1,2) < ROW(1,3) as true;
select ROW(1,2) < ROW(1,1) as false;
select ROW(1,2) < ROW(1,NULL) as null;
select ROW(1,2,3) < ROW(1,3,NULL) as true;
select ROW(11,'ABC') < ROW(11,'DEF') as true;
select ROW(11,'ABC') > ROW(11,'DEF') as false;
select ROW(12,'ABC') > ROW(11,'DEF') as true;
select ROW(1,2,3) < ROW(1,NULL,4) as null;
select ROW(1,2,3) = ROW(1,NULL,4) as false;
select ROW(1,2,3) <> ROW(1,NULL,4) as true;
select ROW('ABC','DEF') ~<=~ ROW('DEF','ABC') as true;
select ROW('ABC','DEF') ~>=~ ROW('DEF','ABC') as false;
select ROW(1,2) = ROW(1,2::int8);
select ROW(1,2) in (ROW(3,4), ROW(1,2));
create temp table test_table (a text, b text);
insert into test_table values ('a', 'b');
insert into test_table select 'a', null from generate_series(1,1000);
insert into test_table values ('b', 'a');
create index on test_table (a,b);
set enable_sort = off;
explain (costs off)
select a,b from test_table where (a,b) > ('a','a') order by a,b;
select a,b from test_table where (a,b) > ('a','a') order by a,b;
reset enable_sort;
select (row(1, 2.0)).f1;
select (row(1, 2.0)).f2;
select (row(1, 2.0)).*;
select (r).f1 from (select row(1, 2.0) as r) ss;
select (r).* from (select row(1, 2.0) as r) ss;
select array[ row(1,2), row(3,4), row(5,6) ];
select row(1,1.1) = any (array[ row(7,7.7), row(1,1.1), row(0,0.0) ]);
create type cantcompare as (p point, r float8);
create temp table cc (f1 cantcompare);
insert into cc values('("(1,2)",3)');
insert into cc values('("(4,5)",6)');
create type testtype1 as (a int, b int);
select row(1, 2)::testtype1 < row(1, 3)::testtype1;
select row(1, 2)::testtype1 <= row(1, 3)::testtype1;
select row(1, 2)::testtype1 = row(1, 2)::testtype1;
select row(1, 2)::testtype1 <> row(1, 3)::testtype1;
select row(1, 3)::testtype1 >= row(1, 2)::testtype1;
select row(1, 3)::testtype1 > row(1, 2)::testtype1;
select row(1, -2)::testtype1 < row(1, -3)::testtype1;
select row(1, -2)::testtype1 <= row(1, -3)::testtype1;
select row(1, -2)::testtype1 = row(1, -3)::testtype1;
select row(1, -2)::testtype1 <> row(1, -2)::testtype1;
select row(1, -3)::testtype1 >= row(1, -2)::testtype1;
select row(1, -3)::testtype1 > row(1, -2)::testtype1;
select row(1, -2)::testtype1 < row(1, 3)::testtype1;
create type testtype3 as (a int, b text);
create type testtype5 as (a int);
create type testtype6 as (a int, b point);
drop type testtype1, testtype3, testtype5, testtype6;
create type testtype1 as (a int, b int);
select row(1, 2)::testtype1 *< row(1, 3)::testtype1;
select row(1, 2)::testtype1 *<= row(1, 3)::testtype1;
select row(1, 2)::testtype1 *= row(1, 2)::testtype1;
select row(1, 2)::testtype1 *<> row(1, 3)::testtype1;
select row(1, 3)::testtype1 *>= row(1, 2)::testtype1;
select row(1, 3)::testtype1 *> row(1, 2)::testtype1;
select row(1, -2)::testtype1 *< row(1, -3)::testtype1;
select row(1, -2)::testtype1 *<= row(1, -3)::testtype1;
select row(1, -2)::testtype1 *= row(1, -3)::testtype1;
select row(1, -2)::testtype1 *<> row(1, -2)::testtype1;
select row(1, -3)::testtype1 *>= row(1, -2)::testtype1;
select row(1, -3)::testtype1 *> row(1, -2)::testtype1;
select row(1, -2)::testtype1 *< row(1, 3)::testtype1;
create type testtype2 as (a smallint, b bool);
select row(1, true)::testtype2 *< row(2, true)::testtype2;
select row(-2, true)::testtype2 *< row(-1, true)::testtype2;
select row(0, false)::testtype2 *< row(0, true)::testtype2;
select row(0, false)::testtype2 *<> row(0, true)::testtype2;
create type testtype3 as (a int, b text);
select row(1, 'abc')::testtype3 *< row(1, 'abd')::testtype3;
select row(1, 'abc')::testtype3 *< row(1, 'abcd')::testtype3;
select row(1, 'abc')::testtype3 *> row(1, 'abd')::testtype3;
select row(1, 'abc')::testtype3 *<> row(1, 'abd')::testtype3;
create type testtype4 as (a int, b point);
select row(1, '(1,2)')::testtype4 *< row(1, '(1,3)')::testtype4;
select row(1, '(1,2)')::testtype4 *<> row(1, '(1,3)')::testtype4;
create type testtype5 as (a int);
create type testtype6 as (a int, b point);
select row(1, '(1,2)')::testtype6 *< row(1, '(1,3)')::testtype6;
select row(1, '(1,2)')::testtype6 *>= row(1, '(1,3)')::testtype6;
select row(1, '(1,2)')::testtype6 *<> row(1, '(1,3)')::testtype6;
select q.a, q.b = row(2), q.c = array[row(3)], q.d = row(row(4)) from
    unnest(array[row(1, row(2), array[row(3)], row(row(4))),
                 row(2, row(3), array[row(4)], row(row(5)))])
      as q(a int, b record, c record[], d record);
drop type testtype1, testtype2, testtype3, testtype4, testtype5, testtype6;
BEGIN;
CREATE TABLE price (
    id SERIAL PRIMARY KEY,
    active BOOLEAN NOT NULL,
    price NUMERIC
);
CREATE TYPE price_input AS (
    id INTEGER,
    price NUMERIC
);
CREATE TYPE price_key AS (
    id INTEGER
);
CREATE FUNCTION price_key_from_table(price) RETURNS price_key AS $$
    SELECT $1.id
$$ LANGUAGE SQL;
CREATE FUNCTION price_key_from_input(price_input) RETURNS price_key AS $$
    SELECT $1.id
$$ LANGUAGE SQL;
insert into price values (1,false,42), (10,false,100), (11,true,17.99);
UPDATE price
    SET active = true, price = input_prices.price
    FROM unnest(ARRAY[(10, 123.00), (11, 99.99)]::price_input[]) input_prices
    WHERE price_key_from_table(price.*) = price_key_from_input(input_prices.*);
select * from price;
rollback;
create temp table compos (f1 int, f2 text);
select * from compos;
select cast (fullname as text) from fullname;
select fullname::text from fullname;
select cast (row('Jim', 'Beam') as text);
select (row('Jim', 'Beam'))::text;
insert into fullname values ('Joe', 'Blow');
select f.last from fullname f;
select last(f) from fullname f;
create function longname(fullname) returns text language sql
as $$select $1.first || ' ' || $1.last$$;
select f.longname from fullname f;
select longname(f) from fullname f;
alter table fullname add column longname text;
select f.longname from fullname f;
explain (verbose, costs off)
select r, r is null as isnull, r is not null as isnotnull
from (values (1,row(1,2)), (1,row(null,null)), (1,null),
             (null,row(1,2)), (null,row(null,null)), (null,null) ) r(a,b);
select r, r is null as isnull, r is not null as isnotnull
from (values (1,row(1,2)), (1,row(null,null)), (1,null),
             (null,row(1,2)), (null,row(null,null)), (null,null) ) r(a,b);
explain (verbose, costs off)
with r(a,b) as materialized
  (values (1,row(1,2)), (1,row(null,null)), (1,null),
          (null,row(1,2)), (null,row(null,null)), (null,null) )
select r, r is null as isnull, r is not null as isnotnull from r;
with r(a,b) as materialized
  (values (1,row(1,2)), (1,row(null,null)), (1,null),
          (null,row(1,2)), (null,row(null,null)), (null,null) )
select r, r is null as isnull, r is not null as isnotnull from r;
explain (verbose, costs off)
with cte(c) as materialized (select row(1, 2)),
     cte2(c) as (select * from cte)
select * from cte2 as t
where (select * from (select c as c1) s
       where (select (c1).f1 > 0)) is not null;
with cte(c) as materialized (select row(1, 2)),
     cte2(c) as (select * from cte)
select * from cte2 as t
where (select * from (select c as c1) s
       where (select (c1).f1 > 0)) is not null;
create view composite_v as
with cte(c) as materialized (select row(1, 2)),
     cte2(c) as (select * from cte)
select 1 as one from cte2 as t
where (select * from (select c as c1) s
       where (select (c1).f1 > 0)) is not null;
select pg_get_viewdef('composite_v', true);
drop view composite_v;
CREATE TABLE compositetable(a text, b text);
INSERT INTO compositetable(a, b) VALUES('fa', 'fb');
SELECT (d).a, (d).b FROM (SELECT compositetable AS d FROM compositetable) s;
SELECT (NULL::compositetable).a;
DROP TABLE compositetable;
