SELECT COUNT(*) FROM point_gist_tbl WHERE f1 ~= '(0.0000009,0.0000009)'::point;
SET enable_seqscan TO false;
SET enable_indexscan TO true;
SET enable_bitmapscan TO true;
RESET enable_seqscan;
RESET enable_indexscan;
RESET enable_bitmapscan;
SELECT pg_input_is_valid('1,y', 'point');
SELECT * FROM pg_input_error_info('1,y', 'point');
