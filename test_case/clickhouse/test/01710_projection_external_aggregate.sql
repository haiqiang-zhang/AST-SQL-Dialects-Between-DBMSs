SET max_bytes_before_external_group_by=1;
INSERT INTO agg SELECT 1, toDateTime('2021-12-06 00:00:00') + number, number FROM numbers(100000);
DROP TABLE agg;
