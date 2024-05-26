SELECT f1 AS open_path FROM PATH_TBL WHERE isopen(f1);
SELECT f1 AS closed_path FROM PATH_TBL WHERE isclosed(f1);
SELECT pclose(f1) AS closed_path FROM PATH_TBL;
SELECT popen(f1) AS open_path FROM PATH_TBL;
SELECT pg_input_is_valid('[(1,2),(3)]', 'path');
SELECT * FROM pg_input_error_info('[(1,2),(3)]', 'path');
