DROP TABLE IF EXISTS offset_without_limit;
CREATE TABLE offset_without_limit (
    value UInt32
) Engine = MergeTree()
  PRIMARY KEY value
  ORDER BY value;
INSERT INTO offset_without_limit SELECT * FROM system.numbers LIMIT 50;
