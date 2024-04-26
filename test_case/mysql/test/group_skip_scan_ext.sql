
let $engine=innodb;

-- Test for table having an index with mixed keyparts(asc/desc)
ALTER TABLE t ADD KEY k2(a DESC, b, c DESC, d);
SELECT a, b, MIN(d) FROM t
WHERE (a > 4) AND (c = 3 or c = 40) AND (d > 7)  GROUP BY a, b;
SELECT a, b, MIN(d) FROM t
WHERE (a > 4) AND (c = 3 or c = 40) AND (d > 7)  GROUP BY a, b;
ALTER TABLE t DROP KEY k2;

-- Tests below shouldn't use LIS due to non-equality prefix
-- ranges.

EXPLAIN SELECT a, b FROM t  WHERE (a > 4) AND (c = 3 OR c > 6)  GROUP BY a, b;
        (d = -1 OR d = -2 OR d > 7)  GROUP BY a, b;

-- Test if result is correct if only skip_scan key part is descending.
ALTER TABLE t DROP KEY k1;
ALTER TABLE t ADD KEY k1(a, b, c, d DESC);
SELECT a, b, MIN(d) FROM t WHERE (a > 9) AND (c = 3) GROUP BY a, b;
SELECT a, b, MIN(d), MAX(d) FROM t WHERE (a > 9) AND (c = 3) GROUP BY a, b;


ALTER TABLE t DROP KEY k1;
ALTER TABLE t ADD KEY k1(a DESC, b, c DESC, d);

ALTER TABLE t DROP KEY k1;
ALTER TABLE t ADD KEY k1(a, b DESC, c, d DESC);

DROP TABLE t;

let $engine=myisam;

DROP TABLE t;
