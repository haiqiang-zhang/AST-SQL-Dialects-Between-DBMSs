SET system_events_show_zero_values = 1;
CREATE TEMPORARY TABLE t (x UInt64);
INSERT INTO t SELECT value FROM system.events WHERE event = 'OverflowBreak';
INSERT INTO t SELECT value FROM system.events WHERE event = 'OverflowBreak';
