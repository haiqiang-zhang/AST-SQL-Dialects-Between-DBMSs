PRAGMA wal_autocheckpoint='1TB';
CREATE TABLE t2 (i INTEGER, uid VARCHAR);
INSERT INTO t2 SELECT i.range AS i, gen_random_uuid() AS uid FROM range(50000) AS i;
CREATE UNIQUE INDEX iu ON t2(uid);
