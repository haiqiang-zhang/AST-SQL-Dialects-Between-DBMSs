DROP TABLE IF EXISTS weird_partitions_02245;
CREATE TABLE weird_partitions_02245(d DateTime, d1 DateTime default d - toIntervalHour(8), id Int64)
Engine=MergeTree
PARTITION BY (toYYYYMM(toDateTime(d)), ignore(d1))
ORDER BY id;
INSERT INTO weird_partitions_02245(d, id)
SELECT
    toDateTime('2021-12-31 22:30:00') AS d,
    number
FROM numbers(1000);
INSERT INTO weird_partitions_02245(d, id)
SELECT
    toDateTime('2022-01-01 00:30:00') AS d,
    number
FROM numbers(1000);
INSERT INTO weird_partitions_02245(d, id)
SELECT
    toDateTime('2022-01-31 22:30:00') AS d,
    number
FROM numbers(1000);
INSERT INTO weird_partitions_02245(d, id)
SELECT
    toDateTime('2023-01-31 22:30:00') AS d,
    number
FROM numbers(1000);
OPTIMIZE TABLE weird_partitions_02245;
OPTIMIZE TABLE weird_partitions_02245;
SELECT DISTINCT _partition_id, _partition_value FROM weird_partitions_02245 ORDER BY _partition_id ASC;
SELECT _partition_id, min(d), max(d), min(d1), max(d1), count() FROM weird_partitions_02245 GROUP BY _partition_id ORDER BY _partition_id ASC;
select  DISTINCT _partition_id from weird_partitions_02245 where d >= '2021-12-31 00:00:00' and d < '2022-01-01 00:00:00' ORDER BY _partition_id;
explain estimate select  DISTINCT _partition_id from weird_partitions_02245 where d >= '2021-12-31 00:00:00' and d < '2022-01-01 00:00:00';
select  DISTINCT _partition_id from weird_partitions_02245 where d >= '2022-01-01 00:00:00' and  d1 >= '2021-12-31 00:00:00' and d1 < '2022-01-01 00:00:00' ORDER BY _partition_id;
explain estimate select  DISTINCT _partition_id from weird_partitions_02245 where d >= '2022-01-01 00:00:00' and d1 >= '2021-12-31 00:00:00' and d1 < '2022-01-01 00:00:00';
select  DISTINCT _partition_id from weird_partitions_02245 where d1 >= '2021-12-31 00:00:00' and d1 < '2022-01-01 00:00:00' ORDER BY _partition_id;
explain estimate select  DISTINCT _partition_id from weird_partitions_02245 where d1 >= '2021-12-31 00:00:00' and d1 < '2022-01-01 00:00:00';
select  DISTINCT _partition_id from weird_partitions_02245 where d >= '2022-01-01 00:00:00' and  d1 >= '2021-12-31 00:00:00' and d1 < '2020-01-01 00:00:00' ORDER BY _partition_id;
explain estimate select  DISTINCT _partition_id from weird_partitions_02245 where d >= '2022-01-01 00:00:00' and d1 >= '2021-12-31 00:00:00' and d1 < '2020-01-01 00:00:00';
DROP TABLE weird_partitions_02245;
