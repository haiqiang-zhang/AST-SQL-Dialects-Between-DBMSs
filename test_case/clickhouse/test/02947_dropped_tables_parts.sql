SELECT database, table, name FROM system.parts WHERE database = currentDatabase() AND startsWith(table, '02947_table_');
DROP TABLE 02947_table_1;
DROP TABLE 02947_table_2;
