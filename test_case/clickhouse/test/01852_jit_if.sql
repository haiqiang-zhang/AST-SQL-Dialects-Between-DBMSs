SELECT 'test_jit_nonnull';
SELECT value, multiIf(value = 1, 2, value, 1, 0), if (value, 1, 0) FROM test_jit_nonnull;
DROP TABLE IF EXISTS test_jit_nullable;
CREATE TABLE test_jit_nullable (value Nullable(UInt8)) ENGINE = TinyLog;
INSERT INTO test_jit_nullable VALUES (0), (1), (NULL);
SELECT 'test_jit_nullable';
DROP TABLE test_jit_nonnull;
DROP TABLE test_jit_nullable;
