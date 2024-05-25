SET extra_float_digits TO -3;
SELECT pg_input_is_valid('(1', 'circle');
SELECT * FROM pg_input_error_info('1,', 'circle');
SELECT pg_input_is_valid('(1,2),-1', 'circle');
SELECT * FROM pg_input_error_info('(1,2),-1', 'circle');
