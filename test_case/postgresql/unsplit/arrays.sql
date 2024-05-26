CREATE TABLE arrtest (
	a 			int2[],
	b 			int4[][][],
	c 			name[],
	d			text[][],
	e 			float8[],
	f			char(5)[],
	g			varchar(5)[]
);
CREATE TABLE array_op_test (
	seqno		int4,
	i			int4[],
	t			text[]
);
ANALYZE array_op_test;
INSERT INTO arrtest (a[1:5], b[1:1][1:2][1:2], c, d, f, g)
   VALUES ('{1,2,3,4,5}', '{{{0,0},{1,2}}}', '{}', '{}', '{}', '{}');
UPDATE arrtest SET e[0] = '1.1';
UPDATE arrtest SET e[1] = '2.2';
INSERT INTO arrtest (a, b[1:2][1:2], c, d, e, f, g)
   VALUES ('{11,12,23}', '{{3,4},{4,5}}', '{"foobar"}',
           '{{"elt1", "elt2"}}', '{"3.4", "6.7"}',
           '{"abc","abcde"}', '{"abc","abcde"}');
INSERT INTO arrtest (a, b[1:2], c, d[1:2])
   VALUES ('{}', '{3,4}', '{foo,bar}', '{bar,foo}');
SELECT * FROM arrtest;
SELECT arrtest.a[1],
          arrtest.b[1][1][1],
          arrtest.c[1],
          arrtest.d[1][1],
          arrtest.e[0]
   FROM arrtest;
SELECT a[1], b[1][1][1], c[1], d[1][1], e[0]
   FROM arrtest;
SELECT a[1:3],
          b[1:1][1:2][1:2],
          c[1:2],
          d[1:1][1:2]
   FROM arrtest;
SELECT array_ndims(a) AS a,array_ndims(b) AS b,array_ndims(c) AS c
   FROM arrtest;
SELECT array_dims(a) AS a,array_dims(b) AS b,array_dims(c) AS c
   FROM arrtest;
SELECT *
   FROM arrtest
   WHERE a[1] < 5 and
         c = '{"foobar"}'::_name;
UPDATE arrtest
  SET a[1:2] = '{16,25}'
  WHERE NOT a = '{}'::_int2;
UPDATE arrtest
  SET b[1:1][1:1][1:2] = '{113, 117}',
      b[1:1][1:2][2:2] = '{142, 147}'
  WHERE array_dims(b) = '[1:1][1:2][1:2]';
UPDATE arrtest
  SET c[2:2] = '{"new_word"}'
  WHERE array_dims(c) is not null;
SELECT a,b,c FROM arrtest;
SELECT a[1:3],
          b[1:1][1:2][1:2],
          c[1:2],
          d[1:1][2:2]
   FROM arrtest;
SELECT b[1:1][2][2],
       d[1:1][2]
   FROM arrtest;
INSERT INTO arrtest(a) VALUES('{1,null,3}');
SELECT a FROM arrtest;
UPDATE arrtest SET a[4] = NULL WHERE a[2] IS NULL;
SELECT a FROM arrtest WHERE a[2] IS NULL;
DELETE FROM arrtest WHERE a[2] IS NULL AND b IS NULL;
SELECT a,b,c FROM arrtest;
SELECT pg_input_is_valid('{1,2,3}', 'integer[]');
SELECT * FROM pg_input_error_info('{1,zed}', 'integer[]');
select '{{1,2,3},{4,5,6},{7,8,9}}'::int[];
select ('{{1,2,3},{4,5,6},{7,8,9}}'::int[])[1:2][2];
select ('[0:2][0:2]={{1,2,3},{4,5,6},{7,8,9}}'::int[])[1:2][2];
SELECT ('{{{1},{2},{3}},{{4},{5},{6}}}'::int[])[1][NULL][1];
SELECT ('{{{1},{2},{3}},{{4},{5},{6}}}'::int[])[1][NULL:1][1];
SELECT ('{{{1},{2},{3}},{{4},{5},{6}}}'::int[])[1][1:NULL][1];
CREATE TEMP TABLE arrtest_s (
  a       int2[],
  b       int2[][]
);
INSERT INTO arrtest_s VALUES ('{1,2,3,4,5}', '{{1,2,3}, {4,5,6}, {7,8,9}}');
INSERT INTO arrtest_s VALUES ('[0:4]={1,2,3,4,5}', '[0:2][0:2]={{1,2,3}, {4,5,6}, {7,8,9}}');
SELECT a[:3], b[:2][:2] FROM arrtest_s;
SELECT a[2:], b[2:][2:] FROM arrtest_s;
SELECT a[:], b[:] FROM arrtest_s;
UPDATE arrtest_s SET a[:3] = '{11, 12, 13}', b[:2][:2] = '{{11,12}, {14,15}}'
  WHERE array_lower(a,1) = 1;
