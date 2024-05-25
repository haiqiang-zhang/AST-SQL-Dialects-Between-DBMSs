PRAGMA verify_parallelism;
pragma threads=4;
CREATE TABLE bigdata AS SELECT i AS col_a, i AS col_b FROM range(0,10000) tbl(i);
SELECT COUNT(*) FROM PARQUET_SCAN('__TEST_DIR__/per_thread_output/*.parquet');
SELECT STR_SPLIT(REPLACE(file, '\','/'), '/')[-1]  f FROM GLOB('__TEST_DIR__/per_thread_output/*.parquet') ORDER BY f;
SELECT COUNT(*) FROM read_csv('__TEST_DIR__/per_thread_output_csv/*.csv', columns={'col_a': 'INT', 'col_b' : 'INT'});
SELECT STR_SPLIT(REPLACE(file, '\','/'), '/')[-1]  f FROM GLOB('__TEST_DIR__/per_thread_output_csv/*.csv') ORDER BY f;
SELECT COUNT(*) FROM PARQUET_SCAN('__TEST_DIR__/per_thread_output2/*.parquet');
SELECT COUNT(*) FROM PARQUET_SCAN('__TEST_DIR__/per_thread_output2/*.parquet');
