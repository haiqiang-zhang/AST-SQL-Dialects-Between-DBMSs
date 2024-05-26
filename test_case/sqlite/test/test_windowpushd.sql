SELECT * FROM lll;
SELECT * FROM lll WHERE grp_id=2;
EXPLAIN QUERY PLAN 
  SELECT * FROM lll WHERE grp_id=2;
CREATE VIEW v1 AS SELECT a, c, max(c) OVER (PARTITION BY a) FROM t1;
CREATE VIEW v2 AS SELECT a, c, 
      max(c) OVER (PARTITION BY a),
      row_number() OVER ()
  FROM t1;
CREATE VIEW v3 AS SELECT b, d, 
      max(d) OVER (PARTITION BY b),
      row_number() OVER (PARTITION BY b)
  FROM t1;
CREATE TABLE t2(x, y, z);
INSERT INTO t2 VALUES('W', 3, 1);
INSERT INTO t2 VALUES('W', 2, 2);
INSERT INTO t2 VALUES('X', 1, 4);
INSERT INTO t2 VALUES('X', 5, 7);
INSERT INTO t2 VALUES('Y', 1, 9);
INSERT INTO t2 VALUES('Y', 4, 2);
INSERT INTO t2 VALUES('Z', 3, 3);
INSERT INTO t2 VALUES('Z', 3, 4);
SELECT * FROM (
      SELECT x, sum(y) AS s, max(z) AS m 
      FROM t2 GROUP BY x
    );
SELECT * FROM (
      SELECT x, sum(y) AS s, max(z) AS m,
        max( max(z) ) OVER (PARTITION BY sum(y) 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      FROM t2 GROUP BY x
    );
SELECT * FROM (
      SELECT x, sum(y) AS s, max(z) AS m,
        max( max(z) ) OVER (PARTITION BY sum(y) 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      FROM t2 GROUP BY x
    ) WHERE s=6;
SELECT * FROM (
      SELECT x, sum(y) AS s, max(z) AS m,
        max( max(z) ) OVER (PARTITION BY sum(y) 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      FROM t2 GROUP BY x
    ) WHERE s<6;
SELECT * FROM (
      SELECT x, sum(y) AS s, max(z) AS m 
      FROM t2 GROUP BY x
    );
SELECT * FROM (
      SELECT x, sum(y) AS s, max(z) AS m,
        max( max(z) ) OVER (PARTITION BY sum(y) 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      FROM t2 GROUP BY x
    );
SELECT * FROM (
      SELECT x, sum(y) AS s, max(z) AS m,
        max( max(z) ) OVER (PARTITION BY sum(y) 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      FROM t2 GROUP BY x
    ) WHERE s=6;
SELECT * FROM (
      SELECT x, sum(y) AS s, max(z) AS m,
        max( max(z) ) OVER (PARTITION BY sum(y) 
            ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
        )
      FROM t2 GROUP BY x
    ) WHERE s<6;
