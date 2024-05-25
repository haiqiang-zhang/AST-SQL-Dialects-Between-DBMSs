PRAGMA page_size = 1024;
PRAGMA auto_vacuum = incremental;
CREATE TABLE t1(x);
CREATE TABLE t2(x);
CREATE TABLE t3(x);
PRAGMA incremental_vacuum(248);
PRAGMA incremental_vacuum(1);
PRAGMA integrity_check;
