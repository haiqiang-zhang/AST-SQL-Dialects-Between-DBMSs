DROP TABLE IF EXISTS big_table_slow;
CREATE TABLE big_table_slow (id INT PRIMARY KEY AUTO_INCREMENT, v VARCHAR(100), t TEXT) ENGINE=InnoDB KEY_BLOCK_SIZE=8;
SELECT COUNT(*) FROM big_table_slow;
SELECT * FROM big_table_slow WHERE id=2;
DROP TABLE big_table_slow;
