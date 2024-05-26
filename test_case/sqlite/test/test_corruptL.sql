SELECT * FROM sqlite_master;
PRAGMA writable_schema=ON;
INSERT INTO t1(b,c) VALUES(5,6);
PRAGMA writable_schema=ON;
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
PRAGMA wal_checkpoint;
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
