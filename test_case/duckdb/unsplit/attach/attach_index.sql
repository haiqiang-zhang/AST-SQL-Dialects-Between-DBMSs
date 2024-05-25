ATTACH '__TEST_DIR__/index_db.db';
USE index_db;
SELECT * FROM tbl_a WHERE a_id=2;
SELECT * FROM index_db.tbl_a WHERE a_id=2;
