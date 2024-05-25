DROP TABLE IF EXISTS t1, `t``1`, `t 1`;
drop view if exists v1;
drop database if exists client_test_db;
create view v1 as select * from information_schema.routines;
drop view v1;
DROP DATABASE IF EXISTS b12688860_db;
CREATE DATABASE b12688860_db;
DROP DATABASE b12688860_db;
