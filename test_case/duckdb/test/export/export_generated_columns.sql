EXPORT DATABASE '__TEST_DIR__/export_generated_columns' (FORMAT CSV);
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_generated_columns';
SELECT * FROM tbl;
