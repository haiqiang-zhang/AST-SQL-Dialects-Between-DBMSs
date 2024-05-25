CREATE TABLE t1(x, y);
CREATE TABLE t2(x,y,z);
PRAGMA writable_schema=on;
UPDATE sqlite_master SET sql='nonsense';
