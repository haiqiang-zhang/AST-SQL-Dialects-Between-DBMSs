CREATE OR REPLACE TABLE data AS SELECT {'duck': 42} conversations, 42::bigint _id;;
PRAGMA create_fts_index('data', '_id', 'conversations');;
SELECT _id FROM (SELECT *, fts_main_data.match_bm25(_id, 'duck') AS score FROM data) sq WHERE score IS NOT NULL ORDER BY score DESC;;
