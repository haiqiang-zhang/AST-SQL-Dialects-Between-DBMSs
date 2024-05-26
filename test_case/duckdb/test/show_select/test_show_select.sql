SHOW SELECT * FROM integers;
DESCRIBE SELECT * FROM integers;
SHOW SELECT i FROM integers;
SHOW SELECT integers.i, integers2.st, integers2.d FROM integers, integers2 WHERE integers.i=integers2.i;
SHOW SELECT SUM(i) AS sum1, j FROM integers GROUP BY j HAVING j < 10;
