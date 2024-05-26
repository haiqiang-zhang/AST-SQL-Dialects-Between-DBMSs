SET compile_expressions = 1;
SET min_count_to_compile_expression = 0;
DROP TABLE IF EXISTS test_jit_nonnull;
CREATE TABLE test_jit_nonnull (value UInt8) ENGINE = TinyLog;
INSERT INTO test_jit_nonnull VALUES (0), (1);
