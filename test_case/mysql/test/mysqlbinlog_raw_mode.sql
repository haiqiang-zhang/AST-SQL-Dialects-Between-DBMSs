SELECT ((@id := id) - id) from information_schema.processlist where processlist.command like '%Binlog%' and state like '%Source has sent%';
DROP TABLE raw_mode_exit;