UPDATE arrtest_s SET a[3:] = '{23, 24, 25}', b[2:][2:] = '{{25,26}, {28,29}}';
UPDATE arrtest_s SET a[:] = '{11, 12, 13, 14, 15}';
INSERT INTO arrtest_s VALUES(NULL, NULL);
CREATE TEMP TABLE arrtest1 (i int[], t text[]);
insert into arrtest1 values(array[1,2,null,4], array['one','two',null,'four']);
select * from arrtest1;
update arrtest1 set i[2] = 22, t[2] = 'twenty-two';
select * from arrtest1;
update arrtest1 set i[5] = 5, t[5] = 'five';
select * from arrtest1;
update arrtest1 set i[8] = 8, t[8] = 'eight';
select * from arrtest1;
update arrtest1 set i[0] = 0, t[0] = 'zero';
select * from arrtest1;
update arrtest1 set i[-3] = -3, t[-3] = 'minus-three';
select * from arrtest1;
update arrtest1 set i[0:2] = array[10,11,12], t[0:2] = array['ten','eleven','twelve'];
select * from arrtest1;
update arrtest1 set i[8:10] = array[18,null,20], t[8:10] = array['p18',null,'p20'];
select * from arrtest1;
update arrtest1 set i[11:12] = array[null,22], t[11:12] = array[null,'p22'];
select * from arrtest1;
update arrtest1 set i[15:16] = array[null,26], t[15:16] = array[null,'p26'];
select * from arrtest1;
update arrtest1 set i[-5:-3] = array[-15,-14,-13], t[-5:-3] = array['m15','m14','m13'];
select * from arrtest1;
update arrtest1 set i[-7:-6] = array[-17,null], t[-7:-6] = array['m17',null];
select * from arrtest1;
update arrtest1 set i[-12:-10] = array[-22,null,-20], t[-12:-10] = array['m22',null,'m20'];
select * from arrtest1;
delete from arrtest1;
insert into arrtest1 values(array[1,2,null,4], array['one','two',null,'four']);
select * from arrtest1;
update arrtest1 set i[0:5] = array[0,1,2,null,4,5], t[0:5] = array['z','p1','p2',null,'p4','p5'];
select * from arrtest1;
CREATE TEMP TABLE arrtest2 (i integer ARRAY[4], f float8[], n numeric[], t text[], d timestamp[]);
INSERT INTO arrtest2 VALUES(
  ARRAY[[[113,142],[1,147]]],
  ARRAY[1.1,1.2,1.3]::float8[],
  ARRAY[1.1,1.2,1.3],
  ARRAY[[['aaa','aab'],['aba','abb'],['aca','acb']],[['baa','bab'],['bba','bbb'],['bca','bcb']]],
  ARRAY['19620326','19931223','19970117']::timestamp[]
);
CREATE TEMP TABLE arrtest_f (f0 int, f1 text, f2 float8);
insert into arrtest_f values(1,'cat1',1.21);
insert into arrtest_f values(2,'cat1',1.24);
insert into arrtest_f values(3,'cat1',1.18);
insert into arrtest_f values(4,'cat1',1.26);
insert into arrtest_f values(5,'cat1',1.15);
insert into arrtest_f values(6,'cat2',1.15);
insert into arrtest_f values(7,'cat2',1.26);
insert into arrtest_f values(8,'cat2',1.32);
insert into arrtest_f values(9,'cat2',1.30);
CREATE TEMP TABLE arrtest_i (f0 int, f1 text, f2 int);
insert into arrtest_i values(1,'cat1',21);
insert into arrtest_i values(2,'cat1',24);
insert into arrtest_i values(3,'cat1',18);
insert into arrtest_i values(4,'cat1',26);
insert into arrtest_i values(5,'cat1',15);
insert into arrtest_i values(6,'cat2',15);
insert into arrtest_i values(7,'cat2',26);
insert into arrtest_i values(8,'cat2',32);
insert into arrtest_i values(9,'cat2',30);
SELECT t.f[1][3][1] AS "131", t.f[2][2][1] AS "221" FROM (
  SELECT ARRAY[[[111,112],[121,122],[131,132]],[[211,212],[221,122],[231,232]]] AS f
) AS t;
SELECT ARRAY[[[[[['hello'],['world']]]]]];
SELECT ARRAY[ARRAY['hello'],ARRAY['world']];
SELECT ARRAY(select f2 from arrtest_f order by f2) AS "ARRAY";
SELECT '{1,null,3}'::int[];
SELECT ARRAY[1,NULL,3];
SELECT array_append(array[42], 6) AS "{42,6}";
SELECT array_prepend(6, array[42]) AS "{6,42}";
SELECT array_cat(ARRAY[1,2], ARRAY[3,4]) AS "{1,2,3,4}";
SELECT array_cat(ARRAY[1,2], ARRAY[[3,4],[5,6]]) AS "{{1,2},{3,4},{5,6}}";
SELECT array_cat(ARRAY[[3,4],[5,6]], ARRAY[1,2]) AS "{{3,4},{5,6},{1,2}}";
SELECT array_position(ARRAY[1,2,3,4,5], 4);
SELECT array_positions(NULL, 10);
SELECT array_length(array_positions(ARRAY(SELECT 'AAAAAAAAAAAAAAAAAAAAAAAAA'::text || i % 10
                                          FROM generate_series(1,100) g(i)),
                                  'AAAAAAAAAAAAAAAAAAAAAAAAA5'), 1);
