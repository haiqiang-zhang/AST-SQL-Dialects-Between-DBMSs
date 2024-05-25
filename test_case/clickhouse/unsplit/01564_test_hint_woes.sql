create table values_01564(
    a int,
    constraint c1 check a < 10) engine Memory;
select 1;
select 1;
select 1;
insert into values_01564 values (1);
select 1;
select 1;
CREATE TABLE t0 (c0 String, c1 Int32) ENGINE = Memory();
INSERT INTO t0(c0, c1) VALUES ('1', 1);
drop table t0;
drop table values_01564;
