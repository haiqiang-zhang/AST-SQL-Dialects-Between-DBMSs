PRAGMA temp_directory='';
PRAGMA memory_limit='2MB';
PRAGMA temp_directory='__TEST_DIR__/myfile.tmp';
CREATE TABLE t2 AS SELECT * FROM range(1000000);
