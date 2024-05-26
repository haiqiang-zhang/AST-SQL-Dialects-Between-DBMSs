pragma recursive_triggers = off;
CREATE TABLE t1(a PRIMARY KEY, b);
INSERT INTO t1 VALUES('a', 'b');
INSERT INTO t1 VALUES('c', 'd');
