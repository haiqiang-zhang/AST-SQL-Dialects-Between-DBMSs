ATTACH '__TEST_DIR__/attach_database_size.db' AS db1;
ATTACH ':memory:' AS db2;
SELECT database_name FROM pragma_database_size() ORDER BY 1;
SELECT database_name FROM pragma_database_size() ORDER BY 1;
