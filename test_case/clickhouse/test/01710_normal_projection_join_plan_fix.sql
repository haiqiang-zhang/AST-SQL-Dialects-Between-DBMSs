ALTER TABLE t2 ADD PROJECTION proj (SELECT id2 ORDER BY id2);
INSERT INTO t2 SELECT number, number from numbers(100);
SELECT s FROM t1 as lhs LEFT JOIN (SELECT * FROM t2 WHERE id2 = 2) as rhs ON lhs.id = rhs.id2;
DROP TABLE t1;
DROP TABLE t2;
