EXPLAIN SYNTAX SELECT count() FROM t_constraints_where WHERE b > 15;
DROP TABLE t_constraints_where;
CREATE TABLE t_constraints_where(a UInt32, b UInt32, CONSTRAINT c1 ASSUME b < 10) ENGINE = Memory;
INSERT INTO t_constraints_where VALUES (1, 7);
DROP TABLE t_constraints_where;
