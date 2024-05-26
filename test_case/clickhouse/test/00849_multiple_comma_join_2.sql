SELECT countIf(explain like '%COMMA%' OR explain like '%CROSS%'), countIf(explain like '%INNER%') FROM (
    EXPLAIN SYNTAX SELECT t1.a FROM t1, t2 WHERE t1.a = t2.a);
INSERT INTO t1 values (1,1), (2,2), (3,3), (4,4);
INSERT INTO t2 values (1,1), (1, Null);
INSERT INTO t3 values (1,1), (1, Null);
INSERT INTO t4 values (1,1), (1, Null);
SET allow_experimental_analyzer = 1;
SELECT 'SELECT * FROM t1, t2';
SELECT * FROM t1, t2
ORDER BY t1.a, t2.b;
SELECT 'SELECT * FROM t1, t2 WHERE t1.a = t2.a';
SELECT * FROM t1, t2 WHERE t1.a = t2.a
ORDER BY t1.a, t2.b;
SELECT 'SELECT t1.a, t2.a FROM t1, t2 WHERE t1.b = t2.b';
SELECT t1.a, t2.b FROM t1, t2 WHERE t1.b = t2.b;
SELECT 'SELECT t1.a, t2.b, t3.b FROM t1, t2, t3 WHERE t1.a = t2.a AND t1.a = t3.a';
SELECT t1.a, t2.b, t3.b FROM t1, t2, t3
WHERE t1.a = t2.a AND t1.a = t3.a
ORDER BY t2.b, t3.b;
SELECT 'SELECT t1.a, t2.b, t3.b FROM t1, t2, t3 WHERE t1.b = t2.b AND t1.b = t3.b';
SELECT t1.a, t2.b, t3.b FROM t1, t2, t3 WHERE t1.b = t2.b AND t1.b = t3.b;
SELECT 'SELECT t1.a, t2.b, t3.b, t4.b FROM t1, t2, t3, t4 WHERE t1.a = t2.a AND t1.a = t3.a AND t1.a = t4.a';
SELECT t1.a, t2.b, t3.b, t4.b FROM t1, t2, t3, t4
WHERE t1.a = t2.a AND t1.a = t3.a AND t1.a = t4.a
ORDER BY t2.b, t3.b, t4.b;
SELECT 'SELECT t1.a, t2.b, t3.b, t4.b FROM t1, t2, t3, t4 WHERE t1.b = t2.b AND t1.b = t3.b AND t1.b = t4.b';
SELECT t1.a, t2.b, t3.b, t4.b FROM t1, t2, t3, t4
WHERE t1.b = t2.b AND t1.b = t3.b AND t1.b = t4.b;
SELECT 'SELECT t1.a, t2.b, t3.b, t4.b FROM t1, t2, t3, t4 WHERE t1.a = t2.a AND t2.a = t3.a AND t3.a = t4.a';
SELECT t1.a, t2.b, t3.b, t4.b FROM t1, t2, t3, t4
WHERE t1.a = t2.a AND t2.a = t3.a AND t3.a = t4.a
ORDER BY t2.b, t3.b, t4.b;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
