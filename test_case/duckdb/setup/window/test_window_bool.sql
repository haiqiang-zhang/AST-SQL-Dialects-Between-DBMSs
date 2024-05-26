PRAGMA enable_verification;
create table a as select range%2==0 j, range::integer AS i from range(1, 5, 1);
drop table a;
create table a as select range%2 j, range%3==0 AS i from range(1, 5, 1);
