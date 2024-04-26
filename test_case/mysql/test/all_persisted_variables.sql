--    that variables in performance_schema.global_variables are actually
--    settable with SET GLOBAL.
-- 1. Check that there are no persisted variable settings due to improper
--    cleanup by other testcases.
-- 2. Test SET PERSIST. Verify persisted variables.
-- 3. Restart server, it must preserve the persisted variable settings.
--    Verify persisted configuration.
-- 4. Test RESET PERSIST IF EXISTS. Verify persisted variable settings are
--    removed.
-- 5. Clean up.

-- Note - Currently there are $total_global_vars global variables
--      -> SELECT COUNT(*) FROM performance_schema.global_variables
-- In future, if a new global variable is added, it will be automatically
-- picked up from performance_schema.global_variables table.
--
-- Out of all $total_global_vars global vars, only $total_persistent_vars are
-- global persistent variable. In future, if a new global persistent variable is
-- added, it is the responsibility of the Dev to edit $total_persistent_vars.
--###############################################################################

--echo ***********************************************************************
--echo * Run only on debug build,non-windows as few server variables are not
--echo * available on all platforms.
--echo ***********************************************************************
--source include/have_debug.inc
--source include/not_windows.inc
--source include/have_binlog_format_row.inc
call mtr.add_suppression("Failed to set up SSL because of the following SSL library error");

let $total_global_vars=`SELECT COUNT(*)
   FROM performance_schema.global_variables
   WHERE variable_name NOT LIKE 'ndb_%'
   AND variable_name NOT LIKE 'debug_%'
   AND variable_name NOT LIKE '%telemetry%'`;
let $total_persistent_vars=445;

CREATE TABLE global_vars (id INT PRIMARY KEY AUTO_INCREMENT, var_name VARCHAR(64), var_value VARCHAR(1024));

-- Following variables cannot be set in this format:
-- -> SET GLOBAL innodb_monitor_enable = @@global.innodb_monitor_enable
-- ERROR 1231 (42000): Variable 'innodb_monitor_enable' can't be set to the value of 'NULL'
-- -> SET GLOBAL innodb_monitor_disable = @@global.innodb_monitor_disable;
INSERT INTO global_vars (var_name, var_value) SELECT * FROM
performance_schema.global_variables WHERE variable_name NOT IN
('innodb_monitor_enable',
'innodb_monitor_disable',
'innodb_monitor_reset',
'innodb_monitor_reset_all',
'rbr_exec_mode');

CREATE TABLE all_vars (id INT PRIMARY KEY AUTO_INCREMENT, var_name VARCHAR(64), var_value VARCHAR(1024));

-- Currently we are not able to test below global variables
-- 1. rbr_exec_mode
--
-- because of open bugs (listed below).
--
-- Bug#27534122 - RBR_EXEC_MODE DOES NOT SUPPORT GLOBAL SCOPE
--
-- Once the bugs is fixed, below $bug_var_count must be modified along with the query.

--let $bug_var_count=1
--expr $expected_var_count=$total_global_vars - $bug_var_count

INSERT INTO all_vars (var_name, var_value)
SELECT * FROM performance_schema.global_variables
WHERE variable_name NOT IN
('rbr_exec_mode')
AND variable_name NOT LIKE 'ndb_%'
AND variable_name NOT LIKE 'debug_%'
AND variable_name NOT LIKE '%telemetry%'
ORDER BY variable_name;
{
  --let $var_names= `SELECT var_name FROM all_vars WHERE id=$var_id;
SET PERSIST innodb_monitor_enable="latch";
SET PERSIST innodb_monitor_disable="latch";
SET PERSIST innodb_monitor_reset="latch";
SET PERSIST innodb_monitor_reset_all="latch";
{
  --let $var_names= `SELECT var_name FROM all_vars WHERE id=$var_id`
  --eval RESET PERSIST IF EXISTS $var_names
  --inc $var_id
}
--enable_query_log
--enable_warnings

--echo
--let $assert_text= 'Expect 0 persisted variables.'
--let $assert_cond= [SELECT COUNT(*) as count FROM performance_schema.persisted_variables, count, 1] = 0
--source include/assert.inc

--echo
--echo ************************************************************
--echo * 5. Clean up.
--echo ************************************************************

--let $count_vars=
--let $var_id=
--let $var_names=
--remove_file $MYSQLD_DATADIR/mysqld-auto.cnf
DROP TABLE all_vars;
DROP TABLE global_vars;
