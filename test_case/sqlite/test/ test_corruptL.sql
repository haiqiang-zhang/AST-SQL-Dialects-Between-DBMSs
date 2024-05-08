PRAGMA cell_size_check = off;
PRAGMA integrity_check;
PRAGMA writable_schema=ON;
CREATE TABLE t1(a, b, c, d INTEGER PRIMARY KEY);
CREATE TABLE t2(a, b, c, d INTEGER PRIMARY KEY);
INSERT INTO t1(a, b, c, d) VALUES (1, 2, 3, 100), (4, 5, 6, 101);
INSERT INTO t2(a, b, c, d) VALUES (1, 100, 3, 1000), (4, 101, 6, 1001);
CREATE INDEX t1a ON t1(a);
CREATE INDEX t2a ON t2(a, b, c);
PRAGMA writable_schema = 1;
UPDATE sqlite_master SET sql = 'CREATE INDEX t2a ON t2(a)' WHERE name='t2a';
INSERT INTO t1 SELECT * FROM t2;
PRAGMA writable_schema=ON;
INSERT INTO t1(b) VALUES(zeroblob(40000));
INSERT INTO t1(b) VALUES(zeroblob(40000));
BEGIN;
INSERT INTO t1(b) VALUES(1);
INSERT INTO t1(b) VALUES(2);
SELECT * FROM sqlite_master;
PRAGMA writable_schema=ON;
INSERT INTO t1(b,c) VALUES(5,6);
PRAGMA writable_schema=ON;
-- bypass improved sqlite_master consistency checking
  SELECT * FROM t1 WHERE a<='2019-05-09' ORDER BY a DESC;
PRAGMA writable_schema=ON;
SELECT CAST((SELECT b FROM t1 WHERE 16=c) AS int) FROM t1 WHERE 16=c;
PRAGMA integrity_check;
ALTER TABLE t1 RENAME TO alkjalkjdfiiiwuer987lkjwer82mx97sf98788s9789s;
PRAGMA cell_size_check = 0;
PRAGMA integrity_check;
CREATE TABLE t1(w, x, y, z, UNIQUE(w, x), UNIQUE(y, z));
INSERT INTO t1 VALUES(1, 1, 1, 1);
CREATE TABLE t1idx(x, y, i INTEGER, PRIMARY KEY(x)) WITHOUT ROWID;
INSERT INTO t1idx VALUES(10, NULL, 5);
PRAGMA writable_schema = 1;
UPDATE sqlite_master SET rootpage = (
    SELECT rootpage FROM sqlite_master WHERE name='t1idx'
  ) WHERE type = 'index';
PRAGMA writable_schema = ON;
INSERT INTO t1(rowid, w, x, y, z) VALUES(5, 10, 11, 10, NULL);
PRAGMA journal_mode = wal;
PRAGMA writable_schema=ON;
CREATE INDEX i1 ON t1((NULL));
INSERT INTO t1 VALUES(1, NULL, 1, 'text value');
PRAGMA writable_schema = on;
UPDATE sqlite_schema SET 
      sql = 'CREATE INDEX i1 ON t1(b, c, d)', 
      tbl_name = 't1', 
      type='index' 
  WHERE name='i1';
PRAGMA integrity_check;
