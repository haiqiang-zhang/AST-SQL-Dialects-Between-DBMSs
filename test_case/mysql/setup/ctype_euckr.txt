drop table if exists t1;
CREATE TABLE t1 (a text) character set euckr;
INSERT INTO t1 VALUES (0xA2E6),(0xFEF7);
