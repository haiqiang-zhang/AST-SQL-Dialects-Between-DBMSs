ATTACH 'test.db2' AS aux;
CREATE TABLE aux.x1(x, one);
INSERT INTO x1 VALUES(1, 'one'), (2, 'two'), (3, 'three');
CREATE TABLE t1(a, b);
INSERT INTO t1 VALUES(1, 1), (2, 2), (3, 3), (4, 4);
DETACH aux;
ATTACH 'test.db2' AS aux;
SELECT * FROM aux.x1;
