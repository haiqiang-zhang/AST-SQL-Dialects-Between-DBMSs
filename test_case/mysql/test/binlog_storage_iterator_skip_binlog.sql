--

call mtr.add_suppression("\\[Warning\\] \\[[^]]*\\] \\[[^]]*\\] You need to use --log-bin to make --binlog-format work.");
SELECT * FROM performance_schema.binlog_storage_iterator_entries;
