DROP TABLE IF EXISTS products;
SET allow_experimental_analyzer = 1;
CREATE TABLE products (`price` UInt32) ENGINE = Memory;
INSERT INTO products VALUES (1);
