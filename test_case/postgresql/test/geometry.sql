SELECT pg_input_is_valid('(1', 'circle');
SELECT * FROM pg_input_error_info('1,', 'circle');
