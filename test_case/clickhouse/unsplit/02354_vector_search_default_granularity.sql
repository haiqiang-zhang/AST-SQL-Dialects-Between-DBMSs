

-- This file contains tests for the non-standard default granularity of vector search indexes.

SET allow_experimental_annoy_index = 1;
SET allow_experimental_usearch_index = 1;
SELECT 'Test the default index granularity for vector search indexes (CREATE TABLE AND ALTER TABLE), should be 100 million for Annoy and USearch';
SELECT '- Annoy';
DROP TABLE IF EXISTS tab;
SELECT granularity FROM system.data_skipping_indices WHERE database = currentDatabase() AND table = 'tab' AND name = 'idx';
CREATE TABLE tab (id Int32, vec Array(Float32)) ENGINE=MergeTree ORDER BY id;
SELECT granularity FROM system.data_skipping_indices WHERE database = currentDatabase() AND table = 'tab' AND name = 'idx';
SELECT '- Usearch';
DROP TABLE tab;
SELECT granularity FROM system.data_skipping_indices WHERE database = currentDatabase() AND table = 'tab' AND name = 'idx';
CREATE TABLE tab (id Int32, vec Array(Float32)) ENGINE=MergeTree ORDER BY id;
ALTER TABLE tab ADD INDEX idx(vec) TYPE usearch;
SELECT granularity FROM system.data_skipping_indices WHERE database = currentDatabase() AND table = 'tab' AND name = 'idx';
DROP TABLE tab;
