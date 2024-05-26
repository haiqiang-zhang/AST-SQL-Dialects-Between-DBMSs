ATTACH 'test2.db' AS aux;
DETACH aux;
DROP TABLE abc;
CREATE TABLE abc(a, b, c);
CREATE VIEW abcview AS SELECT * FROM abc;
DROP VIEW abcview;
INSERT INTO abc VALUES(1, 2, 3);
CREATE TABLE t2(a, b, c);
SELECT * FROM abc;
