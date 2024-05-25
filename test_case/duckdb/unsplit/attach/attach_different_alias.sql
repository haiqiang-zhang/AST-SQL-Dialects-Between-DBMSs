PRAGMA enable_verification;
ATTACH '__TEST_DIR__/attach_alias.db' AS alias1;
DETACH alias1;
ATTACH '__TEST_DIR__/attach_alias.db' AS alias2;
FROM alias2.tbl1;
