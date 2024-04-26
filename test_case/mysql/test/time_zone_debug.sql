CREATE TABLE t1 (a INT);
INSERT INTO t1 VALUES (1);
SET SESSION debug="+d,kill_query_on_open_table_from_tz_find";
SELECT CONVERT_TZ(a, a, a) FROM t1;
SET SESSION debug="-d,kill_query_on_open_table_from_tz_find";
DROP TABLE t1;

SET DEBUG='+d,mysql_lock_tables_kill_query';
SELECT CONVERT_TZ('2003-10-26 01:00:00', 'There-is-no-such-time-zone-1', 'UTC');
SET DEBUG='-d,mysql_lock_tables_kill_query';

SET DEBUG="+d,set_cet_before_dst";
SELECT @@SYSTEM_TIME_ZONE;
SET DEBUG="-d,set_cet_before_dst";
SET DEBUG="+d,set_cet_after_dst";
SELECT @@SYSTEM_TIME_ZONE;
SET DEBUG="-d,set_cet_after_dst";
