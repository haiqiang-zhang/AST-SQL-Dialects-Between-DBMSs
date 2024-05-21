create table ec0 (ff int8 primary key, f1 int8, f2 int8);
set enable_hashjoin = off;
set enable_mergejoin = off;
explain (costs off)
  select * from ec0 where ff = f1 and f1 = '42'::int8;
set enable_mergejoin = on;
set enable_nestloop = off;
set enable_nestloop = on;
set enable_mergejoin = off;
set enable_mergejoin = on;
set enable_nestloop = off;
set enable_nestloop = on;
set enable_mergejoin = off;
reset session authorization;
set enable_mergejoin to off;
reset enable_mergejoin;
create temp table undername (f1 name, f2 int);
create temp view overview as
  select f1::information_schema.sql_identifier as sqli, f2 from undername;
explain (costs off)  
  select * from overview where sqli = 'foo' order by sqli;
