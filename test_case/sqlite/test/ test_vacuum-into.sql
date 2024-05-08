CREATE TABLE t1(
    a INTEGER PRIMARY KEY,
    b ANY,
    c INT AS (b+1),                          --- See "2024-04-09" block
    CHECK( typeof(b)!='integer' OR b>a-5 )   --- comment below
  );
WITH RECURSIVE c(x) AS (VALUES(1) UNION ALL SELECT x+1 FROM c WHERE x<100)
  INSERT INTO t1(a,b) SELECT x, randomblob(600) FROM c;
CREATE INDEX t1b ON t1(b);
DELETE FROM t1 WHERE a%2;
SELECT count(*), sum(a), sum(length(b)) FROM t1;
VACUUM main INTO ':memory:';
CREATE TABLE t2(name TEXT);
INSERT INTO t2 VALUES(':memory:');
VACUUM main INTO (SELECT name FROM t2);
PRAGMA page_size;
PRAGMA page_size=1024;
INSERT INTO t1 VALUES(1, 2);
PRAGMA synchronous = normal;
PRAGMA synchronous = full;
PRAGMA synchronous = off;
PRAGMA synchronous = extra;
PRAGMA fullfsync = 1;
PRAGMA synchronous = full;
