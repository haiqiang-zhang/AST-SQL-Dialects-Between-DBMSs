copy (select '{"a": {}}') to '__TEST_DIR__/my.json' (FORMAT CSV, quote '', header 0);
copy (select unnest(['{"c1":"val11","c2":{"k1":"val11","k2":{}}}','{"c1":"val21","c2":{"k1":"val21","k2":{}}}'])) to '__TEST_DIR__/data.ndjson' (FORMAT CSV, quote '', header 0);
CREATE OR REPLACE TABLE tbl AS SELECT * FROM read_ndjson_auto('__TEST_DIR__/data.ndjson');
copy tbl to '__TEST_DIR__/data.parquet';
select json_structure('{}');
select typeof(a) from '__TEST_DIR__/my.json';
select typeof(c1), typeof(c2) from tbl;
select * from '__TEST_DIR__/data.parquet';
