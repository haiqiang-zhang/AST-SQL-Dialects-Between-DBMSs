CREATE OR REPLACE TABLE data AS SELECT {'duck': 42} conversations, 42::bigint _id;
PRAGMA create_fts_index('data', '_id', 'conversations');
