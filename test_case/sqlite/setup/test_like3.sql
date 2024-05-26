PRAGMA encoding=UTF8;
CREATE TABLE t1(a,b TEXT COLLATE nocase);
INSERT INTO t1(a,b)
     VALUES(1,'abc'),
           (2,'ABX'),
           (3,'BCD'),
           (4,x'616263'),
           (5,x'414258'),
           (6,x'424344');
CREATE INDEX t1ba ON t1(b,a);
