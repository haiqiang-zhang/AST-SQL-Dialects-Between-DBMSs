CREATE TABLE t(c1 INT, KEY k1(c1));
INSERT INTO t VALUES (1),(2),(3),(5),(7);
SET DEBUG='+d,simulate_handler_read_failure';
SET DEBUG='-d,simulate_handler_read_failure';
DROP TABLE t;
