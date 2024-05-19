



SELECT 1 as one, 2 as two \g
SELECT 3 as three, 4 as four \gx


SELECT 1 as one, 2 as two \g
SELECT 3 as three, 4 as four \gx



SELECT 1 as one, 2 as two \g (format=csv csv_fieldsep='\t')
SELECT 1 as one, 2 as two \gx (title='foo bar')


SELECT 1 \bind \g
SELECT $1 \bind 'foo' \g
SELECT $1, $2 \bind 'foo' 'bar' \g

SELECT foo \bind \g
SELECT 1 \; SELECT 2 \bind \g
SELECT $1, $2 \bind 'foo' \g


select 10 as test01, 20 as test02, 'Hello' as test03 \gset pref01_


select 10 as "bad name"

select 97 as "EOF", 'ok' as _foo \gset IGNORE

select 1 as x, 2 as y \gset pref01_ \\ \echo :pref01_x
select 3 as x, 4 as y \gset pref01_ \echo :pref01_x \echo :pref01_y
select 5 as x, 6 as y \gset pref01_ \\ \g \echo :pref01_x :pref01_y
select 7 as x, 8 as y \g \gset pref01_ \echo :pref01_x :pref01_y

select 1 as var1, NULL as var2, 3 as var3 \gset

select 10 as test01, 20 as test02 from generate_series(1,3) \gset
select 10 as test01, 20 as test02 from generate_series(1,0) \gset

select a from generate_series(1, 10) as a where a = 11 \gset


select 1 as x, 2 as y \gset pref01_ \\ \echo :pref01_x
select 3 as x, 4 as y \gset pref01_ \echo :pref01_x \echo :pref01_y
select 10 as test01, 20 as test02 from generate_series(1,3) \gset
select 10 as test01, 20 as test02 from generate_series(1,0) \gset



SELECT
    NULL AS zero,
    1 AS one,
    2.0 AS two,
    'three' AS three,
    $1 AS four,
    sin($2) as five,
    'foo'::varchar(4) as six,
    CURRENT_DATE AS now

PREPARE test AS SELECT 1 AS first, 2 AS second;
EXECUTE test \gdesc
EXPLAIN EXECUTE test \gdesc

SELECT 1 + \gdesc

SELECT \gdesc
CREATE TABLE bububu(a int) \gdesc

TABLE bububu;  

SELECT 1 AS x, 'Hello', 2 AS y, true AS "dirty\name"

SELECT 3 AS x, 'Hello', 4 AS y, true AS "dirty\name" \gdesc \g

set search_path = default;
begin;
bogus;
;
rollback;


create temporary table gexec_test(a int, b text, c date, d float);
select format('create index on gexec_test(%I)', attname)
from pg_attribute
where attrelid = 'gexec_test'::regclass and attnum > 0
order by attnum


select 'select 1 as ones', 'select x.y, x.y*2 as double from generate_series(1,4) as x(y)'
union all
select 'drop table gexec_test', NULL
union all
select 'drop table gexec_test', 'select ''2000-01-01''::date as party_over'





prepare q as select array_to_string(array_agg(repeat('x',2*n)),E'\n') as "ab

c", array_to_string(array_agg(repeat('y',20-2*n)),E'\n') as "a
bc" from generate_series(1,10) as n(n) group by n>1 order by n>1;



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
CREATE ROLE regress_display_role;
ALTER SCHEMA tableam_display OWNER TO regress_display_role;
SET search_path TO tableam_display;
CREATE ACCESS METHOD heap_psql TYPE TABLE HANDLER heap_tableam_handler;
SET ROLE TO regress_display_role;
CREATE TABLE tbl_heap_psql(f1 int, f2 char(100)) using heap_psql;
CREATE TABLE tbl_heap(f1 int, f2 char(100)) using heap;
CREATE VIEW view_heap_psql AS SELECT f1 from tbl_heap_psql;
CREATE MATERIALIZED VIEW mat_view_heap_psql USING heap_psql AS SELECT f1 from tbl_heap_psql;
RESET ROLE;
RESET search_path;
DROP SCHEMA tableam_display CASCADE;
DROP ACCESS METHOD heap_psql;
DROP ROLE regress_display_role;



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

select 'comma,comma' as comma, 'semi;semi' as semi;
select 'comma,comma' as comma, 'semi;semi' as semi;
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
  not okay;
  still not okay


