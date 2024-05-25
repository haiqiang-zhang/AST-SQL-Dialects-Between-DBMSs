PRAGMA synchronous = NORMAL;
PRAGMA cache_size = 10;
CREATE TABLE t1(x, y, UNIQUE(x, y));
BEGIN;
BEGIN;
UPDATE t1 set x = x+10000;
PRAGMA integrity_check;
PRAGMA integrity_check;
