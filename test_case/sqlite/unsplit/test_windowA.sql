CREATE TABLE t1(a INTEGER PRIMARY KEY, b CHAR(1), d FLOAT);
INSERT INTO t1 VALUES
   (1, 'A', 5.4),
   (2, 'B', 5.55),
   (3, 'C', 8.0),
   (4, 'D', 10.25),
   (5, 'E', 10.26),
   (6, 'N', NULL),
   (7, 'N', NULL);
SELECT a, b, quote(d), group_concat(b,'') OVER w1 FROM t1
  WINDOW w1 AS 
     (ORDER BY d DESC NULLS LAST
      RANGE BETWEEN 2.50 PRECEDING AND 2.25 FOLLOWING)
  ORDER BY +d DESC NULLS LAST, +a;
