
--
-- Test of ansi mode
--

--disable_warnings
drop table if exists t1;

set @@sql_mode="ANSI";
select @@sql_mode;

-- Test some functions that works different in ansi mode

SELECT 'A' || 'B';

-- Test GROUP BY behaviour

CREATE TABLE t1 (id INT, id2 int);
SELECT id,NULL,1,1.1,'a' FROM t1 GROUP BY id;
SELECT id FROM t1 GROUP BY id2;
drop table t1;

SET @@SQL_MODE="";
