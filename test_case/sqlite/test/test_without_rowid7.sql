SELECT b FROM t2;
PRAGMA index_info(t2);
SELECT *, '|' FROM pragma_index_info('t2');
PRAGMA index_xinfo(t2);
SELECT *, '|' FROM pragma_index_xinfo('t2');
CREATE TABLE t3(a, b, PRIMARY KEY(a COLLATE nocase, a));
PRAGMA index_info(t3);
