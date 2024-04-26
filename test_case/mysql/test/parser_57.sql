--

--echo --
--echo -- Test pushing/not pushing of the LIMIT/ORDER BY clauses down into a
--echo -- parenthesized query block.
--echo --

CREATE TABLE t1 (k SERIAL, i INT) ENGINE=InnoDB;
INSERT INTO t1 (i) VALUES (10), (2), (30), (4), (50);

DROP TABLE t1;
