select *, toTypeName(id), toTypeName(name) from t1;
SET join_use_nulls = 1;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
