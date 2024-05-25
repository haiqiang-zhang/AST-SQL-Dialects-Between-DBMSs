CREATE INDEX t1c60 ON t1(c60);
CREATE VIEW v1 AS
    SELECT c16 AS a, *, counter(1) AS x FROM t1
    UNION ALL
    SELECT c17 AS a, *, counter(1) AS x FROM t1
    UNION ALL
    SELECT c18 AS a, *, counter(1) AS x FROM t1
    UNION ALL
    SELECT c19 AS a, *, counter(1) AS x FROM t1;
DROP TABLE IF EXISTS t1;
CREATE TABLE t1(a INTEGER PRIMARY KEY, b TEXT);
SELECT 1 FROM (SELECT DISTINCT name COLLATE rtrim FROM sqlite_schema
                 UNION ALL SELECT a FROM t1);
SELECT DISTINCT name COLLATE rtrim FROM sqlite_schema 
    UNION ALL 
  SELECT a FROM t1;
CREATE TABLE t2 (val2);
