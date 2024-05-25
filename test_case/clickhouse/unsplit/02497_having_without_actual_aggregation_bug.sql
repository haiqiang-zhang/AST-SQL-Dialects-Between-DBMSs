SET allow_experimental_analyzer = 1;
select number from numbers_mt(10) having number >= 9;
select count() from numbers_mt(100) having count() > 1;
