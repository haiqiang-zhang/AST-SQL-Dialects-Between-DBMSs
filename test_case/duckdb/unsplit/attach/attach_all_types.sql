ATTACH '__TEST_DIR__/attach_all_types.db' AS db1;
CREATE TABLE db1.all_types AS SELECT * FROM test_all_types();;
DETACH db1;
ATTACH '__TEST_DIR__/attach_all_types.db' AS db1;
