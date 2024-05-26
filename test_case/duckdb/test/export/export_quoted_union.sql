EXPORT DATABASE '__TEST_DIR__/export_test' (FORMAT CSV);
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_test';
select * from a;
select * from a;
select union_tag(COLUMNS(*)) from a;
