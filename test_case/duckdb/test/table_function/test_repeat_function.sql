SELECT * FROM repeat(INTERVAL '30 days', NULL);
SELECT * FROM repeat(0, 3);
SELECT * FROM repeat(NULL, 2);
SELECT * FROM repeat('hello', 2);
SELECT * FROM repeat('thisisalongstring', 2);
SELECT * FROM repeat(blob '\x00\x00hello', 2);
SELECT * FROM repeat(1, 10000);
SELECT * FROM repeat(DATE '1992-01-01', 2);
SELECT * FROM repeat(INTERVAL '30 days', 2);