SELECT
    array_position(ids, (1, 1)),
    array_positions(ids, (1, 1))
        FROM
(VALUES
    (ARRAY[(0, 0), (1, 1)]),
    (ARRAY[(1, 1)])
) AS f (ids);
SELECT a FROM arrtest WHERE b = ARRAY[[[113,142],[1,147]]];
SELECT NOT ARRAY[1.1,1.2,1.3] = ARRAY[1.1,1.2,1.3] AS "FALSE";
SELECT ARRAY[1,2] || 3 AS "{1,2,3}";
SELECT 0 || ARRAY[1,2] AS "{0,1,2}";
SELECT ARRAY[1,2] || ARRAY[3,4] AS "{1,2,3,4}";
SELECT ARRAY[[['hello','world']]] || ARRAY[[['happy','birthday']]] AS "ARRAY";
SELECT ARRAY[[1,2],[3,4]] || ARRAY[5,6] AS "{{1,2},{3,4},{5,6}}";
SELECT ARRAY[0,0] || ARRAY[1,1] || ARRAY[2,2] AS "{0,0,1,1,2,2}";
SELECT 0 || ARRAY[1,2] || 3 AS "{0,1,2,3}";
SELECT ARRAY[1.1] || ARRAY[2,3,4];
SELECT array_agg(x) || array_agg(x) FROM (VALUES (ROW(1,2)), (ROW(3,4))) v(x);
SELECT * FROM array_op_test WHERE i @> '{32}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i && '{32}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i @> '{17}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i && '{17}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i @> '{32,17}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i && '{32,17}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i <@ '{38,34,32,89}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i = '{}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i @> '{}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i && '{}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i <@ '{}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i = '{NULL}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i @> '{NULL}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i && '{NULL}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE i <@ '{NULL}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t @> '{AAAAAAAA72908}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t && '{AAAAAAAA72908}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t @> '{AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t && '{AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t @> '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t && '{AAAAAAAA72908,AAAAAAAAAA646}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t <@ '{AAAAAAAA72908,AAAAAAAAAAAAAAAAAAA17075,AA88409,AAAAAAAAAAAAAAAAAA36842,AAAAAAA48038,AAAAAAAAAAAAAA10611}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t = '{}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t @> '{}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t && '{}' ORDER BY seqno;
SELECT * FROM array_op_test WHERE t <@ '{}' ORDER BY seqno;
SELECT ARRAY[1,2,3]::text[]::int[]::float8[] AS "{1,2,3}";
SELECT pg_typeof(ARRAY[1,2,3]::text[]::int[]::float8[]) AS "double precision[]";
SELECT ARRAY[['a','bc'],['def','hijk']]::text[]::varchar[] AS "{{a,bc},{def,hijk}}";
SELECT pg_typeof(ARRAY[['a','bc'],['def','hijk']]::text[]::varchar[]) AS "character varying[]";
SELECT CAST(ARRAY[[[[[['a','bb','ccc']]]]]] as text[]) as "{{{{{{a,bb,ccc}}}}}}";
SELECT NULL::text[]::int[] AS "NULL";
select 33 = any ('{1,2,3}');
select 33 = any ('{1,2,33}');
select 33 = all ('{1,2,33}');
select 33 >= all ('{1,2,33}');
select null::int >= all ('{1,2,33}');
select null::int >= all ('{}');
select null::int >= any ('{}');
select 33.4 = any (array[1,2,3]);
select 33.4 > all (array[1,2,3]);
select 33 = any (null::int[]);
select null::int = any ('{1,2,3}');
select 33 = any ('{1,null,3}');
select 33 = any ('{1,null,33}');
select 33 = all (null::int[]);
select null::int = all ('{1,2,3}');
select 33 = all ('{1,null,3}');
select 33 = all ('{33,null,33}');
SELECT -1 != ALL(ARRAY(SELECT NULLIF(g.i, 900) FROM generate_series(1,1000) g(i)));
create temp table arr_tbl (f1 int[] unique);
insert into arr_tbl values ('{1,2,3}');
insert into arr_tbl values ('{1,2}');
insert into arr_tbl values ('{2,3,4}');
insert into arr_tbl values ('{1,5,3}');
insert into arr_tbl values ('{1,2,10}');
set enable_seqscan to off;
set enable_bitmapscan to off;
select * from arr_tbl where f1 > '{1,2,3}' and f1 <= '{1,5,3}';
select * from arr_tbl where f1 >= '{1,2,3}' and f1 < '{1,5,3}';
create temp table arr_pk_tbl (pk int4 primary key, f1 int[]);
insert into arr_pk_tbl values (1, '{1,2,3}');
insert into arr_pk_tbl values (1, '{3,4,5}') on conflict (pk)
  do update set f1[1] = excluded.f1[1], f1[3] = excluded.f1[3]
  returning pk, f1;
insert into arr_pk_tbl(pk, f1[1:2]) values (1, '{6,7,8}') on conflict (pk)
  do update set f1[1] = excluded.f1[1],
    f1[2] = excluded.f1[2],
    f1[3] = excluded.f1[3]
  returning pk, f1;
reset enable_seqscan;
reset enable_bitmapscan;
insert into arr_pk_tbl values(10, '[-2147483648:-2147483647]={1,2}');
select 'foo' like any (array['%a', '%o']);
select 'foo' like any (array['%a', '%b']);
select 'foo' like all (array['f%', '%o']);
select 'foo' like all (array['f%', '%b']);
select 'foo' not like any (array['%a', '%b']);
select 'foo' not like all (array['%a', '%o']);
select 'foo' ilike any (array['%A', '%O']);
select 'foo' ilike all (array['F%', '%O']);
select '{{1},{{2}}}'::text[];
select '{{{1}},{2}}'::text[];
select '[21474836488:21474836489]={1,2}'::int[];
select '{}'::text[];
select '{{{1,2,3,4},{2,3,4,5}},{{3,4,5,6},{4,5,6,7}}}'::text[];
select '{null,n\ull,"null"}'::text[];
select '{ ab\c , "ab\"c" }'::text[];
select '{0 second  ,0 second}'::interval[];
select '{ { "," } , { 3 } }'::text[];
select '  {   {  "  0 second  "   ,  0 second  }   }'::text[];
select '{
           0 second,
           @ 1 hour @ 42 minutes @ 20 seconds
         }'::interval[];
