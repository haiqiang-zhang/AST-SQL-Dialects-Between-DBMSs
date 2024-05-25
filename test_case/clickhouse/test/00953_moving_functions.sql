-- aggregate states which is implementation defined in external aggregation.
SET max_bytes_before_external_group_by = 0;
CREATE TABLE moving_sum_dec ENGINE = Memory AS
  SELECT k, dt, toDecimal64(v, 2) as v
  FROM moving_sum_num;
DROP TABLE moving_sum_dec;
DROP TABLE moving_sum_num;
