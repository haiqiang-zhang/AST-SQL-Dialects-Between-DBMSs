drop table if exists T;
create table T(a Nullable(Int64)) engine = Memory();
insert into T values (1), (2), (3), (4), (5);
select sumIf(42, (a % 2) = 0) from T;
drop table if exists T;
