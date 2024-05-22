DROP TABLE IF EXISTS a1;
DROP TABLE IF EXISTS a2;
SET send_logs_level = 'fatal';
CREATE TABLE a1(a UInt8, b UInt8) ENGINE=Memory;
CREATE TABLE a2(a UInt8, b UInt8) ENGINE=Memory;
INSERT INTO a1 VALUES (1, 1);
INSERT INTO a1 VALUES (1, 2);
INSERT INTO a1 VALUES (1, 3);
INSERT INTO a2 VALUES (1, 2);
INSERT INTO a2 VALUES (1, 3);
INSERT INTO a2 VALUES (1, 4);
SELECT a, b FROM a1 LEFT JOIN (SELECT a, b FROM a2) js2 USING a ORDER BY b SETTINGS join_default_strictness='ANY';
SELECT a, b FROM a1 LEFT JOIN (SELECT a, b FROM a2) js2 USING a ORDER BY b;
DROP TABLE IF EXISTS a1;
DROP TABLE IF EXISTS a2;
