DROP TABLE IF EXISTS numbers500k;
CREATE VIEW numbers500k AS SELECT number FROM system.numbers LIMIT 500000;
SET max_query_size = 1073741824;
DROP TABLE numbers500k;
