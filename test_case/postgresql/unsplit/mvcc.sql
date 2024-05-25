BEGIN;
SET LOCAL enable_seqscan = false;
SET LOCAL enable_indexonlyscan = false;
SET LOCAL enable_bitmapscan = false;
CREATE TABLE clean_aborted_self(key int, data text);
CREATE INDEX clean_aborted_self_key ON clean_aborted_self(key);
INSERT INTO clean_aborted_self (key, data) VALUES (-1, 'just to allocate metapage');
ROLLBACK;
