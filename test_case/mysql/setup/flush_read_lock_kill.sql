DROP TABLE IF EXISTS t1;
CREATE TABLE t1 (kill_id INT) engine = InnoDB;
INSERT INTO t1 VALUES(connection_id());
INSERT INTO t1 VALUES(connection_id());
