BEGIN TRANSACTION;
CREATE TYPE "group" AS ENUM ( 'one', 'two');
CREATE TABLE table1(col1 "group");
EXPORT DATABASE '__TEST_DIR__/export_enum' (FORMAT CSV);
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_enum';
