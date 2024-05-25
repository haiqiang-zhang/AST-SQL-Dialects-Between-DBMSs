drop table if exists t1;
CREATE TABLE t1 (a text) character set gb2312;
INSERT INTO t1 VALUES (0xA2A1),(0xD7FE);
