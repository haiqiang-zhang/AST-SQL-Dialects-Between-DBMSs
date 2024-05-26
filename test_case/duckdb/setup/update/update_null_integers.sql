SET wal_autocheckpoint='1TB';
CREATE TABLE t(i int, j int);
INSERT INTO t SELECT ii, NULL FROM range(1024) tbl(ii);
