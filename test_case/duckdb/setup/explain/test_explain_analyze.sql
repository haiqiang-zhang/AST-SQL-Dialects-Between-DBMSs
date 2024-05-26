PRAGMA enable_verification;
CREATE TABLE integers AS SELECT * FROM range(100) tbl(i);
PRAGMA enable_profiling;
PRAGMA disable_profiling;
PRAGMA profiling_output='__TEST_DIR__/test.json';
PRAGMA enable_profiling='json';
