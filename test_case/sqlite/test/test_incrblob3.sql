ATTACH 'test.db2' AS aux;
INSERT INTO t1 VALUES(4, 'hello');
INSERT INTO aux.t1 VALUES(4, 'world');
