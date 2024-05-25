PRAGMA journal_mode = WAL;
CREATE TABLE t1(x);
CREATE INDEX i1 ON t1(x);
BEGIN;
PRAGMA integrity_check;
PRAGMA page_size=512;
PRAGMA journal_mode=WAL;
PRAGMA integrity_check;
