PRAGMA enable_verification;
CREATE TABLE test (a INTEGER, b INTEGER);
INSERT INTO test VALUES (11, 1), (12, 1), (13, 2);
SELECT 1 UNION ALL SELECT 2;
SELECT 1, 'a' UNION ALL SELECT 2, 'b';
SELECT 1, 'a' UNION ALL SELECT 2, 'b' UNION ALL SELECT 3, 'c' order by 1;
SELECT 1, 'a' UNION ALL SELECT 2, 'b' UNION ALL SELECT 3, 'c' UNION ALL SELECT 4, 'd' order by 1;
SELECT NULL UNION SELECT NULL;
SELECT NULL EXCEPT SELECT NULL;
SELECT NULL INTERSECT SELECT NULL;
SELECT a FROM test WHERE a < 13 UNION ALL SELECT a FROM test WHERE a = 13;
SELECT b FROM test WHERE a < 13 UNION ALL SELECT b FROM test WHERE a > 11;
SELECT 1 UNION ALL SELECT 'asdf';
SELECT NULL UNION ALL SELECT 'asdf';
SELECT 1 UNION SELECT 1;
SELECT 1, 'a' UNION SELECT 2, 'b' UNION SELECT 3, 'c' UNION SELECT 1, 'a' order by 1;
SELECT b FROM test WHERE a < 13 UNION  SELECT b FROM test WHERE a > 11 ORDER BY 1;
SELECT 1, 'a' UNION ALL SELECT 1, 'a' UNION SELECT 2, 'b' UNION SELECT 1, 'a' ORDER BY 1;
SELECT 1, 'a' UNION ALL SELECT 1, 'a' UNION SELECT 2, 'b' UNION SELECT 1, 'a' ORDER BY 1 DESC;
select x, count(*) as c
from ((select * from (values(1),(2),(2),(3),(3),(3),(4),(4),(4),(4)) s(x) except all select * from (values(1),(3),(3)) t(x)) intersect all select * from (values(2),(2),(2),(4),(3),(3)) u(x)) s
group by x order by x;
