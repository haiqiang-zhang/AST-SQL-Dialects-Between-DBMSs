PRAGMA enable_profiling;
PRAGMA profiling_output='__TEST_DIR__/test.json';
PRAGMA profiling_mode = detailed;
CREATE TABLE integers(i INTEGER);
INSERT INTO integers VALUES (3);
