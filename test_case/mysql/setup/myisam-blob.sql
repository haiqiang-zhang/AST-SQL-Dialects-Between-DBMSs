drop table if exists t1;
CREATE TABLE t1 (data LONGBLOB) ENGINE=myisam;
INSERT INTO t1 (data) VALUES (NULL);
UPDATE t1 set data=repeat('a',18*1024*1024);
