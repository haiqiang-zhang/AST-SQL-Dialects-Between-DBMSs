SELECT count(1) FROM numbers(2) AS n1, numbers(3) AS n2, numbers(4) AS n3;
SELECT * FROM numbers(2) AS n1, numbers(3) AS n2, numbers(4) AS n3 ORDER BY n1.number, n2.number, n3.number;
SELECT n1.number, n2.number, n3.number FROM numbers(2) AS n1, numbers(3) AS n2, numbers(4) AS n3 ORDER BY n1.number, n2.number, n3.number;
