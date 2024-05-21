create table values_01564(
    a int,
    constraint c1 check a < 10) engine Memory;
insert into values_01564 values ('f');
insert into values_01564 values ('f');
select 1;
insert into values_01564 values ('f');
select nonexistent column;
-- syntax error hint after broken insert values
insert into values_01564 this is bad syntax values ('f');
insert into values_01564 this is bad syntax values ('f');
select 1;
insert into values_01564 this is bad syntax values ('f');
select nonexistent column;
-- server error hint after broken insert values (violated constraint)
insert into values_01564 values (11);
insert into values_01564 values (11);
select 1;
insert into values_01564 values (11);
select nonexistent column;
-- query after values on the same line
insert into values_01564 values (1);
select 1;
-- insert into values_01564 values (11) /*{ serverError 469 }*/;
select 1;
select this is too many words for an alias;
OPTIMIZE TABLE values_01564 DEDUPLICATE BY;
OPTIMIZE TABLE values_01564 DEDUPLICATE BY a EXCEPT a;
select 'a' || distinct one || 'c' from system.one;
-- a failing insert and then a normal insert (#https://github.com/ClickHouse/ClickHouse/issues/19353)
CREATE TABLE t0 (c0 String, c1 Int32) ENGINE = Memory();
INSERT INTO t0(c0, c1) VALUES ("1",1);
INSERT INTO t0(c0, c1) VALUES ('1', 1);
insert into values_01564 values (11);
drop table t0;
drop table values_01564;