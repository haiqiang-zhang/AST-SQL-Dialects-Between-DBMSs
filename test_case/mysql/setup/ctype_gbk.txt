drop table if exists t1;
CREATE TABLE t1 (a text) character set gbk;
INSERT INTO t1 VALUES (0xA3A0),(0xA1A1);
