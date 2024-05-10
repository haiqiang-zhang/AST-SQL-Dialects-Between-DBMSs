CREATE TABLE t1 (
  a int NOT NULL,
  b int NOT NULL,
  c double NOT NULL
);
INSERT INTO t1 VALUES (1,1,5),(1,1,2),(1,2,5),(2,1,4),(2,1,1),(2,2,2),(2,2,3),
(2,3,1),(2,3,1),(3,3,3),(3,3,5),(3,4,5),(4,4,5),(4,4,3),(5,3,1);
DROP TABLE t1;
