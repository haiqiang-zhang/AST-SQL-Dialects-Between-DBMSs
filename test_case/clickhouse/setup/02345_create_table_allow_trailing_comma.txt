DROP TABLE IF EXISTS trailing_comma_1 SYNC;
CREATE TABLE trailing_comma_1 (id INT NOT NULL DEFAULT 1,) ENGINE=MergeTree() ORDER BY tuple();
