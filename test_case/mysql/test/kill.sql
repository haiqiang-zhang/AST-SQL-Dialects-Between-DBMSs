SET DEBUG_SYNC = 'RESET';
DROP TABLE IF EXISTS t1, t2, t3;
DROP FUNCTION IF EXISTS MY_KILL;
CREATE FUNCTION MY_KILL(tid INT) RETURNS INT
BEGIN
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;

-- Save id of con1
connection con1;
let $ID= `SELECT @id := CONNECTION_ID()`;
let $ignore= `SELECT @id := $ID`;
SET DEBUG_SYNC= 'thread_end SIGNAL con1_end';
SET DEBUG_SYNC= 'before_do_command_net_read SIGNAL con1_read';

-- Kill con1
connection con2;
SET DEBUG_SYNC='now WAIT_FOR con1_read';
let $wait_condition= SELECT MY_KILL(@id);
SET DEBUG_SYNC= 'now WAIT_FOR con1_end';
SET DEBUG_SYNC = 'RESET';
SELECT 1;
SELECT 1;
let $ignore= `SELECT @id := $ID`;
SELECT @id != CONNECTION_ID();
SELECT 4;
let $ID= `SELECT @id := CONNECTION_ID()`;
let $ignore= `SELECT @id := $ID`;
SET DEBUG_SYNC= 'thread_end SIGNAL con1_end';
SET DEBUG_SYNC= 'before_do_command_net_read SIGNAL con1_read WAIT_FOR kill';
SET DEBUG_SYNC= 'now WAIT_FOR con1_read';
let $wait_condition= SELECT MY_KILL(@id);
SET DEBUG_SYNC= 'now WAIT_FOR con1_end';
SET DEBUG_SYNC = 'RESET';
SELECT 1;
SELECT 1;
let $ignore= `SELECT @id := $ID`;
SELECT @id != CONNECTION_ID();
SELECT 4;

--
-- BUG#14851: killing long running subquery processed via a temporary table.
--

CREATE TABLE t1 (id INT PRIMARY KEY AUTO_INCREMENT);
CREATE TABLE t2 (id INT UNSIGNED NOT NULL);

INSERT INTO t1 VALUES
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0),
(0),(0),(0),(0),(0),(0),(0),(0), (0),(0),(0),(0),(0),(0),(0),(0);
INSERT t1 SELECT 0 FROM t1 AS a1, t1 AS a2 LIMIT 4032;

INSERT INTO t2 SELECT id FROM t1;
let $ID= `SELECT @id := CONNECTION_ID()`;
let $ignore= `SELECT @id := $ID`;
SET DEBUG_SYNC= 'thread_end SIGNAL con1_end';
SET DEBUG_SYNC= 'before_acos_function SIGNAL in_sync';
       (SELECT /*+ NO_BNL(a,b,c,d) */ DISTINCT a.id FROM t2 a, t2 b, t2 c, t2 d
          GROUP BY ACOS(1/a.id), b.id, c.id, d.id
          HAVING a.id BETWEEN 10 AND 20);
SET DEBUG_SYNC= 'now WAIT_FOR in_sync';
SET DEBUG_SYNC= 'now WAIT_FOR con1_end';
SELECT 1;
SET DEBUG_SYNC = 'RESET';
DROP TABLE t1, t2;

--
-- Test of blocking of sending ERROR after OK or EOF
--
connection con1;
let $ID= `SELECT @id := CONNECTION_ID()`;
let $ignore= `SELECT @id := $ID`;
SET DEBUG_SYNC= 'before_acos_function SIGNAL in_sync WAIT_FOR kill';
SET DEBUG_SYNC= 'now WAIT_FOR in_sync';
SELECT 1;
SELECT @id = CONNECTION_ID();
SET DEBUG_SYNC = 'RESET';

--
-- Bug#28598: mysqld crash when killing a long-running explain query.
--
connection con1;
let $ID= `SELECT @id := CONNECTION_ID()`;
let $ignore= `SELECT @id := $ID`;
let $tab_count= 40;

let $i= $tab_count;
{
  eval CREATE TABLE t$i (a$i INT, KEY(a$i));
  dec $i ;
SET SESSION optimizer_search_depth=0;

let $i=$tab_count;
{
  let $a= a$i;
  let $t= t$i;
  dec $i;
  if ($i)
  {
    let $comma=,;
    let $from=$comma$t$from;
    let $where=a$i=$a $and $where;
  }
  if (!$i)
  {
    let $from=FROM $t$from;
    let $where=WHERE $where;
  }
  let $and=AND;
SET DEBUG_SYNC= 'before_join_optimize SIGNAL in_sync WAIT_FOR continue';
SET DEBUG_SYNC= 'now WAIT_FOR in_sync';
SET DEBUG_SYNC= 'now SIGNAL continue';
let $i= $tab_count;
{
  eval DROP TABLE t$i;
  dec $i ;
SET DEBUG_SYNC = 'RESET';
let $ID= `SELECT @id := CONNECTION_ID()`;
SET DEBUG_SYNC= 'thread_end SIGNAL con1_end';
SET DEBUG_SYNC= 'now WAIT_FOR con1_end';
SELECT 1;
SELECT 1;
let $ignore= `SELECT @id := $ID`;
SELECT @id != CONNECTION_ID();
SET DEBUG_SYNC = 'RESET';

SET DEBUG_SYNC = 'RESET';
DROP FUNCTION MY_KILL;

CREATE TABLE t1 (col1 INT);
SET DEBUG_SYNC= 'before_execute_sql_command SIGNAL waiting WAIT_FOR killed';
SET DEBUG_SYNC= 'now WAIT_FOR waiting';
SET DEBUG_SYNC= 'now SIGNAL killed';
DROP TABLE t1;
SET DEBUG_SYNC= 'RESET';
