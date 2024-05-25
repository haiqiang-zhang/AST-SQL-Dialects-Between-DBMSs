BEGIN TRANSACTION;
CREATE TABLE integers(i INTEGER, j INTEGER, CHECK(i+j<10));
EXPORT DATABASE '__TEST_DIR__/export_permissions_test' (FORMAT CSV);
ROLLBACK;
SET enable_external_access=false;
