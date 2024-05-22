-- Tests vector search in ClickHouse, i.e. Annoy and Usearch indexes. Both index types share similarities in implementation and usage,
-- therefore they are tested in a single file.

-- This file contains tests for various bugs and special cases

SET allow_experimental_annoy_index = 1;
SET allow_experimental_usearch_index = 1;
SET allow_experimental_analyzer = 1;
DROP TABLE IF EXISTS tab;
SELECT 'Issue #52258: Empty Arrays or Arrays with default values are rejected';
SELECT '- Annoy';
SELECT '- Usearch';
SELECT 'It is possible to create parts with different Array vector sizes but there will be an error at query time';
SELECT '- Annoy';
SYSTEM STOP MERGES tab;
SELECT '- Usearch';
SYSTEM STOP MERGES tab;
SELECT 'Correctness of index with > 1 mark';
SELECT '- Annoy';
SELECT '- Usearch';
