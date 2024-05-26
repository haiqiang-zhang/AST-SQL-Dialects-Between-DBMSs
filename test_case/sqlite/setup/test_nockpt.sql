PRAGMA auto_vacuum=OFF;
PRAGMA page_size = 1024;
PRAGMA journal_mode = wal;
CREATE TABLE c1(x, y, z);
INSERT INTO c1 VALUES(1, 2, 3);
INSERT INTO c1 VALUES(4, 5, 6);
INSERT INTO c1 VALUES(7, 8, 9);
