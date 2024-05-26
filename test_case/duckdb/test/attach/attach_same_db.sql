ATTACH '__TEST_DIR__/attach_same_db.db' AS db1;
BEGIN;
DETACH db1;
ATTACH '__TEST_DIR__/attach_same_db.db' AS db1;
COMMIT;
