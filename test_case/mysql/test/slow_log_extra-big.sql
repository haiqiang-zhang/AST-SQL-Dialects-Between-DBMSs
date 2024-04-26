
-- We'll be looking at the contents of the slow log later, and PS protocol
-- would give us extra lines for the prepare and drop phases.
--source include/no_ps_protocol.inc

--source include/big_test.inc
--source include/count_sessions.inc

SET @my_slow_logname = @@global.slow_query_log_file;
SET @my_lqt = @@global.long_query_time;
let BIG_LOG= `SELECT @@global.slow_query_log_file`;

--
-- Confirm that per-query stats work.
--
SET SESSION long_query_time = 20;
DROP TABLE IF EXISTS big_table_slow;
CREATE TABLE big_table_slow (id INT PRIMARY KEY AUTO_INCREMENT, v VARCHAR(100), t TEXT) ENGINE=InnoDB KEY_BLOCK_SIZE=8;

let $x = 200;
{
  eval INSERT INTO big_table_slow VALUES(2 * $x, LPAD("v", $x MOD 100, "b"), LPAD("a", ($x * 100) MOD 9000, "b"));
  dec $x;

SET GLOBAL long_query_time = 0;
SELECT COUNT(*) FROM big_table_slow;
SELECT COUNT(*) FROM big_table_slow;

SELECT COUNT(*) FROM big_table_slow WHERE id>100 AND id<200;

SELECT * FROM big_table_slow WHERE id=2;

SELECT COUNT(*) FROM big_table_slow WHERE id>100;

SELECT COUNT(*) FROM big_table_slow WHERE id<100;

-- wait for queries to complete
let $wait_condition=
  SELECT COUNT(*)=2 FROM performance_schema.threads WHERE name="thread/sql/one_connection" AND processlist_command="Sleep";

-- make sure we add no more log lines
SET GLOBAL long_query_time=@my_lqt;

-- change back to original log file
SET GLOBAL slow_query_log_file = @my_slow_logname;
DROP TABLE big_table_slow;
  if ($line =~ m/^-- Query_time/) {
    $line =~ m/(Rows_sent.*) Thread_id.* (Errno.*) Start.*/;
    print "$1 $2\n";
