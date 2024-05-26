SET allow_experimental_analyzer = 1;
SET compile_aggregate_expressions = 1;
SET min_count_to_compile_aggregate_expression = 0;
DROP TABLE IF EXISTS lc_00906__fuzz_46;
CREATE TABLE lc_00906__fuzz_46 (`b` Int64) ENGINE = MergeTree ORDER BY b;
INSERT INTO lc_00906__fuzz_46 SELECT '0123456789' FROM numbers(10);
