pragma recursive_triggers = off;
CREATE TABLE FOO(bar integer);
INSERT INTO foo(bar) VALUES (1);
INSERT INTO foo(bar) VALUES (111);
CREATE TABLE t1(a,b,c);
INSERT INTO t1 VALUES(1,2,3);
CREATE TABLE t2(a,b,c);
INSERT INTO t2 VALUES(7,8,9);
