ATTACH '__TEST_DIR__/reattach_schema.db' AS new_db;
INSERT INTO new_db.my_schema.my_table VALUES (42);
DETACH new_db;
ATTACH '__TEST_DIR__/reattach_schema.db' AS new_name;
USE new_name.my_schema;
SELECT * FROM new_name.my_schema.my_view;
SELECT new_name.my_schema.one();
SELECT * FROM my_view;
SELECT one();
