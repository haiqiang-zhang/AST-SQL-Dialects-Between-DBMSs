DROP TABLE IF EXISTS grouping_sets;
CREATE TABLE grouping_sets(fact_1_id Int32, fact_2_id Int32, fact_3_id Int32, fact_4_id Int32, sales_value Int32) ENGINE = Memory;
INSERT INTO grouping_sets
SELECT
    number % 2 + 1 AS fact_1_id,
       number % 5 + 1 AS fact_2_id,
       number % 10 + 1 AS fact_3_id,
       number % 10 + 1 AS fact_4_id,
       number % 100 AS sales_value
FROM system.numbers limit 1000;
