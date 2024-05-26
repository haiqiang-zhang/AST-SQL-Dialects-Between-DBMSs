CREATE TABLE t1(a,b,c,d,e, PRIMARY KEY(a,b,c,a,b,c,d,a,b,c)) WITHOUT ROWID;
CREATE INDEX t1a ON t1(b, b);
