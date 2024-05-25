CREATE TABLE t1 (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(64), val VARCHAR(1024));
INSERT INTO t1(name, val) VALUES ('dummy', 0);
INSERT INTO t1(name, val) SELECT * FROM performance_schema.global_status WHERE variable_name='Handler_commit';
