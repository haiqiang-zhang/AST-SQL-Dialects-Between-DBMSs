select * from LINE_TBL;
select '{nan, 1, nan}'::line = '{nan, 1, nan}'::line as true,
	   '{nan, 1, nan}'::line = '{nan, 2, nan}'::line as false;
SELECT pg_input_is_valid('{1, 1}', 'line');
SELECT * FROM pg_input_error_info('{1, 1}', 'line');
