set allow_deprecated_syntax_for_merge_tree=1;
CREATE OR REPLACE TABLE alias_local10 (
  Id Int8,
  EventDate Date DEFAULT '2000-01-01',
  field1 Int8,
  field2 String,
  field3 ALIAS CASE WHEN field1 = 1 THEN field2 ELSE '0' END
) ENGINE = MergeTree(EventDate, (Id, EventDate), 8192);
SET prefer_localhost_replica = 0;
CREATE OR REPLACE TABLE local (x Int8) ENGINE = Memory;
SET prefer_localhost_replica = 0;
DROP TABLE local;
DROP TABLE alias_local10;
