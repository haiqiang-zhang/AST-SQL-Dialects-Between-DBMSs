

-- This file tests various simple approximate nearest neighborhood (ANN) queries that utilize vector search indexes.

SET allow_experimental_annoy_index = 1;
SET allow_experimental_usearch_index = 1;
SELECT 'ARRAY, 10 rows, index_granularity = 8192, GRANULARITY = 1 million --> 1 granule, 1 indexed block';
DROP TABLE IF EXISTS tab_annoy;
DROP TABLE IF EXISTS tab_usearch;
SELECT '- Annoy: WHERE-type';
SELECT '- Annoy: ORDER-BY-type';
SELECT '- Usearch: WHERE-type';
SELECT '- Usearch: ORDER-BY-type';
SELECT '- Annoy: WHERE-type, EXPLAIN';
SELECT '- Annoy: ORDER-BY-type, EXPLAIN';
SELECT '- Usearch: WHERE-type, EXPLAIN';
SELECT '- Usearch: ORDER-BY-type, EXPLAIN';
SELECT 'ARRAY vectors, 12 rows, index_granularity = 3, GRANULARITY = 2 --> 4 granules, 2 indexed block';
SELECT '- Annoy: WHERE-type';
SELECT '- Annoy: ORDER-BY-type';
SELECT '- Usearch: WHERE-type';
SELECT '- Usearch: ORDER-BY-type';
SELECT '- Annoy: WHERE-type, EXPLAIN';
SELECT '- Annoy: ORDER-BY-type, EXPLAIN';
SELECT '- Usearch: WHERE-type, EXPLAIN';
SELECT '- Usearch: ORDER-BY-type, EXPLAIN';
SELECT 'TUPLE vectors and special cases';
SELECT '- Annoy: WHERE-type';
SELECT '- Annoy: ORDER-BY-type';
SELECT '- Usearch: WHERE-type';
SELECT '- Usearch: ORDER-BY-type';
SELECT '- Special case: MaximumDistance is negative';
SELECT '- Special case: MaximumDistance is negative';
SELECT '- Special case: setting "annoy_index_search_k_nodes"';
SELECT '- Special case: setting "max_limit_for_ann_queries"';
SELECT '- Special case: setting "max_limit_for_ann_queries"';
