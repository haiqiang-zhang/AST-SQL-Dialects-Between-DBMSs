DROP TABLE IF EXISTS non_metadata_alters;
CREATE TABLE non_metadata_alters (
  key UInt64,
  value1 String,
  value2 Enum8('Hello' = 1, 'World' = 2),
  value3 UInt16,
  value4 DateTime,
  value5 Date
)
ENGINE = MergeTree()
ORDER BY tuple();
SET allow_non_metadata_alters = 0;
ALTER TABLE non_metadata_alters MODIFY COLUMN value3 UInt16 TTL value5 + INTERVAL 5 DAY;
SET materialize_ttl_after_modify = 0;
ALTER TABLE non_metadata_alters MODIFY COLUMN value3 UInt16 TTL value5 + INTERVAL 5 DAY;
SHOW CREATE TABLE non_metadata_alters;
ALTER TABLE non_metadata_alters MODIFY COLUMN value1 String DEFAULT 'X';
ALTER TABLE non_metadata_alters MODIFY COLUMN value2 Enum8('Hello' = 1, 'World' = 2, '!' = 3);
ALTER TABLE non_metadata_alters MODIFY COLUMN value3 Date;
ALTER TABLE non_metadata_alters ADD COLUMN value6 Decimal(3, 3);
SHOW CREATE TABLE non_metadata_alters;
DROP TABLE IF EXISTS non_metadata_alters;
