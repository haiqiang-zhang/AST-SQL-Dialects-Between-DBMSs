CREATE UNIQUE INDEX i3 ON t3(b);
CREATE UNIQUE INDEX i4 ON t4(c, d);
CREATE TABLE t1(a, b);
CREATE INDEX i1 ON t1(a);
EXPLAIN QUERY PLAN 
  SELECT * FROM t1 ORDER BY a;
CREATE TABLE t5(a INTEGER PRIMARY KEY,b,c,d,e,f,g);
CREATE INDEX t5b ON t5(b);
CREATE INDEX t5c ON t5(c);
CREATE INDEX t5d ON t5(d);
CREATE INDEX t5e ON t5(e);
CREATE INDEX t5f ON t5(f);
CREATE INDEX t5g ON t5(g);
CREATE INDEX i2 ON t1(b);
CREATE TABLE t2(x, y);
CREATE INDEX t2i1 ON t2(x);
CREATE INDEX t3i1 ON t3(b);
CREATE INDEX t1b ON t1(b);
CREATE TABLE composer(
    cid INTEGER PRIMARY KEY,
    cname TEXT
  );
CREATE TABLE album(
    aid INTEGER PRIMARY KEY,
    aname TEXT
  );
CREATE TABLE track(
    tid INTEGER PRIMARY KEY,
    cid INTEGER REFERENCES composer,
    aid INTEGER REFERENCES album,
    title TEXT
  );
CREATE INDEX track_i1 ON track(cid);
CREATE INDEX track_i2 ON track(aid);
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
INSERT INTO t1 DEFAULT VALUES;
ANALYZE;
