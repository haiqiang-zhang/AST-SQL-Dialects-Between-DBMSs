select sumIf(42, (a % 2) = 0) from T;
select sumIf(42, toNullable(1)) from T;
drop table if exists T;
