BEGIN TRANSACTION;
CREATE SCHEMA my_schema;
CREATE MACRO my_schema.my_range(x, y := 7) AS TABLE SELECT range + x i FROM range(y);
CREATE MACRO my_schema.elaborate_macro(x, y := 7) AS x + y + (SELECT max(i) FROM my_schema.my_range(0, y := 10));
CREATE MACRO my_schema.my_other_range(x) AS TABLE SELECT * FROM my_schema.my_range(x, y := 3);
EXPORT DATABASE '__TEST_DIR__/export_macros' (FORMAT CSV);;
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_macros';
SELECT my_schema.elaborate_macro(28, y := 5);
SELECT max(i) FROM my_schema.my_range(33, y := 10);
SELECT max(i) FROM my_schema.my_other_range(40);
