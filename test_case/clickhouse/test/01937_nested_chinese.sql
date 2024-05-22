CREATE TEMPORARY TABLE test (`id` String, `products` Nested (`Ã¤ÂºÂ§Ã¥ÂÂ` Array(String), `Ã©ÂÂÃ©ÂÂ` Array(Int32)));
DESCRIBE test;
DESCRIBE (SELECT * FROM test);
DESCRIBE (SELECT * FROM test ARRAY JOIN products);
DESCRIBE (SELECT p.`Ã¤ÂºÂ§Ã¥ÂÂ`, p.`Ã©ÂÂÃ©ÂÂ` FROM test ARRAY JOIN products AS p);
SELECT * FROM test ARRAY JOIN products;
SELECT count() FROM (SELECT * FROM test ARRAY JOIN products);
