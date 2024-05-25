DROP TABLE IF EXISTS test;
CREATE TABLE test(start Integer, end Integer) engine = Memory;
INSERT INTO test(start,end) VALUES (1,3),(2,7),(3,999),(4,7),(5,8);
SELECT maxIntersections(start,end) FROM test;
SELECT maxIntersectionsPosition(start,end) FROM test;
DROP TABLE test;
