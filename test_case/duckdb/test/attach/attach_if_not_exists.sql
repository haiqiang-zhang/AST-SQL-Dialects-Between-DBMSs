ATTACH '__TEST_DIR__/attach_if_not_exists.db' AS db1;
ATTACH IF NOT EXISTS '__TEST_DIR__/attach_if_not_exists.db' AS db1;
ATTACH IF NOT EXISTS ':memory:' AS db1;
DETACH db1;
ATTACH '__TEST_DIR__/attach_if_not_exists.db' AS db1 (READ_WRITE);
ATTACH IF NOT EXISTS '__TEST_DIR__/attach_if_not_exists.db' AS db1;
DETACH db1;
ATTACH '__TEST_DIR__/attach_if_not_exists.db' AS db1 (READ_ONLY);
ATTACH IF NOT EXISTS '__TEST_DIR__/attach_if_not_exists.db' AS db1;
