select makeDateTime64(1991, 8, 24, 21, 4, 0);
select cast(makeDateTime64(1991, 8, 24, 21, 4, 0, 1234, 7, 'CET') as DateTime64(7, 'UTC'));
select toTypeName(makeDateTime64(1991, 8, 24, 21, 4, 0));
