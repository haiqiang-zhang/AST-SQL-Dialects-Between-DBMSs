PRAGMA recursive_triggers = on;
CREATE TABLE t1(a, b, c);
CREATE TABLE log(t, a1, b1, c1, a2, b2, c2);
INSERT INTO t1 VALUES('A', 'B', 'C');
