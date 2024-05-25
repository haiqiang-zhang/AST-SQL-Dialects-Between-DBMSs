PRAGMA enable_verification;
ATTACH '__TEST_DIR__/home_dir.db' AS s1;
DETACH s1;
SET home_directory='__TEST_DIR__';
ATTACH '~/home_dir.db' AS s1;
DETACH s1;
