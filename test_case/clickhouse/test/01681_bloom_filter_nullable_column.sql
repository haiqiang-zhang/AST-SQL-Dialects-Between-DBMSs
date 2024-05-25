SELECT 'NullableTuple with transform_null_in=0';
SELECT * FROM bloom_filter_nullable_index WHERE str IN
    (SELECT '1048576', str FROM bloom_filter_nullable_index) SETTINGS transform_null_in = 0;
SELECT * FROM bloom_filter_nullable_index WHERE str IN
    (SELECT '1048576', str FROM bloom_filter_nullable_index) SETTINGS transform_null_in = 0;
SELECT 'NullableTuple with transform_null_in=1';
SELECT 'NullableColumnFromCast with transform_null_in=0';
SELECT * FROM bloom_filter_nullable_index WHERE str IN
    (SELECT cast('test', 'Nullable(String)')) SETTINGS transform_null_in = 0;
SELECT 'NullableColumnFromCast with transform_null_in=1';
SELECT * FROM bloom_filter_nullable_index WHERE str IN
    (SELECT cast('test', 'Nullable(String)')) SETTINGS transform_null_in = 1;
DROP TABLE IF EXISTS nullable_string_value;
CREATE TABLE nullable_string_value (value Nullable(String)) ENGINE=TinyLog;
INSERT INTO nullable_string_value VALUES ('test');
SELECT 'NullableColumnFromTable with transform_null_in=0';
SELECT * FROM bloom_filter_nullable_index WHERE str IN
    (SELECT value FROM nullable_string_value) SETTINGS transform_null_in = 0;
SELECT 'NullableColumnFromTable with transform_null_in=1';
SELECT * FROM bloom_filter_nullable_index WHERE str IN
    (SELECT value FROM nullable_string_value) SETTINGS transform_null_in = 1;
DROP TABLE nullable_string_value;
DROP TABLE bloom_filter_nullable_index;
