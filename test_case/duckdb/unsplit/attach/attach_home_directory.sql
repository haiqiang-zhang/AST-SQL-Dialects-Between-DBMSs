PRAGMA enable_verification;
ATTACH '__TEST_DIR__/home_dir.db' AS s1;
CREATE TABLE s1.integers AS FROM range(10) t(i);;
DETACH s1;
SET home_directory='__TEST_DIR__';
ATTACH '~/home_dir.db' AS s1;
DETACH s1;
SELECT SUM(i) FROM s1.integers;
SELECT SUM(i) FROM s1.integers;
