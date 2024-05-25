set allow_deprecated_syntax_for_merge_tree=1;
CREATE TABLE alias_local10 (
  Id Int8,
  EventDate Date DEFAULT '2000-01-01',
  field1 Int8,
  field2 String,
  field3 ALIAS CASE WHEN field1 = 1 THEN field2 ELSE '0' END
) ENGINE = MergeTree(EventDate, (Id, EventDate), 8192);
INSERT INTO alias_local10 (Id, EventDate, field1, field2) VALUES (1, '2000-01-01', 1, '12345'), (2, '2000-01-01', 2, '54321'), (3, '2000-01-01', 0, '');
SELECT field1, field2, field3 FROM alias_local10;
SELECT field1, field2, field3 FROM alias_local10 WHERE EventDate='2000-01-01';
SELECT field1, field2 FROM alias_local10 WHERE EventDate='2000-01-01';
SELECT field1, field2, field3 FROM alias_local10;
SELECT field1, field2, field3 FROM alias_local10 WHERE EventDate='2000-01-01';
SELECT field1, field2 FROM alias_local10 WHERE EventDate='2000-01-01';
DROP TABLE alias_local10;