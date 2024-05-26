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
