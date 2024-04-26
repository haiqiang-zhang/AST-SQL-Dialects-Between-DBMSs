
let $global_tmp_storage_engine  = `select @@global.default_tmp_storage_engine`;
let $session_tmp_storage_engine = `select @@session.default_tmp_storage_engine`;
drop table if exists t1,t2;
drop view if exists v1;

-- Add a lot of keys to slow down check
create table t1(n int not null, key(n), key(n), key(n), key(n));

let $1=10000;
 dec $1;
insert into t1 values (200000);
drop table t1;


-- End of 4.1 tests

--
-- Bug#9897 Views: 'Check Table' crashes MySQL, with a view and a table
--          in the statement
--
Create table t1(f1 int);
Create table t2(f1 int);
Create view v1 as Select * from t1;
drop view v1;
drop table t1, t2;
DROP TABLE IF EXISTS t1;

CREATE TABLE t1(a INT);
SET lock_wait_timeout= 1;
DROP TABLE t1;


-- Wait till we reached the initial number of concurrent sessions
--source include/wait_until_count_sessions.inc


--echo --
--echo -- Bug#24741307: add last_checked_for_upgrade column to dd.tables table
--echo --

--echo -- Checking default storage engine (Innodb)
CREATE TABLE t1(i INT);

ALTER TABLE t1 CHANGE COLUMN i j INT, ALGORITHM=INPLACE;

ALTER TABLE t1 CHANGE COLUMN j k INT, ALGORITHM=COPY;

ALTER TABLE t1 ADD COLUMN l INT, ALGORITHM=INSTANT;
DROP TABLE t1;
CREATE TEMPORARY TABLE tt1(i INT);
DROP TABLE tt1;
CREATE VIEW w AS SELECT 1 AS a;
CREATE VIEW v AS SELECT a FROM w;
CREATE VIEW u AS SELECT * FROM v;
DROP VIEW u, v, w;
