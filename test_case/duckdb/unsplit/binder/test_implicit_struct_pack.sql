pragma enable_verification;
create table test as select range i from range(3);
select main.test from main.test t;
select main.t from main.test t;
create table main as select 3 test;
create table structs as select {test: 4} main;
select test from test;
select test from main.test

query T nosort q0
select main.test from main.test

query T nosort q0
SELECT t FROM test AS t

query T nosort q0
select t from (SELECT * FROM test) AS t

# shouldn't work
statement error
select main.test from main.test t;
WITH data AS (
    SELECT 1 as a, 2 as b, 3 as c
)
SELECT d FROM data d;
select main.test from main, test;
select test from main, test;
select main.test from structs, test;
