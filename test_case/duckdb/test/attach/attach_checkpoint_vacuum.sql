ATTACH '__TEST_DIR__/attach_vacuum.db' AS db1;
CHECKPOINT db1;
VACUUM db1.integers;
