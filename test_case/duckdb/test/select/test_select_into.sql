CREATE TABLE t (t TEXT);;
INSERT INTO t VALUES ('foo'), ('bar'), ('baz');;
SELECT * INTO t2 FROM t WHERE t LIKE 'b%';;
