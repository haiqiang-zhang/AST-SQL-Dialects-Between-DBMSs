SHOW CREATE TABLE non_metadata_alters;
ALTER TABLE non_metadata_alters MODIFY COLUMN value1 String DEFAULT 'X';
ALTER TABLE non_metadata_alters MODIFY COLUMN value2 Enum8('Hello' = 1, 'World' = 2, '!' = 3);
ALTER TABLE non_metadata_alters MODIFY COLUMN value3 Date;
ALTER TABLE non_metadata_alters ADD COLUMN value6 Decimal(3, 3);
SHOW CREATE TABLE non_metadata_alters;
DROP TABLE IF EXISTS non_metadata_alters;
