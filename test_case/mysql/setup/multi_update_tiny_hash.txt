drop table if exists t1, t2;
CREATE TABLE t1 (ID INT);
CREATE TABLE t2 (ID INT,
  s1 TEXT, s2 TEXT, s3 VARCHAR(10), s4 TEXT, s5 VARCHAR(10));
INSERT INTO t1 VALUES (1),(2);
INSERT INTO t2 VALUES (1,'test', 'test', 'test', 'test', 'test'),
                      (2,'test', 'test', 'test', 'test', 'test');
