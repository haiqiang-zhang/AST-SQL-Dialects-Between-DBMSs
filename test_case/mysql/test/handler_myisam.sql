
-- t/handler_myisam.test
--
-- test of HANDLER ...
--
-- Last update:
-- 2006-07-31 ML test refactored (MySQL 5.1)
--               code of t/handler.test and t/innodb_handler.test united
--               main testing code put into include/handler.inc
--               rename t/handler.test to t/handler_myisam.test
--

let $engine_type= MyISAM;
let $other_engine_type= MEMORY;
let $other_handler_engine_type= MyISAM;
CREATE TABLE t1 AS SELECT 1 AS f1;
DROP TABLE t1;

CREATE TEMPORARY TABLE t1 AS SELECT 1 AS f1;
DROP TABLE t1;
CREATE TABLE t1(a INT, KEY(a));
INSERT INTO t1 VALUES(1);
DROP TABLE t1;
CREATE TABLE t1(a INT, b INT, PRIMARY KEY(a), KEY b(b), KEY ab(a, b));

INSERT INTO t1 VALUES (2, 20), (1, 10), (4, 40), (3, 30);

DROP TABLE t1;

CREATE TEMPORARY TABLE t1 AS SELECT 1 AS f1;
CREATE TEMPORARY TABLE IF NOT EXISTS t1 SELECT 1 AS f1;
ALTER TABLE t1 ADD COLUMN b INT;
CREATE INDEX b ON t1 (b);
DROP INDEX b ON t1;
DROP TABLE t1;

CREATE TEMPORARY TABLE t1(a INT, b INT, INDEX i(a));

set global keycache1.key_cache_block_size=2048;
set global keycache1.key_buffer_size=1*1024*1024;
set global keycache1.key_buffer_size=1024*1024;
