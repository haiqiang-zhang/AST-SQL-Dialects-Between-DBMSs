PRAGMA temp_store = memory;
CREATE TABLE t1(a,b,c);
INSERT INTO t1 VALUES(1, 2, 3);
PRAGMA integrity_check;
