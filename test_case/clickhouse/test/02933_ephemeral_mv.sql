CREATE MATERIALIZED VIEW parse_mv_eph
TO parsed_eph
AS
SELECT
  name,
  toUInt32(num) as num_ephemeral
FROM raw;
INSERT INTO raw VALUES ('3', '3'), ('42', '42');
SELECT name, num FROM parsed_eph;
DROP VIEW parse_mv_eph;
DROP TABLE parsed_eph;
DROP TABLE raw;
