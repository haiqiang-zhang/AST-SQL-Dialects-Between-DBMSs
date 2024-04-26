
-- When log-bin, skip-log-bin and binlog-format options are specified, mask the warning.
--disable_query_log
call mtr.add_suppression("\\[Warning\\] \\[[^]]*\\] \\[[^]]*\\] You need to use --log-bin to make --binlog-format work.");
