CREATE TABLE t1 (id INT PRIMARY KEY AUTO_INCREMENT, name VARCHAR(64), val VARCHAR(1024));
INSERT INTO t1(name, val) VALUES ('dummy', 0);
INSERT INTO t1(name, val) SELECT * FROM performance_schema.global_status WHERE variable_name='Handler_commit';
SELECT (SELECT val FROM t1 WHERE id = 3) - (SELECT val FROM t1 WHERE id = 2) = 1 + @binlog_handler_commit;
DROP TABLE t1;
