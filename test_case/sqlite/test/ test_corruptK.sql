PRAGMA page_size=1024;
PRAGMA auto_vacuum=0;
CREATE TABLE t1(x);
INSERT INTO t1 VALUES(randomblob(20));
INSERT INTO t1 VALUES(randomblob(100));
-- make this into a free slot
  INSERT INTO t1 VALUES(randomblob(27));
-- this one will be corrupt
  INSERT INTO t1 VALUES(randomblob(800));
DELETE FROM t1 WHERE rowid=2;
-- free the 100 byte slot
  PRAGMA page_count;
INSERT INTO t1 VALUES(randomblob(20));
PRAGMA page_size=1024;
PRAGMA auto_vacuum=0;
INSERT INTO t1 VALUES(randomblob(20));
INSERT INTO t1 VALUES(randomblob(20));
-- free this one
  INSERT INTO t1 VALUES(randomblob(20));
INSERT INTO t1 VALUES(randomblob(20));
-- and this one
  INSERT INTO t1 VALUES(randomblob(20));
-- corrupt this one.

  DELETE FROM t1 WHERE rowid IN(2, 4);
PRAGMA page_count;
INSERT INTO t1 VALUES(randomblob(900));
PRAGMA page_size=1024;
CREATE TABLE t2(a, b, c);
CREATE TABLE t3(a, b, c);
CREATE TABLE t4(a, b, c);
CREATE TABLE t5(a, b, c);
PRAGMA integrity_check;