select array[]::text[];
select '[2]={1,7}'::int[];
select '[0:1]={1.1,2.2}'::float8[];
select '[2147483646:2147483646]={1}'::int[];
select '[-2147483648:-2147483647]={1,2}'::int[];
CREATE TEMP TABLE arraggtest ( f1 INT[], f2 TEXT[][], f3 FLOAT[]);
INSERT INTO arraggtest (f1, f2, f3) VALUES
('{1,2,3,4}','{{grey,red},{blue,blue}}','{1.6, 0.0}');
INSERT INTO arraggtest (f1, f2, f3) VALUES
('{1,2,3}','{{grey,red},{grey,blue}}','{1.6}');
SELECT max(f1), min(f1), max(f2), min(f2), max(f3), min(f3) FROM arraggtest;
INSERT INTO arraggtest (f1, f2, f3) VALUES
('{3,3,2,4,5,6}','{{white,yellow},{pink,orange}}','{2.1,3.3,1.8,1.7,1.6}');
INSERT INTO arraggtest (f1, f2, f3) VALUES
('{2}','{{black,red},{green,orange}}','{1.6,2.2,2.6,0.4}');
INSERT INTO arraggtest (f1, f2, f3) VALUES
('{4,2,6,7,8,1}','{{red},{black},{purple},{blue},{blue}}',NULL);
INSERT INTO arraggtest (f1, f2, f3) VALUES
('{}','{{pink,white,blue,red,grey,orange}}','{2.1,1.87,1.4,2.2}');
create type comptype as (f1 int, f2 text);
create table comptable (c1 comptype, c2 comptype[]);
insert into comptable
  values (row(1,'foo'), array[row(2,'bar')::comptype, row(3,'baz')::comptype]);
