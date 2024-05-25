-- Tests vector search in ClickHouse, i.e. Annoy and Usearch indexes. Both index types share similarities in implementation and usage,
-- therefore they are tested in a single file.

-- This file tests that various conditions are checked during creation of vector search indexes.

SET allow_experimental_annoy_index = 1;
SET allow_experimental_usearch_index = 1;
DROP TABLE IF EXISTS tab;
SELECT 'At most two index arguments';
SELECT '1st argument (distance function) must be String';
SELECT 'Rejects unsupported distance functions';
SELECT '2nd argument (Annoy: number of trees, USearch: scalar kind) must be UInt64 (Annoy) / String (Usearch)';
SELECT 'Rejects unsupported scalar kinds (only Usearch)';
SELECT 'Must be created on single column';
SELECT 'Must be created on Array(Float32) or Tuple(Float32, Float, ...) columns';
SET allow_suspicious_low_cardinality_types = 1;
SELECT 'Rejects INSERTs of Arrays with different sizes';
