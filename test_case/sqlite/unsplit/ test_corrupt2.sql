PRAGMA auto_vacuum=0;
PRAGMA page_size=1024;
CREATE TABLE abc(a, b, c);
SELECT * FROM sqlite_master;
SELECT * FROM sqlite_master;
PRAGMA quick_check;
PRAGMA quick_check;
CREATE INDEX a1 ON abc(a);
CREATE INDEX a2 ON abc(b);
PRAGMA writable_schema = 1;
UPDATE sqlite_master 
      SET name = 'a3', sql = 'CREATE INDEX a3' || substr(sql, 16, 10000)
      WHERE type = 'index';
PRAGMA writable_schema = 0;
SELECT * FROM sqlite_master;
pragma incremental_vacuum = 1;
pragma incremental_vacuum = 1;
pragma incremental_vacuum = 1;
BEGIN EXCLUSIVE;
SELECT sql FROM sqlite_master;
PRAGMA incremental_vacuum;
PRAGMA incremental_vacuum;
PRAGMA integrity_check;
PRAGMA freelist_count;
PRAGMA freelist_count;
PRAGMA integrity_check;
PRAGMA integrity_check;
