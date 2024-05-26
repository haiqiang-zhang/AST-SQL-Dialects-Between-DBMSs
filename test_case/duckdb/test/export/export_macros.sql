EXPORT DATABASE '__TEST_DIR__/export_macros' (FORMAT CSV);
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_macros';
SELECT my_schema.elaborate_macro(28, y := 5);
SELECT max(i) FROM my_schema.my_range(33, y := 10);
SELECT max(i) FROM my_schema.my_other_range(40);
