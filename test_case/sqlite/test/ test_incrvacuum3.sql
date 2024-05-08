CREATE TABLE t1(x UNIQUE);
INSERT INTO t1 VALUES(randomblob(400));
INSERT INTO t1 VALUES(randomblob(400));
INSERT INTO t1 SELECT randomblob(400) FROM t1;
--   4
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
--   8
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  16
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  32
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  64
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
-- 128
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
-- 256;
PRAGMA integrity_check;
DELETE FROM t1 WHERE rowid%8;
PRAGMA integrity_check;
BEGIN;
PRAGMA incremental_vacuum = 100;
INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  64
        INSERT INTO t1 SELECT randomblob(400) FROM t1;
-- 128
        INSERT INTO t1 SELECT randomblob(400) FROM t1;
PRAGMA integrity_check;
PRAGMA integrity_check;
PRAGMA integrity_check;
PRAGMA integrity_check;
INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  64
        PRAGMA incremental_vacuum = 1000;
INSERT INTO t1 SELECT randomblob(400) FROM t1;
-- 128
        INSERT INTO t1 SELECT randomblob(400) FROM t1;
PRAGMA integrity_check;
BEGIN;
INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  64
        PRAGMA incremental_vacuum = 1000;
INSERT INTO t1 SELECT randomblob(400) FROM t1;
PRAGMA integrity_check;
PRAGMA freelist_count;
SELECT count(*) FROM t1;
INSERT INTO t1 VALUES(randomblob(400));
INSERT INTO t1 VALUES(randomblob(400));
INSERT INTO t1 SELECT randomblob(400) FROM t1;
--   4
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
--   8
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  16
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  32
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  64
      INSERT INTO t1 SELECT randomblob(400) FROM t1;
PRAGMA integrity_check;
DELETE FROM t1 WHERE rowid%8;
PRAGMA integrity_check;
BEGIN;
PRAGMA incremental_vacuum = 100;
INSERT INTO t1 SELECT randomblob(400) FROM t1;
--  64
        INSERT INTO t1 SELECT randomblob(400) FROM t1;
-- 128
        INSERT INTO t1 SELECT randomblob(400) FROM t1;
PRAGMA integrity_check;
PRAGMA integrity_check;
PRAGMA integrity_check;
PRAGMA integrity_check;
--  64
        PRAGMA incremental_vacuum = 1000;
PRAGMA integrity_check;
BEGIN;
--  64
        PRAGMA incremental_vacuum = 1000;
PRAGMA integrity_check;
PRAGMA freelist_count;
SELECT count(*) FROM t1;
