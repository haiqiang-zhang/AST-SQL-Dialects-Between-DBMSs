SELECT c FROM t1 WHERE a>'abc';
PRAGMA integrity_check;
SELECT c FROM t1 ORDER BY a;
SELECT rowid FROM t1 WHERE a='abc' and b='xyz123456789XYZ';
