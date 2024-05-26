pragma enable_verification;
create table test as select range i from range(3);
create table main as select 3 test;
create table structs as select {test: 4} main;
