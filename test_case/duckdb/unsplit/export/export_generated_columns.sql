BEGIN TRANSACTION;
CREATE TABLE tbl (
	x INTEGER,
	gen_x AS (x + 5)
);
INSERT INTO tbl VALUES(5);
EXPORT DATABASE '__TEST_DIR__/export_generated_columns' (FORMAT CSV);
ROLLBACK;
IMPORT DATABASE '__TEST_DIR__/export_generated_columns';
SELECT * FROM tbl;
