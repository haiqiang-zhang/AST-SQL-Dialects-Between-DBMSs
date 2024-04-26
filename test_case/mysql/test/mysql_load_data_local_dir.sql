--

let $test_dir=$MYSQLTEST_VARDIR/tmp/wl13168;
let $wrong_test_dir=$MYSQLTEST_VARDIR/tmp/wl13168_2;
let $nonexistent_test_dir=$MYSQLTEST_VARDIR/tmp/wl13168_3;
let $test_file=$MYSQLTEST_VARDIR/tmp/wl13168/t1;
let $test_file_wrong_case=$MYSQLTEST_VARDIR/tmp/wl13168/T1;
let $test_file_wrong_file=$MYSQLTEST_VARDIR/tmp/wl13168/t2;
let $test_file_wrong_dir=$wrong_test_dir/t1;
let $test_file_wrong_dir_case=$MYSQLTEST_VARDIR/Tmp/wl13168/t1;
1,a
2,b
EOF
--echo -- create the wrong test file
--write_file $test_file_wrong_file
1,a
2,b
EOF
--echo -- create a file in wrong dir
--write_file $test_file_wrong_dir
1,a
2,b
EOF

--echo -- setup
CREATE TABLE test.wl13168(id INT PRIMARY KEY, data VARCHAR(50));
SELECT * FROM test.wl13168 ORDER BY id;
DELETE FROM test.wl13168;
SELECT * FROM test.wl13168 ORDER BY id;
SELECT * FROM test.wl13168 ORDER BY id;
SELECT * FROM test.wl13168 ORDER BY id;
DELETE FROM test.wl13168;
SELECT * FROM test.wl13168 ORDER BY id;
SELECT * FROM test.wl13168 ORDER BY id;
SELECT * FROM test.wl13168 ORDER BY id;
DELETE FROM test.wl13168;
let expected_error=`SELECT if (CONVERT(@@version_compile_os USING LATIN1) RLIKE '^(osx|macos)', 0, 1)`;
DELETE FROM test.wl13168;
DELETE FROM test.wl13168;
let expected_error=`select if (convert(@@version_compile_os using latin1) IN ("Win32","Win64","Windows") = 1, 0, 1)`;

SET @@global.local_infile = 0;
SELECT * FROM test.wl13168 ORDER BY id;
DROP TABLE test.wl13168;
SET @@global.local_infile = 1;
