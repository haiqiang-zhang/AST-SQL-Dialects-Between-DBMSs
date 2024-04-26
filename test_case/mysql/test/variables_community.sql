
--
-- Bug#24822: Patch: uptime_since_flush_status
--
--replace_column 2 --
show global status like "Uptime_%";
