select * from numbers(100) settings max_result_rows = 1;
SET max_result_rows = 1;
select * from numbers(10);
select * from numbers(10) settings max_result_rows = 10;