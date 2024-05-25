pragma enable_verification;
create table test as select range i from range(3);
create table main as select 3 test;
create table structs as select {test: 4} main;
select test from test;
WITH data AS (
    SELECT 1 as a, 2 as b, 3 as c
)
SELECT d FROM data d;
select main.test from main, test;
select test from main, test;
select main.test from structs, test;
