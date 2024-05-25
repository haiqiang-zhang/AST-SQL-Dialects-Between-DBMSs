VACUUM;
CREATE TABLE t1(x INTEGER PRIMARY KEY AUTOINCREMENT, y);
PRAGMA writable_schema = 1;
UPDATE sqlite_schema 
      SET sql = 'CREATE TABLE sqlite_sequence(name-seq)' 
      WHERE name = 'sqlite_sequence';
PRAGMA writable_schema = 1;
INSERT INTO t1(y) VALUES('abc');
CREATE TABLE x1(a INTEGER PRIMARY KEY, b UNIQUE, c UNIQUE);
INSERT INTO x1 VALUES(1, 1, 2);
INSERT INTO x1 VALUES(2, 2, 3);
INSERT INTO x1 VALUES(3, 3, 4);
INSERT INTO x1 VALUES(4, 5, 6);
PRAGMA writable_schema = 1;
UPDATE sqlite_schema SET rootpage = (
      SELECT rootpage FROM sqlite_schema WHERE name = 'sqlite_autoindex_x1_2'
    ) WHERE name = 'sqlite_autoindex_x1_1';
PRAGMA writable_schema = 1;
REPLACE INTO x1 VALUES(5, 2, 3);
PRAGMA writable_schema = 1;
PRAGMA writable_schema = 1;
SELECT * FROM t1;
PRAGMA auto_vacuum = 0;
PRAGMA page_size=1024;
CREATE TABLE t2(a);
PRAGMA writable_schema=ON;
UPDATE sqlite_schema SET rootpage=3 WHERE rowid=2;
PRAGMA writable_schema=RESET;
-- Make "t1" a large table. Large enough that the children of the root
  -- node are interior nodes.
  PRAGMA page_size = 1024;
-- Set the root of table t2 to 137 - the leftmost child of the root of t1.
  PRAGMA writable_schema = ON;
UPDATE sqlite_schema SET rootpage = 137 WHERE name='t2';
PRAGMA writable_schema = RESET;
