WITH data(k, v) AS (
      VALUES(3, 'thirty'), (1, 'ten')
    )
    UPDATE t1 SET z=v FROM data WHERE x=k;
SELECT * FROM t1;
SELECT * FROM log;
CREATE TABLE t2(a, b);
CREATE TABLE t3(k, v);
INSERT INTO t3 VALUES(5,   'v');
INSERT INTO t3 VALUES(12, 'xii');
INSERT INTO t2 VALUES(2, 12);
INSERT INTO t2 VALUES(3, 5);
DELETE FROM log;
UPDATE t1 SET y=v FROM t2, t3 WHERE t1.x=t2.a AND t3.k=t2.b;
SELECT * FROM t1;
SELECT * FROM log;
DELETE FROM log;
WITH data(k, v) AS (
      VALUES(1, 'seven'), (1, 'eight'), (2, 'eleven'), (2, 'twelve')
    )
    UPDATE t1 SET z=v FROM data WHERE x=k;
SELECT * FROM t1;
SELECT * FROM log;
CREATE VIEW v1 AS SELECT * FROM t1;
DELETE FROM log;
SELECT * FROM v1;
SELECT * FROM log;
CREATE TABLE o1(w, x, y, z UNIQUE, PRIMARY KEY(w, x));
CREATE INDEX o1y ON t1(y);
INSERT INTO o1 VALUES(0, 0, 'i', 'one');
INSERT INTO o1 VALUES(0, 1, 'ii', 'two');
INSERT INTO o1 VALUES(1, 0, 'iii', 'three');
INSERT INTO o1 VALUES(1, 1, 'iv', 'four');
DELETE FROM log;
WITH data(k, v) AS (
      VALUES(3, 'thirty'), (1, 'ten')
    )
    UPDATE o1 SET z=v FROM data WHERE (1+x+w*2)=k;
SELECT * FROM o1;
SELECT * FROM log;
DELETE FROM log;
UPDATE o1 SET y=v FROM t2, t3 WHERE (1+o1.w*2+o1.x)=t2.a AND t3.k=t2.b;
SELECT * FROM o1;
SELECT * FROM log;
DELETE FROM log;
WITH data(k, v) AS (
      VALUES(1, 'seven'), (1, 'eight'), (2, 'eleven'), (2, 'twelve')
    )
    UPDATE o1 SET z=v FROM data WHERE (1+w*2+x)=k;
SELECT * FROM o1;
SELECT * FROM log;
CREATE VIEW w1 AS SELECT * FROM o1;
DELETE FROM log;
SELECT * FROM w1;
SELECT * FROM log;
WITH data(k, v) AS (
      VALUES(3, 'thirty'), (1, 'ten')
    )
    UPDATE t1 SET z=v FROM data WHERE x=k;
SELECT * FROM t1;
SELECT * FROM log;
INSERT INTO t3 VALUES(5,   'v');
INSERT INTO t3 VALUES(12, 'xii');
INSERT INTO t2 VALUES(2, 12);
INSERT INTO t2 VALUES(3, 5);
DELETE FROM log;
UPDATE t1 SET y=v FROM t2, t3 WHERE t1.x=t2.a AND t3.k=t2.b;
SELECT * FROM t1;
SELECT * FROM log;
DELETE FROM log;
WITH data(k, v) AS (
      VALUES(1, 'seven'), (1, 'eight'), (2, 'eleven'), (2, 'twelve')
    )
    UPDATE t1 SET z=v FROM data WHERE x=k;
SELECT * FROM t1;
SELECT * FROM log;
DELETE FROM log;
SELECT * FROM v1;
SELECT * FROM log;
DELETE FROM log;
WITH data(k, v) AS (
      VALUES(3, 'thirty'), (1, 'ten')
    )
    UPDATE o1 SET z=v FROM data WHERE (1+x+w*2)=k;
SELECT * FROM o1;
SELECT * FROM log;
DELETE FROM log;
UPDATE o1 SET y=v FROM t2, t3 WHERE (1+o1.w*2+o1.x)=t2.a AND t3.k=t2.b;
SELECT * FROM o1;
SELECT * FROM log;
DELETE FROM log;
WITH data(k, v) AS (
      VALUES(1, 'seven'), (1, 'eight'), (2, 'eleven'), (2, 'twelve')
    )
    UPDATE o1 SET z=v FROM data WHERE (1+w*2+x)=k;
SELECT * FROM o1;
SELECT * FROM log;
DELETE FROM log;
SELECT * FROM w1;
SELECT * FROM log;
CREATE TABLE data(x, y, z);
WITH input(k, v) AS (
      VALUES(3, 'thirty'), (1, 'ten')
  )
  UPDATE t1 SET z=v FROM input WHERE x=k;
CREATE TABLE x1(a INT PRIMARY KEY, b, c) WITHOUT ROWID;
INSERT INTO x1 VALUES(1, 1, 1);
INSERT INTO x1 VALUES(2, 2, 2);
INSERT INTO x1 VALUES(3, 3, 3);
INSERT INTO x1 VALUES(4, 4, 4);
INSERT INTO x1 VALUES(5, 5, 5);
CREATE TABLE map(o, t);
INSERT INTO map VALUES(3, 30), (4, 40), (1, 10);
UPDATE x1 SET a=t FROM map WHERE a=o;
SELECT * FROM x1 ORDER BY a;
INSERT INTO x1 VALUES(1, 1, 1);
INSERT INTO x1 VALUES(3, 3, 3);
INSERT INTO x1 VALUES(4, 4, 4);
INSERT INTO map VALUES(3, 30), (4, 40), (1, 10);
SELECT * FROM x1 ORDER BY a;
INSERT INTO map VALUES(3, 30), (4, 40), (1, 10);
SELECT * FROM x1 ORDER BY a;
CREATE TABLE x2(a, b, c);
SELECT * FROM t2;
SELECT * FROM t3;
