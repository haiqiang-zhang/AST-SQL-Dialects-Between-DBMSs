

-- /proc/uptime stands as 0 bytes when stat-ing it, but we should
-- be able to read its contents nevertheless.
--replace_regex /[0-9]+\.[0-9]+/<num>/
select load_file("/proc/uptime");

-- File larger than max_allowed_packet.
SET @old_net_buffer_length = @@global.net_buffer_length;
SET @old_max_allowed_packet= @@global.max_allowed_packet;
SET GLOBAL net_buffer_length = 1024;
SET GLOBAL max_allowed_packet = 1024;
select load_file("/proc/modules");
SET GLOBAL max_allowed_packet = @old_max_allowed_packet;
SET GLOBAL net_buffer_length = @old_net_buffer_length;

-- Special files, like pipes, should not be opened.
--error ER_TEXTFILE_NOT_READABLE
select load_file("/proc/self/fd/0");

-- Clean up for subsequent tests.
disconnect con2;

-- Check that we haven't broken anything permanently.
--replace_regex /[0-9]+\.[0-9]+/<num>/
select load_file("/proc/uptime");
