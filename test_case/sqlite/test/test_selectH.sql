SELECT 1 FROM (SELECT DISTINCT name COLLATE rtrim FROM sqlite_schema
                 UNION ALL SELECT a FROM t1);
SELECT DISTINCT name COLLATE rtrim FROM sqlite_schema 
    UNION ALL 
  SELECT a FROM t1;
CREATE TABLE t2 (val2);
