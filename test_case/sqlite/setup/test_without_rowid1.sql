CREATE TABLE t1(a,b,c,d, PRIMARY KEY(c,a)) WITHOUT ROWID;
CREATE INDEX t1bd ON t1(b, d);
INSERT INTO t1 VALUES('journal','sherman','ammonia','helena');
INSERT INTO t1 VALUES('dynamic','juliet','flipper','command');
INSERT INTO t1 VALUES('journal','sherman','gamma','patriot');
INSERT INTO t1 VALUES('arctic','sleep','ammonia','helena');
