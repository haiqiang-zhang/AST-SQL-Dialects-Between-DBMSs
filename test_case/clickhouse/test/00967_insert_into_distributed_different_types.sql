set distributed_foreground_insert=1;
DROP TABLE IF EXISTS dist_00967;
DROP TABLE IF EXISTS underlying_00967;
SET send_logs_level='error';
CREATE TABLE underlying_00967 (key Nullable(UInt64)) Engine=TinyLog();
DROP TABLE underlying_00967;