select
    42
    (bogus
  forty_two;

select \if false \\ (bogus \else \\ 42 \endif \\ forty_two;














	:try_to_quit
	SELECT $1 \bind 1 \g
	SELECT 1 as one, 2, 3 \crosstabview
	SELECT 1 AS one \gset



SELECT :{?i} AS i_is_defined;

SELECT NOT :{?no_such_var} AS no_such_var_is_not_defined;


do $$
begin
  raise notice 'foo';
  raise exception 'bar';
end $$;

do $$
begin
  raise notice 'foo';
  raise exception 'bar';
end $$;

do $$
begin
  raise notice 'foo';
  raise exception 'bar';
end $$;

SELECT 1;
SELECT 2 \r
SELECT 3 \p
UNION SELECT 4 \p
UNION SELECT 5
ORDER BY 1;


SELECT 1 AS stuff UNION SELECT 2;

SELECT 1 UNION;

;

DROP TABLE this_table_does_not_exist;

SELECT 1 UNION;

SELECT 1/0;


SELECT 3 AS three, 4 AS four \gdesc

SELECT 4 AS \gdesc

select unique2 from tenk1 order by unique2 limit 19;

select 1/(15-unique2) from tenk1 order by unique2 limit 19;


create schema testpart;
create role regress_partitioning_role;

alter schema testpart owner to regress_partitioning_role;

set role to regress_partitioning_role;

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
drop role regress_partitioning_role;



set work_mem = 10240;
reset work_mem;


create role regress_psql_user superuser;
begin;
set session authorization regress_psql_user;

create function psql_df_internal (float8)
  returns float8
  language internal immutable parallel safe strict
  as 'dsin';
create function psql_df_sql (x integer)
  returns integer
  security definer
  begin atomic select x + 1; end;
create function psql_df_plpgsql ()
  returns void
  language plpgsql
  as $$ begin return; end; $$;
comment on function psql_df_plpgsql () is 'some comment';

rollback;
drop role regress_psql_user;



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
SELECT * FROM ac_test;  


CREATE TABLE oer_test (a int);

BEGIN;
INSERT INTO oer_test VALUES (1);
INSERT INTO oer_test VALUES ('foo');
INSERT INTO oer_test VALUES (3);
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

SELECT * FROM notexists;

CREATE FUNCTION warn(msg TEXT) RETURNS BOOLEAN LANGUAGE plpgsql
AS $$
  BEGIN RAISE NOTICE 'warn %', msg ; RETURN TRUE ; END
$$;

SELECT 1 AS one \; SELECT warn('1.5') \; SELECT 2 AS two ;
SELECT 3 AS three \; SELECT warn('3.5') \; SELECT 4 AS four \gset
SELECT 5 \; SELECT 6 + \; SELECT warn('6.5') \; SELECT 7 ;
BEGIN \; SELECT 8 AS eight \; SELECT 9/0 AS nine \; ROLLBACK \; SELECT 10 AS ten ;
ROLLBACK;

SELECT 'ok' AS "begin" \;
CREATE TABLE psql_comics(s TEXT) \;
INSERT INTO psql_comics VALUES ('Calvin'), ('hobbes') \;
COPY psql_comics FROM STDIN \;
UPDATE psql_comics SET s = 'Hobbes' WHERE s = 'hobbes' \;
DELETE FROM psql_comics WHERE s = 'Moe' \;
COPY psql_comics TO STDOUT \;
TRUNCATE psql_comics \;
DROP TABLE psql_comics \;
SELECT 'ok' AS "done" ;
Moe
Susie

SELECT 1 AS one \; SELECT warn('1.5') \; SELECT 2 AS two ;

DROP FUNCTION warn(TEXT);


CREATE TEMPORARY TABLE reload_output(
  lineno int NOT NULL GENERATED ALWAYS AS IDENTITY,
  line text
);

SELECT 1 AS a \g :g_out_file
COPY reload_output(line) FROM :'g_out_file';
SELECT 2 AS b\; SELECT 3 AS c\; SELECT 4 AS d \g :g_out_file
COPY reload_output(line) FROM :'g_out_file';
COPY (SELECT 'foo') TO STDOUT \; COPY (SELECT 'bar') TO STDOUT \g :g_out_file
COPY reload_output(line) FROM :'g_out_file';

SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;


SELECT max(unique1) FROM onek;
SELECT 1 AS a\; SELECT 2 AS b\; SELECT 3 AS c;

COPY (SELECT unique1 FROM onek ORDER BY unique1 LIMIT 10) TO :'g_out_file';
UPDATE onek SET unique1 = unique1 WHERE false;

COPY reload_output(line) FROM :'g_out_file';
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;
COPY reload_output(line) FROM :'o_out_file';
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;

COPY (SELECT 'foo1') TO STDOUT \; COPY (SELECT 'bar1') TO STDOUT;
COPY (SELECT 'foo2') TO STDOUT \; COPY (SELECT 'bar2') TO STDOUT \g :g_out_file

COPY reload_output(line) FROM :'g_out_file';
SELECT line FROM reload_output ORDER BY lineno;
TRUNCATE TABLE reload_output;
COPY reload_output(line) FROM :'o_out_file';
SELECT line FROM reload_output ORDER BY lineno;

DROP TABLE reload_output;


CREATE TABLE foo(s TEXT) \;
ROLLBACK;

CREATE TABLE foo(s TEXT) \;
INSERT INTO foo(s) VALUES ('hello'), ('world') \;
COMMIT;

DROP TABLE foo \;
ROLLBACK;

SELECT * FROM foo ORDER BY 1 \;
DROP TABLE foo \;
COMMIT;


BEGIN \;
CREATE TABLE foo(s TEXT) \;
INSERT INTO foo(s) VALUES ('hello'), ('world') \;
COMMIT;

BEGIN \;
DROP TABLE foo \;
ROLLBACK \;

SELECT * FROM foo ORDER BY 1 \;
DROP TABLE foo;

CREATE FUNCTION psql_error(msg TEXT) RETURNS BOOLEAN AS $$
  BEGIN
    RAISE EXCEPTION 'error %', msg;
  END;
$$ LANGUAGE plpgsql;


BEGIN;
CREATE TABLE bla(s NO_SUCH_TYPE);               
CREATE TABLE bla(s TEXT);                       
SELECT psql_error('oops!');                     
INSERT INTO bla VALUES ('Calvin'), ('Hobbes');
COMMIT;

SELECT * FROM bla ORDER BY 1;

BEGIN;
INSERT INTO bla VALUES ('Susie');         
INSERT INTO bla VALUES ('Rosalyn') \;     
SELECT 'before error' AS show \;          
  SELECT psql_error('boum!') \;           
  SELECT 'after error' AS noshow;         
INSERT INTO bla(s) VALUES ('Moe') \;      
  SELECT psql_error('bam!');
INSERT INTO bla VALUES ('Miss Wormwood'); 
COMMIT;
SELECT * FROM bla ORDER BY 1;


INSERT INTO bla VALUES ('Dad');           
SELECT psql_error('bad!');                

INSERT INTO bla VALUES ('Mum') \;         
SELECT COUNT(*) AS "#mum"
FROM bla WHERE s = 'Mum' \;               
SELECT psql_error('bad!');                
COMMIT;

SELECT COUNT(*) AS "#mum"
FROM bla WHERE s = 'Mum' \;               
SELECT * FROM bla ORDER BY 1;
COMMIT;

DROP TABLE bla;
DROP FUNCTION psql_error;






CREATE ROLE regress_du_role0;
CREATE ROLE regress_du_role1;
CREATE ROLE regress_du_role2;
CREATE ROLE regress_du_admin;

GRANT regress_du_role0 TO regress_du_admin WITH ADMIN TRUE;
GRANT regress_du_role1 TO regress_du_admin WITH ADMIN TRUE;
GRANT regress_du_role2 TO regress_du_admin WITH ADMIN TRUE;

GRANT regress_du_role0 TO regress_du_role1 WITH ADMIN TRUE,  INHERIT TRUE,  SET TRUE  GRANTED BY regress_du_admin;
GRANT regress_du_role0 TO regress_du_role2 WITH ADMIN TRUE,  INHERIT FALSE, SET FALSE GRANTED BY regress_du_admin;
GRANT regress_du_role1 TO regress_du_role2 WITH ADMIN TRUE , INHERIT FALSE, SET TRUE  GRANTED BY regress_du_admin;
GRANT regress_du_role0 TO regress_du_role1 WITH ADMIN FALSE, INHERIT TRUE,  SET FALSE GRANTED BY regress_du_role1;
GRANT regress_du_role0 TO regress_du_role2 WITH ADMIN FALSE, INHERIT TRUE , SET TRUE  GRANTED BY regress_du_role1;
GRANT regress_du_role0 TO regress_du_role1 WITH ADMIN FALSE, INHERIT FALSE, SET TRUE  GRANTED BY regress_du_role2;
GRANT regress_du_role0 TO regress_du_role2 WITH ADMIN FALSE, INHERIT FALSE, SET FALSE GRANTED BY regress_du_role2;


DROP ROLE regress_du_role0;
DROP ROLE regress_du_role1;
DROP ROLE regress_du_role2;
DROP ROLE regress_du_admin;

BEGIN;
CREATE ROLE regress_zeropriv_owner;
SET LOCAL ROLE regress_zeropriv_owner;

CREATE DOMAIN regress_zeropriv_domain AS int;
REVOKE ALL ON DOMAIN regress_zeropriv_domain FROM CURRENT_USER, PUBLIC;

CREATE PROCEDURE regress_zeropriv_proc() LANGUAGE sql AS '';
REVOKE ALL ON PROCEDURE regress_zeropriv_proc() FROM CURRENT_USER, PUBLIC;

CREATE TABLE regress_zeropriv_tbl (a int);
REVOKE ALL ON TABLE regress_zeropriv_tbl FROM CURRENT_USER;

CREATE TYPE regress_zeropriv_type AS (a int);
REVOKE ALL ON TYPE regress_zeropriv_type FROM CURRENT_USER, PUBLIC;

ROLLBACK;

CREATE TABLE defprivs (a int);
DROP TABLE defprivs;
