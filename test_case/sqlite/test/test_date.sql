SELECT coalesce(julianday('2000-01-01'),'NULL');
SELECT datetime('2000-10-29 12:00:00','localtime');
SELECT strftime('%Y-%m-%d %H:%M:%f', julianday('2006-09-24T10:50:26.047'));
PRAGMA auto_vacuum=OFF;
PRAGMA page_size = 1024;
CREATE TABLE t1(x);
INSERT INTO t1 VALUES(1.1);
