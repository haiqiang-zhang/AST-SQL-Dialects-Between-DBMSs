SELECT * FROM enum_test ORDER BY timestamp, e desc SETTINGS optimize_read_in_order=1;
DROP TABLE IF EXISTS enum_test;
