
-- Save the initial number of concurrent sessions
--source include/count_sessions.inc

--disable_query_log
--disable_result_log

let $only_test = 0;
let $start_from = 1;
let $max_tests = 1000;
CREATE TABLE t1 (
  id INT NOT NULL AUTO_INCREMENT,
  c1 CHAR(60) NOT NULL,
  c2 CHAR(60),
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
INSERT INTO t1 (c1, c2) VALUES
('abcdefghij', 'ABCDEFGHIJ'),
('mnopqrstuv', 'MNOPQRSTUV');
let $memory_key = memory/temptable/physical_ram;
let $test_query = SELECT DISTINCT c1, c2 FROM t1 WHERE id BETWEEN 1 And 2 ORDER BY 1;
DROP TABLE t1;
CREATE TABLE t (c LONGBLOB);
INSERT INTO t VALUES
(REPEAT('a', 128)),
(REPEAT('b', 128)),
(REPEAT('c', 128)),
(REPEAT('d', 128));
SET GLOBAL temptable_max_ram = 2097152;
let $memory_key = memory/temptable/physical_disk;
let $test_query = SELECT * FROM t AS t1, t AS t2, t AS t3, t AS t4, t AS t5, t AS t6 ORDER BY 1 LIMIT 2;
SET GLOBAL temptable_max_ram = default;
DROP TABLE t;
