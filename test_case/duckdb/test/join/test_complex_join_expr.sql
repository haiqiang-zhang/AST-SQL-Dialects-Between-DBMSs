SELECT * FROM test JOIN test2 ON test.a+test2.c=test.b+test2.b;
SELECT * FROM test LEFT JOIN test2 ON test.a+test2.c=test.b+test2.b ORDER BY 1;
SELECT * FROM test RIGHT JOIN test2 ON test.a+test2.c=test.b+test2.b ORDER BY 1;
SELECT * FROM test FULL OUTER JOIN test2 ON test.a+test2.c=test.b+test2.b ORDER BY 1;
