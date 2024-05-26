OPTIMIZE TABLE lwd_test_02521 FINAL SETTINGS mutations_sync = 1;
SET mutations_sync=1;
SELECT 'Rows in parts', SUM(rows) FROM system.parts WHERE database = currentDatabase() AND table = 'lwd_test_02521' AND active;
SELECT 'Count', count() FROM lwd_test_02521;
DELETE FROM lwd_test_02521 WHERE id < 25000;
ALTER TABLE lwd_test_02521 MODIFY TTL event_time + INTERVAL 1 MONTH SETTINGS mutations_sync = 1;
ALTER TABLE lwd_test_02521 DELETE WHERE id >= 40000 SETTINGS mutations_sync = 1;
OPTIMIZE TABLE lwd_test_02521 FINAL SETTINGS mutations_sync = 1;
DROP TABLE lwd_test_02521;
