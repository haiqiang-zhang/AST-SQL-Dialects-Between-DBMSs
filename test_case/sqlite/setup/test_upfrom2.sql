CREATE TABLE log(t TEXT);
CREATE TABLE t1(x PRIMARY KEY, y, z UNIQUE);
CREATE INDEX t1y ON t1(y);
INSERT INTO t1 VALUES(1, 'i',   'one');
INSERT INTO t1 VALUES(2, 'ii',  'two');
INSERT INTO t1 VALUES(3, 'iii', 'three');
INSERT INTO t1 VALUES(4, 'iv',  'four');
