PRAGMA auto_vacuum=0;
PRAGMA page_size=4096;
PRAGMA journal_mode=WAL;
CREATE TABLE t1(a,b);
WITH RECURSIVE c(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM c WHERE x<100)
      INSERT INTO t1(a,b) SELECT x, printf('%d-x%.*c',x,x,'x') FROM c;
PRAGMA integrity_check;
ATTACH ':memory:' AS aux1;
PRAGMA aux1.page_size=4096;
CREATE TABLE aux1.t2(a,b,c);
INSERT INTO t2 VALUES(11,12,13);
CREATE TABLE aux1.x3(x,y,z);
INSERT INTO x3(x,y,z) VALUES(1,'main',1),(2,'aux1',1);
CREATE TEMP TABLE saved_content(x);
PRAGMA integrity_check;
PRAGMA integrity_check;
DELETE FROM saved_content;
PRAGMA aux1.integrity_check;
PRAGMA aux1.integrity_check;
