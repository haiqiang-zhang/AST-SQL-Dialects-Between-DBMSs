drop table if exists tab;
create table tab (a Int32, b Int32, c Int32, d Int32) engine = MergeTree order by (a, b, c);
insert into tab select 0, number % 3, 2 - intDiv(number, 3), (number % 3 + 1) * 10 from numbers(6);
insert into tab select 0, number % 3, 2 - intDiv(number, 3), (number % 3 + 1) * 100 from numbers(6);
