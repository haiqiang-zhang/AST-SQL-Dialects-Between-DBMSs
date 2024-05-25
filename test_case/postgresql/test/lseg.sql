select * from LSEG_TBL;
SELECT pg_input_is_valid('[(1,2),(3)]', 'lseg');
SELECT * FROM pg_input_error_info('[(1,2),(3)]', 'lseg');
