TRUNCATE TABLE data_02716_1;
DROP TABLE IF EMPTY data_02716_1;
SELECT count() FROM system.tables WHERE database = 'default' AND name IN ('data_02716_1', 'data_02716_2');
