

SYSTEM DROP QUERY CACHE;
SELECT '-- Bug 56258: Check literals (ASTLiteral)';
SELECT count(*) FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
SELECT '-- Bug 56258: Check functions (ASTFunction)';
SELECT count(*) FROM system.query_cache;
SYSTEM DROP QUERY CACHE;
SELECT '-- Bug 56258: Check identifiers (ASTIdentifier)';
DROP TABLE IF EXISTS tab;
CREATE TABLE tab(c UInt64) ENGINE = Memory AS SELECT 1;
SELECT count(*) FROM system.query_cache;
DROP TABLE tab;
SYSTEM DROP QUERY CACHE;
