EXPORT DATABASE '__TEST_DIR__/export_special_functions' (FORMAT CSV);
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_special_functions';
