CREATE TEMPORARY TABLE test (`id` String, `products` Nested (`äº§å` Array(String), `éé` Array(Int32)));
DESCRIBE test;
DESCRIBE (SELECT * FROM test);
DESCRIBE (SELECT * FROM test ARRAY JOIN products);
DESCRIBE (SELECT p.`äº§å`, p.`éé` FROM test ARRAY JOIN products AS p);
SELECT * FROM test ARRAY JOIN products;
SELECT count() FROM (SELECT * FROM test ARRAY JOIN products);