SELECT 42;
PRAGMA disable_profiling;
PRAGMA profiling_output='__TEST_DIR__/test_2.json';
PRAGMA profiling_output='__TEST_DIR__/test.json';
PRAGMA enable_profiling='json';
PRAGMA disable_profiling;
PRAGMA profiling_output='__TEST_DIR__/test_2.json';
