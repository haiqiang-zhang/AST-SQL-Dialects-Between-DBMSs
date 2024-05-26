select makeDateTime(1991, 8, 24, 21, 4, 0);
select cast(makeDateTime(1991, 8, 24, 21, 4, 0, 'CET') as DateTime('UTC'));
select toTypeName(makeDateTime(1991, 8, 24, 21, 4, 0));
