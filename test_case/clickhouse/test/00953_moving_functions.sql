DROP TABLE IF EXISTS moving_sum_num;
DROP TABLE IF EXISTS moving_sum_dec;
CREATE TABLE moving_sum_num (
  k String,
  dt DateTime,
  v UInt64
)
ENGINE = MergeTree ORDER BY (k, dt);
INSERT INTO moving_sum_num
  SELECT 'b' k, toDateTime('2001-02-03 00:00:00')+number as dt, number as v
  FROM system.numbers
  LIMIT 5
  UNION ALL
  SELECT 'a' k, toDateTime('2001-02-03 00:00:00')+number as dt, number as v
  FROM system.numbers
  LIMIT 5;
INSERT INTO moving_sum_num
  SELECT 'b' k, toDateTime('2001-02-03 01:00:00')+number as dt, 5+number as v
  FROM system.numbers
  LIMIT 5;
-- aggregate states which is implementation defined in external aggregation.
SET max_bytes_before_external_group_by = 0;
CREATE TABLE moving_sum_dec ENGINE = Memory AS
  SELECT k, dt, toDecimal64(v, 2) as v
  FROM moving_sum_num;
DROP TABLE moving_sum_dec;
DROP TABLE moving_sum_num;