CREATE TABLE t1(
    a TEXT PRIMARY KEY,
    b TEXT,
    FOREIGN KEY(b) REFERENCES t1(a)
  );
INSERT INTO t1 VALUES('abc',NULL),('xyz','abc');
PRAGMA writable_schema=on;
UPDATE sqlite_master SET sql='CREATE TABLE t1(
    a TEXT PRIMARY KEY,
    b TEXT,
    FOREIGN KEY(b COLLATE nocase) REFERENCES t1(a)
  )' WHERE name='t1';
