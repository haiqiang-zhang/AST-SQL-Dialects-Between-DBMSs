SELECT * FROM t1 WHERE x='one';
PRAGMA integrity_check;
SELECT * FROM t1 WHERE x='one';
PRAGMA integrity_check;
PRAGMA page_size = 4096;
