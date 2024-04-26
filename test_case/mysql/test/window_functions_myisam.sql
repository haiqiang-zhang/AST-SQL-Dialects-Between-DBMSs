CREATE TABLE ot (i int) ENGINE=MYISAM;
CREATE FUNCTION f(a INTEGER) RETURNS INTEGER DETERMINISTIC RETURN a*a;
SELECT ROW_NUMBER() OVER () , BIT_AND(i) FROM ot WHERE f(2)<2;
SELECT ROW_NUMBER() OVER () AS RN, BIT_AND(i) AS x FROM ot WHERE f(2) < 2 HAVING x < 2;
SELECT SUM(BIT_AND(i)) OVER (ORDER BY BIT_AND(i)) , BIT_AND(i) FROM ot WHERE f(2)<2;
INSERT INTO ot VALUES (1);
SELECT ROW_NUMBER() OVER () , BIT_AND(i) FROM ot WHERE f(2)<2;
SELECT ROW_NUMBER() OVER () AS RN, BIT_AND(i) AS x FROM ot WHERE f(2) < 2 HAVING x < 2;
SELECT SUM(BIT_AND(i)) OVER (ORDER BY BIT_AND(i)) , BIT_AND(i) FROM ot WHERE f(2)<2;
INSERT INTO ot VALUES (1);
SELECT ROW_NUMBER() OVER () , BIT_AND(i) FROM ot WHERE f(2)<2;
SELECT ROW_NUMBER() OVER () AS RN, BIT_AND(i) AS x FROM ot WHERE f(2) < 2 HAVING x < 2;
SELECT SUM(BIT_AND(i)) OVER (ORDER BY BIT_AND(i)) , BIT_AND(i) FROM ot WHERE f(2)<2;

DROP TABLE ot;
DROP FUNCTION f;
