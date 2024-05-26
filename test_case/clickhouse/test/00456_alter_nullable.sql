SELECT x FROM nullable_alter ORDER BY x;
ALTER TABLE nullable_alter MODIFY COLUMN x Nullable(String);
SELECT x FROM nullable_alter ORDER BY x;
INSERT INTO nullable_alter (x) VALUES ('xyz'), (NULL);
SELECT x FROM nullable_alter ORDER BY x NULLS FIRST;
ALTER TABLE nullable_alter MODIFY COLUMN x Nullable(FixedString(5));
SELECT x FROM nullable_alter ORDER BY x NULLS FIRST;
DROP TABLE nullable_alter;
