
--
-- Bug#17733 Flushing logs causes daily server crash
--

select @@GLOBAL.binlog_expire_logs_seconds into @save_binlog_expire_logs_seconds;
set global binlog_expire_logs_seconds = 259200;
set @@GLOBAL.binlog_expire_logs_seconds = @save_binlog_expire_logs_seconds;
