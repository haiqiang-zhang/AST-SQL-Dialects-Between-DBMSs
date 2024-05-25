PRAGMA wal_autocheckpoint='1TB';;
CREATE TABLE t2 (i INTEGER, uid VARCHAR);;
INSERT INTO t2 SELECT i.range AS i, gen_random_uuid() AS uid FROM range(50000) AS i;;
CREATE UNIQUE INDEX iu ON t2(uid);;
CHECKPOINT;;
SELECT total_blocks < 6291456 / get_block_size('index_checkpoint') * 1.2 FROM pragma_database_size();;
