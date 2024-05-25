SET allow_experimental_analyzer = 0;
SELECT * FROM t1 ALL RIGHT JOIN t2 USING (key) ORDER BY key;
SET allow_experimental_analyzer = 1;
SELECT * FROM t1 ALL RIGHT JOIN t2 USING (key) ORDER BY key;
