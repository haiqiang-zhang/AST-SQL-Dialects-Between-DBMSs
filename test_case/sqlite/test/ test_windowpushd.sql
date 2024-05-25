CREATE INDEX i1 ON t1(grp_id);
CREATE VIEW lll AS SELECT
    row_number() OVER (PARTITION BY grp_id), 
    grp_id, id 
  FROM t1;
INSERT INTO t1 VALUES
    (1, 2), (2, 3), (3, 3), (4, 1), (5, 1),
    (6, 1), (7, 1), (8, 1), (9, 3), (10, 3), 
    (11, 2), (12, 3), (13, 3), (14, 2), (15, 1),
    (16, 2), (17, 1), (18, 2), (19, 3), (20, 2);
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
