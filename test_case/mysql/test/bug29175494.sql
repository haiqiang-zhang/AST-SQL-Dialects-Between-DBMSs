--

CREATE TABLE t1 (
  col_int_key integer,
  col_varchar varchar(1),
  col_varchar_key varchar(1),
  KEY k1 (col_int_key),
  KEY k2 (col_varchar_key)
);

INSERT INTO t1 VALUES (1,'f','5'),(2,'H','f'),(3,'D','u');

CREATE TABLE t2 (
  col_int_key integer,
  col_varchar varchar(1),
  col_varchar_key varchar(1),
  KEY k3 (col_int_key),
  KEY k4 (col_varchar_key)
);

INSERT INTO t2 VALUES (4,'w','c');

CREATE TABLE a (
  f1 varchar(1),
  KEY k5 (f1)
);

CREATE VIEW v1 AS SELECT f1 from a;

--
-- Print out the plan, so that we are sure the test doesn't go silently
-- ineffective.
--
--skip_if_hypergraph  -- The hypergraph optimizer chooses a different plan, so the test _is_ ineffective.
EXPLAIN FORMAT=tree SELECT col_varchar_key FROM t1
WHERE ( col_varchar_key, col_varchar_key ) NOT IN (
  SELECT alias1.col_varchar_key, alias1.col_varchar_key
  FROM (
    t1 AS alias1
    JOIN ( t1 AS alias2 JOIN t2 ON t2.col_varchar_key = alias2.col_varchar_key )
      ON ( t2.col_int_key = alias2.col_int_key AND alias2.col_varchar_key IN ( SELECT f1 FROM v1 ) ) )
  WHERE alias1.col_varchar >= 'Z' );

SELECT col_varchar_key FROM t1
WHERE ( col_varchar_key, col_varchar_key ) NOT IN (
  SELECT alias1.col_varchar_key, alias1.col_varchar_key
  FROM (
    t1 AS alias1
    JOIN ( t1 AS alias2 JOIN t2 ON t2.col_varchar_key = alias2.col_varchar_key )
      ON ( t2.col_int_key = alias2.col_int_key AND alias2.col_varchar_key IN ( SELECT f1 FROM v1 ) ) )
  WHERE alias1.col_varchar >= 'Z' );

DROP VIEW v1;
DROP TABLE t1, t2, a;