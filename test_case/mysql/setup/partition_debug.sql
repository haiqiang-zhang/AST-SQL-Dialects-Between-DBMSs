CREATE TABLE t1 (a INT, b VARCHAR(64), KEY(b,a))
PARTITION BY HASH (a) PARTITIONS 3;
INSERT INTO t1 VALUES (1, "1"), (2, "2"), (3, "3"), (4, "Four"), (5, "Five"),
(6, "Six"), (7, "Seven"), (8, "Eight"), (9, "Nine");
