CREATE TABLE test_02559__fuzz_20(`id1` Int16, `id2` Decimal(18, 14)) ENGINE = MergeTree ORDER BY id1;
INSERT INTO test_02559__fuzz_20 SELECT number, number FROM numbers(10);
SET enable_multiple_prewhere_read_steps=true, move_all_conditions_to_prewhere=true;
