CREATE TABLE t1 (b VARCHAR(2));
INSERT INTO t1 VALUES ('0'), ('1'), ('2'), ('3'), ('4'), ('5'), ('6'), ('7');
INSERT INTO t1 VALUES ('8'), ('9'), ('A'), ('B'), ('C'), ('D'), ('E'), ('F');
CREATE TEMPORARY TABLE head AS SELECT concat(b1.b, b2.b) AS head FROM t1 b1, t1 b2;
CREATE TEMPORARY TABLE tail AS SELECT concat(b1.b, b2.b) AS tail FROM t1 b1, t1 b2;
DROP TABLE t1;
CREATE TABLE t1 (code char(1)) CHARACTER SET UCS2 ENGINE=INNODB;
INSERT INTO t1 SELECT UNHEX(CONCAT(head, tail)) FROM head, tail ORDER BY
head, tail;
CREATE TABLE t2 (b VARCHAR(2));
INSERT INTO t2 VALUES ('0'), ('1'), ('2'), ('3'), ('4'), ('5'), ('6'), ('7');
INSERT INTO t2 VALUES ('8'), ('9'), ('A'), ('B'), ('C'), ('D'), ('E'), ('F');
CREATE TEMPORARY TABLE ch1 AS SELECT concat(b1.b, b2.b) AS ch FROM t2 b1, t2 b2;
CREATE TEMPORARY TABLE ch2 AS SELECT concat(b1.b, b2.b) AS ch FROM t2 b1, t2 b2;
CREATE TEMPORARY TABLE ch3 AS SELECT concat(b1.b, b2.b) AS ch FROM t2 b1, t2 b2;
DROP TABLE t2;
CREATE TABLE t2 (code char(1)) CHARACTER SET UTF32 ENGINE=INNODB;
INSERT INTO t2 SELECT UNHEX(CONCAT(ch1.ch, ch2.ch, ch3.ch)) FROM ch1, ch2, ch3
WHERE (ch1.ch BETWEEN '01' AND '02') AND (ch2.ch BETWEEN '00' AND 'FF')
AND (ch3.ch BETWEEN '00' AND 'FF')
ORDER BY ch1.ch, ch2.ch, ch3.ch;
DROP TEMPORARY TABLE head, tail;
DROP TEMPORARY TABLE ch1, ch2, ch3;
