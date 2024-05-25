DROP TABLE IF EXISTS t1;
SET allow_experimental_statistic = 1;
CREATE TABLE t1 
(
    a Float64,
    b Int64,
    pk String,
) Engine = MergeTree() ORDER BY pk;
ALTER TABLE t1 MODIFY COLUMN a Float64 TTL toDateTime(b) + INTERVAL 1 MONTH;
ALTER TABLE t1 MODIFY COLUMN a Int64;
DROP TABLE t1;
