CREATE TABLE t(i INT) ENGINE=innodb;
INSERT INTO t
   WITH RECURSIVE cte AS (
      SELECT 0 AS i
      UNION
      SELECT 1 AS i
      UNION
      SELECT i+2 FROM cte
      WHERE i+2 < 1024
   )
   SELECT i FROM cte;
INSERT INTO t select i FROM  t;
