SELECT 'Check total_bytes/total_rows for Distributed';
CREATE TABLE check_system_tables_null (key Int) Engine=Null();
SYSTEM STOP DISTRIBUTED SENDS check_system_tables;
SELECT total_bytes, total_rows FROM system.tables WHERE database = currentDatabase() AND name = 'check_system_tables';
SELECT total_bytes>0, total_rows FROM system.tables WHERE database = currentDatabase() AND name = 'check_system_tables';
SELECT total_bytes, total_rows FROM system.tables WHERE database = currentDatabase() AND name = 'check_system_tables';
DROP TABLE check_system_tables_null;
