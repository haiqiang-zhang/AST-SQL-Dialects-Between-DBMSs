CREATE TABLE t1(
    i1 INTEGER,
    i2 INTEGER,
    n1 NUMERIC,
    n2 NUMERIC,
    t1 TEXT,
    t2 TEXT,
    o1 BLOB,
    o2 BLOB
  );
INSERT INTO t1 VALUES(NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
SELECT 500 = 500.0 FROM t1;
SELECT 1 FROM t1 WHERE 500 = 500.0;
SELECT 1 FROM t1 WHERE NOT (500 = 500.0);
SELECT '500' = 500.0 FROM t1;
SELECT 1 FROM t1 WHERE '500' = 500.0;
SELECT 1 FROM t1 WHERE NOT ('500' = 500.0);
SELECT 500 = '500.0' FROM t1;
SELECT 1 FROM t1 WHERE 500 = '500.0';
SELECT 1 FROM t1 WHERE NOT (500 = '500.0');
SELECT '500' = '500.0' FROM t1;
SELECT 1 FROM t1 WHERE '500' = '500.0';
SELECT 1 FROM t1 WHERE NOT ('500' = '500.0');
UPDATE t1 SET t1=500;
SELECT 500 = t1 FROM t1;
SELECT 1 FROM t1 WHERE 500 = t1;
SELECT 1 FROM t1 WHERE NOT (500 = t1);
UPDATE t1 SET t1=500;
SELECT '500' = t1 FROM t1;
SELECT 1 FROM t1 WHERE '500' = t1;
SELECT 1 FROM t1 WHERE NOT ('500' = t1);
UPDATE t1 SET t1=500;
SELECT 500.0 = t1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 = t1;
SELECT 1 FROM t1 WHERE NOT (500.0 = t1);
UPDATE t1 SET t1=500;
SELECT '500.0' = t1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' = t1;
SELECT 1 FROM t1 WHERE NOT ('500.0' = t1);
UPDATE t1 SET t1='500';
SELECT 500 = t1 FROM t1;
SELECT 1 FROM t1 WHERE 500 = t1;
SELECT 1 FROM t1 WHERE NOT (500 = t1);
UPDATE t1 SET t1='500';
SELECT '500' = t1 FROM t1;
SELECT 1 FROM t1 WHERE '500' = t1;
SELECT 1 FROM t1 WHERE NOT ('500' = t1);
UPDATE t1 SET t1='500';
SELECT 500.0 = t1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 = t1;
SELECT 1 FROM t1 WHERE NOT (500.0 = t1);
UPDATE t1 SET t1='500';
SELECT '500.0' = t1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' = t1;
SELECT 1 FROM t1 WHERE NOT ('500.0' = t1);
UPDATE t1 SET n1=500;
SELECT 500 = n1 FROM t1;
SELECT 1 FROM t1 WHERE 500 = n1;
SELECT 1 FROM t1 WHERE NOT (500 = n1);
UPDATE t1 SET n1=500;
SELECT '500' = n1 FROM t1;
SELECT 1 FROM t1 WHERE '500' = n1;
SELECT 1 FROM t1 WHERE NOT ('500' = n1);
UPDATE t1 SET n1=500;
SELECT 500.0 = n1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 = n1;
SELECT 1 FROM t1 WHERE NOT (500.0 = n1);
UPDATE t1 SET n1=500;
SELECT '500.0' = n1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' = n1;
SELECT 1 FROM t1 WHERE NOT ('500.0' = n1);
UPDATE t1 SET n1='500';
SELECT 500 = n1 FROM t1;
SELECT 1 FROM t1 WHERE 500 = n1;
SELECT 1 FROM t1 WHERE NOT (500 = n1);
UPDATE t1 SET n1='500';
SELECT '500' = n1 FROM t1;
SELECT 1 FROM t1 WHERE '500' = n1;
SELECT 1 FROM t1 WHERE NOT ('500' = n1);
UPDATE t1 SET n1='500';
SELECT 500.0 = n1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 = n1;
SELECT 1 FROM t1 WHERE NOT (500.0 = n1);
UPDATE t1 SET n1='500';
SELECT '500.0' = n1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' = n1;
SELECT 1 FROM t1 WHERE NOT ('500.0' = n1);
UPDATE t1 SET o1=500;
SELECT 500 = o1 FROM t1;
SELECT 1 FROM t1 WHERE 500 = o1;
SELECT 1 FROM t1 WHERE NOT (500 = o1);
UPDATE t1 SET o1=500;
SELECT '500' = o1 FROM t1;
SELECT 1 FROM t1 WHERE '500' = o1;
SELECT 1 FROM t1 WHERE NOT ('500' = o1);
UPDATE t1 SET o1=500;
SELECT 500.0 = o1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 = o1;
SELECT 1 FROM t1 WHERE NOT (500.0 = o1);
UPDATE t1 SET o1=500;
SELECT '500.0' = o1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' = o1;
SELECT 1 FROM t1 WHERE NOT ('500.0' = o1);
UPDATE t1 SET o1='500';
SELECT 500 = o1 FROM t1;
SELECT 1 FROM t1 WHERE 500 = o1;
SELECT 1 FROM t1 WHERE NOT (500 = o1);
UPDATE t1 SET o1='500';
SELECT '500' = o1 FROM t1;
SELECT 1 FROM t1 WHERE '500' = o1;
SELECT 1 FROM t1 WHERE NOT ('500' = o1);
UPDATE t1 SET o1='500';
SELECT 500.0 = o1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 = o1;
SELECT 1 FROM t1 WHERE NOT (500.0 = o1);
UPDATE t1 SET o1='500';
SELECT '500.0' = o1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' = o1;
SELECT 1 FROM t1 WHERE NOT ('500.0' = o1);
CREATE TABLE t2(i INTEGER, n NUMERIC, t TEXT, o XBLOBY);
CREATE INDEX t2i1 ON t2(i);
CREATE INDEX t2i2 ON t2(n);
CREATE INDEX t2i3 ON t2(t);
CREATE INDEX t2i4 ON t2(o);
INSERT INTO t2 VALUES(10, 10, 10, 10);
INSERT INTO t2 VALUES(10.0, 10.0, 10.0, 10.0);
INSERT INTO t2 VALUES('10', '10', '10', '10');
INSERT INTO t2 VALUES('10.0', '10.0', '10.0', '10.0');
INSERT INTO t2 VALUES(20, 20, 20, 20);
INSERT INTO t2 VALUES(20.0, 20.0, 20.0, 20.0);
INSERT INTO t2 VALUES('20', '20', '20', '20');
INSERT INTO t2 VALUES('20.0', '20.0', '20.0', '20.0');
INSERT INTO t2 VALUES(30, 30, 30, 30);
INSERT INTO t2 VALUES(30.0, 30.0, 30.0, 30.0);
INSERT INTO t2 VALUES('30', '30', '30', '30');
INSERT INTO t2 VALUES('30.0', '30.0', '30.0', '30.0');
SELECT rowid FROM t2 WHERE i = 10;
SELECT rowid FROM t2 WHERE i = 10.0;
SELECT rowid FROM t2 WHERE i = '10';
SELECT rowid FROM t2 WHERE i = '10.0';
SELECT rowid FROM t2 WHERE n = 20;
SELECT rowid FROM t2 WHERE n = 20.0;
SELECT rowid FROM t2 WHERE n = '20';
SELECT rowid FROM t2 WHERE n = '20.0';
SELECT rowid FROM t2 WHERE t = 20;
SELECT rowid FROM t2 WHERE t = 20.0;
SELECT rowid FROM t2 WHERE t = '20';
SELECT rowid FROM t2 WHERE t = '20.0';
SELECT rowid FROM t2 WHERE o = 30;
SELECT rowid FROM t2 WHERE o = 30.0;
SELECT rowid FROM t2 WHERE o = '30';
SELECT rowid FROM t2 WHERE o = '30.0';
SELECT rowid FROM t2 WHERE i < 20;
SELECT rowid FROM t2 WHERE i < 20.0;
SELECT rowid FROM t2 WHERE i < '20';
SELECT rowid FROM t2 WHERE i < '20.0';
SELECT rowid FROM t2 WHERE n < 20;
SELECT rowid FROM t2 WHERE n < 20.0;
SELECT rowid FROM t2 WHERE n < '20';
SELECT rowid FROM t2 WHERE n < '20.0';
SELECT rowid FROM t2 WHERE t < 20;
SELECT rowid FROM t2 WHERE t < 20.0;
SELECT rowid FROM t2 WHERE t < '20';
SELECT rowid FROM t2 WHERE t < '20.0';
SELECT rowid FROM t2 WHERE o < 20;
SELECT rowid FROM t2 WHERE o < 20.0;
SELECT rowid FROM t2 WHERE o < '20';
SELECT rowid FROM t2 WHERE o < '20.0';
SELECT 500 > 60.0 FROM t1;
SELECT 1 FROM t1 WHERE 500 > 60.0;
SELECT 1 FROM t1 WHERE NOT (500 > 60.0);
SELECT '500' > 60.0 FROM t1;
SELECT 1 FROM t1 WHERE '500' > 60.0;
SELECT 1 FROM t1 WHERE NOT ('500' > 60.0);
SELECT 500 > '60.0' FROM t1;
SELECT 1 FROM t1 WHERE 500 > '60.0';
SELECT 1 FROM t1 WHERE NOT (500 > '60.0');
SELECT '500' > '60.0' FROM t1;
SELECT 1 FROM t1 WHERE '500' > '60.0';
SELECT 1 FROM t1 WHERE NOT ('500' > '60.0');
UPDATE t1 SET t1=500.0;
SELECT t1 > 500 FROM t1;
SELECT 1 FROM t1 WHERE t1 > 500;
SELECT 1 FROM t1 WHERE NOT (t1 > 500);
UPDATE t1 SET t1=500.0;
SELECT t1 > '500'  FROM t1;
SELECT 1 FROM t1 WHERE t1 > '500';
SELECT 1 FROM t1 WHERE NOT (t1 > '500' );
UPDATE t1 SET t1=500.0;
SELECT t1 > 500.0  FROM t1;
SELECT 1 FROM t1 WHERE t1 > 500.0;
SELECT 1 FROM t1 WHERE NOT (t1 > 500.0 );
UPDATE t1 SET t1=500.0;
SELECT t1 > '500.0'  FROM t1;
SELECT 1 FROM t1 WHERE t1 > '500.0';
SELECT 1 FROM t1 WHERE NOT (t1 > '500.0' );
UPDATE t1 SET t1='500.0';
SELECT t1 > 500  FROM t1;
SELECT 1 FROM t1 WHERE t1 > 500;
SELECT 1 FROM t1 WHERE NOT (t1 > 500 );
UPDATE t1 SET t1='500.0';
SELECT t1 > '500'  FROM t1;
SELECT 1 FROM t1 WHERE t1 > '500';
SELECT 1 FROM t1 WHERE NOT (t1 > '500' );
UPDATE t1 SET t1='500.0';
SELECT t1 > 500.0  FROM t1;
SELECT 1 FROM t1 WHERE t1 > 500.0;
SELECT 1 FROM t1 WHERE NOT (t1 > 500.0 );
UPDATE t1 SET t1='500.0';
SELECT t1 > '500.0'  FROM t1;
SELECT 1 FROM t1 WHERE t1 > '500.0';
SELECT 1 FROM t1 WHERE NOT (t1 > '500.0' );
UPDATE t1 SET n1=400;
SELECT 500 > n1 FROM t1;
SELECT 1 FROM t1 WHERE 500 > n1;
SELECT 1 FROM t1 WHERE NOT (500 > n1);
UPDATE t1 SET n1=400;
SELECT '500' > n1 FROM t1;
SELECT 1 FROM t1 WHERE '500' > n1;
SELECT 1 FROM t1 WHERE NOT ('500' > n1);
UPDATE t1 SET n1=400;
SELECT 500.0 > n1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 > n1;
SELECT 1 FROM t1 WHERE NOT (500.0 > n1);
UPDATE t1 SET n1=400;
SELECT '500.0' > n1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' > n1;
SELECT 1 FROM t1 WHERE NOT ('500.0' > n1);
UPDATE t1 SET n1='400';
SELECT 500 > n1 FROM t1;
SELECT 1 FROM t1 WHERE 500 > n1;
SELECT 1 FROM t1 WHERE NOT (500 > n1);
UPDATE t1 SET n1='400';
SELECT '500' > n1 FROM t1;
SELECT 1 FROM t1 WHERE '500' > n1;
SELECT 1 FROM t1 WHERE NOT ('500' > n1);
UPDATE t1 SET n1='400';
SELECT 500.0 > n1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 > n1;
SELECT 1 FROM t1 WHERE NOT (500.0 > n1);
UPDATE t1 SET n1='400';
SELECT '500.0' > n1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' > n1;
SELECT 1 FROM t1 WHERE NOT ('500.0' > n1);
UPDATE t1 SET o1=500;
SELECT 500 > o1 FROM t1;
SELECT 1 FROM t1 WHERE 500 > o1;
SELECT 1 FROM t1 WHERE NOT (500 > o1);
UPDATE t1 SET o1=500;
SELECT '500' > o1 FROM t1;
SELECT 1 FROM t1 WHERE '500' > o1;
SELECT 1 FROM t1 WHERE NOT ('500' > o1);
UPDATE t1 SET o1=500;
SELECT 500.0 > o1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 > o1;
SELECT 1 FROM t1 WHERE NOT (500.0 > o1);
UPDATE t1 SET o1=500;
SELECT '500.0' > o1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' > o1;
SELECT 1 FROM t1 WHERE NOT ('500.0' > o1);
UPDATE t1 SET o1='500';
SELECT 500 > o1 FROM t1;
SELECT 1 FROM t1 WHERE 500 > o1;
SELECT 1 FROM t1 WHERE NOT (500 > o1);
UPDATE t1 SET o1='500';
SELECT '500' > o1 FROM t1;
SELECT 1 FROM t1 WHERE '500' > o1;
SELECT 1 FROM t1 WHERE NOT ('500' > o1);
UPDATE t1 SET o1='500';
SELECT 500.0 > o1 FROM t1;
SELECT 1 FROM t1 WHERE 500.0 > o1;
SELECT 1 FROM t1 WHERE NOT (500.0 > o1);
UPDATE t1 SET o1='500';
SELECT '500.0' > o1 FROM t1;
SELECT 1 FROM t1 WHERE '500.0' > o1;
SELECT 1 FROM t1 WHERE NOT ('500.0' > o1);
SELECT (NULL IN ('10.0', 20)) ISNULL FROM t1;
SELECT 1 FROM t1 WHERE (NULL IN ('10.0', 20)) ISNULL;
SELECT 1 FROM t1 WHERE NOT ((NULL IN ('10.0', 20)) ISNULL);
SELECT 10 IN ('10.0', 20) FROM t1;
SELECT 1 FROM t1 WHERE 10 IN ('10.0', 20);
SELECT 1 FROM t1 WHERE NOT (10 IN ('10.0', 20));
SELECT '10' IN ('10.0', 20) FROM t1;
SELECT 1 FROM t1 WHERE '10' IN ('10.0', 20);
SELECT 1 FROM t1 WHERE NOT ('10' IN ('10.0', 20));
SELECT 10 IN (10.0, 20) FROM t1;
SELECT 1 FROM t1 WHERE 10 IN (10.0, 20);
SELECT 1 FROM t1 WHERE NOT (10 IN (10.0, 20));
SELECT '10.0' IN (10, 20) FROM t1;
SELECT 1 FROM t1 WHERE '10.0' IN (10, 20);
SELECT 1 FROM t1 WHERE NOT ('10.0' IN (10, 20));
UPDATE t1 SET t1='10.0';
SELECT t1 IN (10.0, 20) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (10.0, 20);
SELECT 1 FROM t1 WHERE NOT (t1 IN (10.0, 20));
UPDATE t1 SET t1='10.0';
SELECT t1 IN (10, 20) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (10, 20);
SELECT 1 FROM t1 WHERE NOT (t1 IN (10, 20));
UPDATE t1 SET t1='10';
SELECT t1 IN (10.0, 20) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (10.0, 20);
SELECT 1 FROM t1 WHERE NOT (t1 IN (10.0, 20));
UPDATE t1 SET t1='10';
SELECT t1 IN (20, '10.0') FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (20, '10.0');
SELECT 1 FROM t1 WHERE NOT (t1 IN (20, '10.0'));
UPDATE t1 SET t1=10;
SELECT t1 IN (20, '10') FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (20, '10');
SELECT 1 FROM t1 WHERE NOT (t1 IN (20, '10'));
UPDATE t1 SET n1='10.0';
SELECT n1 IN (10.0, 20) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (10.0, 20);
SELECT 1 FROM t1 WHERE NOT (n1 IN (10.0, 20));
UPDATE t1 SET n1='10.0';
SELECT n1 IN (10, 20) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (10, 20);
SELECT 1 FROM t1 WHERE NOT (n1 IN (10, 20));
UPDATE t1 SET n1='10';
SELECT n1 IN (10.0, 20) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (10.0, 20);
SELECT 1 FROM t1 WHERE NOT (n1 IN (10.0, 20));
UPDATE t1 SET n1='10';
SELECT n1 IN (20, '10.0') FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (20, '10.0');
SELECT 1 FROM t1 WHERE NOT (n1 IN (20, '10.0'));
UPDATE t1 SET n1=10;
SELECT n1 IN (20, '10') FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (20, '10');
SELECT 1 FROM t1 WHERE NOT (n1 IN (20, '10'));
UPDATE t1 SET o1='10.0';
SELECT o1 IN (10.0, 20) FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (10.0, 20);
SELECT 1 FROM t1 WHERE NOT (o1 IN (10.0, 20));
UPDATE t1 SET o1='10.0';
SELECT o1 IN (10, 20) FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (10, 20);
SELECT 1 FROM t1 WHERE NOT (o1 IN (10, 20));
UPDATE t1 SET o1='10';
SELECT o1 IN (10.0, 20) FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (10.0, 20);
SELECT 1 FROM t1 WHERE NOT (o1 IN (10.0, 20));
UPDATE t1 SET o1='10';
SELECT o1 IN (20, '10.0') FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (20, '10.0');
SELECT 1 FROM t1 WHERE NOT (o1 IN (20, '10.0'));
UPDATE t1 SET o1=10;
SELECT o1 IN (20, '10') FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (20, '10');
SELECT 1 FROM t1 WHERE NOT (o1 IN (20, '10'));
UPDATE t1 SET o1='10.0';
SELECT o1 IN (10, 20, '10.0') FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (10, 20, '10.0');
SELECT 1 FROM t1 WHERE NOT (o1 IN (10, 20, '10.0'));
UPDATE t1 SET o1='10';
SELECT o1 IN (10.0, 20, '10') FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (10.0, 20, '10');
SELECT 1 FROM t1 WHERE NOT (o1 IN (10.0, 20, '10'));
UPDATE t1 SET o1=10;
SELECT n1 IN (20, '10', 10) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (20, '10', 10);
SELECT 1 FROM t1 WHERE NOT (n1 IN (20, '10', 10));
SELECT '1' IN ('1') FROM t1;
SELECT 1 FROM t1 WHERE '1' IN ('1');
SELECT 1 FROM t1 WHERE NOT ('1' IN ('1'));
SELECT '2' IN (2) FROM t1;
SELECT 1 FROM t1 WHERE '2' IN (2);
SELECT 1 FROM t1 WHERE NOT ('2' IN (2));
SELECT 3 IN ('3') FROM t1;
SELECT 1 FROM t1 WHERE 3 IN ('3');
SELECT 1 FROM t1 WHERE NOT (3 IN ('3'));
SELECT 4 IN (4) FROM t1;
SELECT 1 FROM t1 WHERE 4 IN (4);
SELECT 1 FROM t1 WHERE NOT (4 IN (4));
UPDATE t1 SET t1='10';
SELECT 10 IN (5,t1,'abc') FROM t1;
SELECT 1 FROM t1 WHERE 10 IN (5,t1,'abc');
SELECT 1 FROM t1 WHERE NOT (10 IN (5,t1,'abc'));
UPDATE t1 SET t1='10';
SELECT 10 IN ('abc',t1,5) FROM t1;
SELECT 1 FROM t1 WHERE 10 IN ('abc',t1,5);
SELECT 1 FROM t1 WHERE NOT (10 IN ('abc',t1,5));
UPDATE t1 SET t1='010';
SELECT 10 IN (5,t1,'abc') FROM t1;
SELECT 1 FROM t1 WHERE 10 IN (5,t1,'abc');
SELECT 1 FROM t1 WHERE NOT (10 IN (5,t1,'abc'));
UPDATE t1 SET t1='010';
SELECT 10 IN ('abc',t1,5) FROM t1;
SELECT 1 FROM t1 WHERE 10 IN ('abc',t1,5);
SELECT 1 FROM t1 WHERE NOT (10 IN ('abc',t1,5));
UPDATE t1 SET t1='10';
SELECT '10' IN (5,t1,'abc') FROM t1;
SELECT 1 FROM t1 WHERE '10' IN (5,t1,'abc');
SELECT 1 FROM t1 WHERE NOT ('10' IN (5,t1,'abc'));
UPDATE t1 SET t1='10';
SELECT '10' IN ('abc',t1,5) FROM t1;
SELECT 1 FROM t1 WHERE '10' IN ('abc',t1,5);
SELECT 1 FROM t1 WHERE NOT ('10' IN ('abc',t1,5));
UPDATE t1 SET t1='010';
SELECT '10' IN (5,t1,'abc') FROM t1;
SELECT 1 FROM t1 WHERE '10' IN (5,t1,'abc');
SELECT 1 FROM t1 WHERE NOT ('10' IN (5,t1,'abc'));
UPDATE t1 SET t1='010';
SELECT '10' IN ('abc',t1,5) FROM t1;
SELECT 1 FROM t1 WHERE '10' IN ('abc',t1,5);
SELECT 1 FROM t1 WHERE NOT ('10' IN ('abc',t1,5));
UPDATE t1 SET t1='10',n1=10;
SELECT t1 IN (5,n1,11) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (5,n1,11);
SELECT 1 FROM t1 WHERE NOT (t1 IN (5,n1,11));
UPDATE t1 SET t1='010',n1=10;
SELECT t1 IN (5,n1,11) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (5,n1,11);
SELECT 1 FROM t1 WHERE NOT (t1 IN (5,n1,11));
UPDATE t1 SET t1='10',n1=10;
SELECT n1 IN (5,t1,11) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (5,t1,11);
SELECT 1 FROM t1 WHERE NOT (n1 IN (5,t1,11));
UPDATE t1 SET t1='010',n1=10;
SELECT n1 IN (5,t1,11) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (5,t1,11);
SELECT 1 FROM t1 WHERE NOT (n1 IN (5,t1,11));
SELECT rowid FROM t2 WHERE o IN ('10', 30);
SELECT rowid FROM t2 WHERE o IN (20.0, 30.0);
SELECT rowid FROM t2 WHERE t IN ('10', 30);
SELECT rowid FROM t2 WHERE t IN (20.0, 30.0);
SELECT rowid FROM t2 WHERE n IN ('10', 30);
SELECT rowid FROM t2 WHERE n IN (20.0, 30.0);
SELECT rowid FROM t2 WHERE i IN ('10', 30);
SELECT rowid FROM t2 WHERE i IN (20.0, 30.0);
SELECT rowid FROM t2 WHERE rowid IN (1, 6, 10);
CREATE TABLE t3(i INTEGER, n NUMERIC, t TEXT, o BLOB);
INSERT INTO t3 VALUES(1, 1, 1, 1);
INSERT INTO t3 VALUES(2, 2, 2, 2);
INSERT INTO t3 VALUES(3, 3, 3, 3);
INSERT INTO t3 VALUES('1', '1', '1', '1');
INSERT INTO t3 VALUES('1.0', '1.0', '1.0', '1.0');
UPDATE t1 SET i1=1;
SELECT i1 IN (SELECT i FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE i1 IN (SELECT i FROM t3);
SELECT 1 FROM t1 WHERE NOT (i1 IN (SELECT i FROM t3));
UPDATE t1 SET i1='2.0';
SELECT i1 IN (SELECT i FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE i1 IN (SELECT i FROM t3);
SELECT 1 FROM t1 WHERE NOT (i1 IN (SELECT i FROM t3));
UPDATE t1 SET i1='2.0';
SELECT i1 IN (SELECT n FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE i1 IN (SELECT n FROM t3);
SELECT 1 FROM t1 WHERE NOT (i1 IN (SELECT n FROM t3));
UPDATE t1 SET i1='2.0';
SELECT i1 IN (SELECT t FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE i1 IN (SELECT t FROM t3);
SELECT 1 FROM t1 WHERE NOT (i1 IN (SELECT t FROM t3));
UPDATE t1 SET i1='2.0';
SELECT i1 IN (SELECT o FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE i1 IN (SELECT o FROM t3);
SELECT 1 FROM t1 WHERE NOT (i1 IN (SELECT o FROM t3));
UPDATE t1 SET n1=1;
SELECT n1 IN (SELECT n FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (SELECT n FROM t3);
SELECT 1 FROM t1 WHERE NOT (n1 IN (SELECT n FROM t3));
UPDATE t1 SET n1='2.0';
SELECT n1 IN (SELECT i FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (SELECT i FROM t3);
SELECT 1 FROM t1 WHERE NOT (n1 IN (SELECT i FROM t3));
UPDATE t1 SET n1='2.0';
SELECT n1 IN (SELECT n FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (SELECT n FROM t3);
SELECT 1 FROM t1 WHERE NOT (n1 IN (SELECT n FROM t3));
UPDATE t1 SET n1='2.0';
SELECT n1 IN (SELECT t FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (SELECT t FROM t3);
SELECT 1 FROM t1 WHERE NOT (n1 IN (SELECT t FROM t3));
UPDATE t1 SET n1='2.0';
SELECT n1 IN (SELECT o FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE n1 IN (SELECT o FROM t3);
SELECT 1 FROM t1 WHERE NOT (n1 IN (SELECT o FROM t3));
UPDATE t1 SET t1=1;
SELECT t1 IN (SELECT t FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (SELECT t FROM t3);
SELECT 1 FROM t1 WHERE NOT (t1 IN (SELECT t FROM t3));
UPDATE t1 SET t1='2.0';
SELECT t1 IN (SELECT t FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (SELECT t FROM t3);
SELECT 1 FROM t1 WHERE NOT (t1 IN (SELECT t FROM t3));
UPDATE t1 SET t1='2.0';
SELECT t1 IN (SELECT n FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (SELECT n FROM t3);
SELECT 1 FROM t1 WHERE NOT (t1 IN (SELECT n FROM t3));
UPDATE t1 SET t1='2.0';
SELECT t1 IN (SELECT i FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (SELECT i FROM t3);
SELECT 1 FROM t1 WHERE NOT (t1 IN (SELECT i FROM t3));
UPDATE t1 SET t1='2.0';
SELECT t1 IN (SELECT o FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (SELECT o FROM t3);
SELECT 1 FROM t1 WHERE NOT (t1 IN (SELECT o FROM t3));
UPDATE t1 SET t1='1.0';
SELECT t1 IN (SELECT t FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (SELECT t FROM t3);
SELECT 1 FROM t1 WHERE NOT (t1 IN (SELECT t FROM t3));
UPDATE t1 SET t1='1.0';
SELECT t1 IN (SELECT o FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE t1 IN (SELECT o FROM t3);
SELECT 1 FROM t1 WHERE NOT (t1 IN (SELECT o FROM t3));
UPDATE t1 SET o1=2;
SELECT o1 IN (SELECT o FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (SELECT o FROM t3);
SELECT 1 FROM t1 WHERE NOT (o1 IN (SELECT o FROM t3));
UPDATE t1 SET o1='2';
SELECT o1 IN (SELECT o FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (SELECT o FROM t3);
SELECT 1 FROM t1 WHERE NOT (o1 IN (SELECT o FROM t3));
UPDATE t1 SET o1='2';
SELECT o1 IN (SELECT o||'' FROM t3) FROM t1;
SELECT 1 FROM t1 WHERE o1 IN (SELECT o||'' FROM t3);
SELECT 1 FROM t1 WHERE NOT (o1 IN (SELECT o||'' FROM t3));
CREATE TABLE t4(i INTEGER, n NUMERIC, t VARCHAR(20), o LARGE BLOB);
INSERT INTO t4 VALUES(10, 20, 20, 30);
SELECT rowid FROM t2 WHERE i IN (SELECT i FROM t4);
SELECT rowid FROM t2 WHERE n IN (SELECT i FROM t4);
SELECT rowid FROM t2 WHERE t IN (SELECT i FROM t4);
SELECT rowid FROM t2 WHERE o IN (SELECT i FROM t4);
SELECT rowid FROM t2 WHERE i IN (SELECT t FROM t4);
SELECT rowid FROM t2 WHERE n IN (SELECT t FROM t4);
SELECT rowid FROM t2 WHERE t IN (SELECT t FROM t4);
SELECT rowid FROM t2 WHERE o IN (SELECT t FROM t4);
SELECT rowid FROM t2 WHERE i IN (SELECT o FROM t4);
SELECT rowid FROM t2 WHERE n IN (SELECT o FROM t4);
SELECT rowid FROM t2 WHERE t IN (SELECT o FROM t4);
SELECT rowid FROM t2 WHERE o IN (SELECT o FROM t4);