create type _comptype as enum('fooey');
select * from comptable;
select c2[2].f2 from comptable;
drop type _comptype;
drop table comptable;
drop type comptype;
create or replace function unnest1(anyarray)
returns setof anyelement as $$
select $1[s] from generate_subscripts($1,1) g(s);
$$ language sql immutable;
create or replace function unnest2(anyarray)
returns setof anyelement as $$
select $1[s1][s2] from generate_subscripts($1,1) g1(s1),
                   generate_subscripts($1,2) g2(s2);
$$ language sql immutable;
select * from unnest1(array[1,2,3]);
select * from unnest2(array[[1,2,3],[4,5,6]]);
drop function unnest1(anyarray);
drop function unnest2(anyarray);
select array_fill(null::integer, array[3,3]);
select a, a = '{}' as is_eq, array_dims(a)
  from (select array_fill(42, array[0]) as a) ss;
select string_to_array('1|2|3', '|');
select v, v is null as "is null" from string_to_table('1|2|3', '|') g(v);
select array_to_string(NULL::int4[], ',') IS NULL;
select cardinality(NULL::int[]);
select array_agg(ar)
  from (values ('{1,2}'::int[]), ('{3,4}'::int[])) v(ar);
select array_agg(distinct ar order by ar desc)
  from (select array[i / 2] from generate_series(1,10) a(i)) b(ar);
select array_agg(array[i+1.2, i+1.3, i+1.4]) from generate_series(1,3) g(i);
select unnest(array[1,2,3]);
select abs(unnest(array[1,2,null,-3]));
select array_remove(array[1,2,2,3], 2);
select array_remove(array['X','X','X'], 'X') = '{}';
select array_replace(array[1,2,5,4],5,3);
select array(select array[i,i/2] from generate_series(1,5) i);
create temp table src (f1 text);
insert into src
  select string_agg(random()::text,'') from generate_series(1,10000);
create type textandtext as (c1 text, c2 text);
create temp table dest (f1 textandtext[]);
insert into dest select array[row(f1,f1)::textandtext] from src;
delete from src;
truncate table src;
drop table src;
drop table dest;
drop type textandtext;
SELECT
    op,
    width_bucket(op, ARRAY[1, 3, 5, 10]) AS wb_1
FROM generate_series(0,11) as op;
SELECT width_bucket(now(),
                    array['yesterday', 'today', 'tomorrow']::timestamptz[]);
SELECT arr, trim_array(arr, 2)
FROM
(VALUES ('{1,2,3,4,5,6}'::bigint[]),
        ('{1,2}'),
        ('[10:16]={1,2,3,4,5,6,7}'),
        ('[-15:-10]={1,2,3,4,5,6}'),
        ('{{1,10},{2,20},{3,30},{4,40}}')) v(arr);
SELECT array_shuffle('{1,2,3,4,5,6}'::int[]) <@ '{1,2,3,4,5,6}';
SELECT array_shuffle('{1,2,3,4,5,6}'::int[]) @> '{1,2,3,4,5,6}';
SELECT array_sample('{1,2,3,4,5,6}'::int[], 3) <@ '{1,2,3,4,5,6}';
