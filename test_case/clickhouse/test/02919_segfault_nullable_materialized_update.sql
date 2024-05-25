SELECT b, c, d FROM crash_02919;
ALTER TABLE crash_02919 UPDATE b = 1 WHERE 1=1 SETTINGS mutations_sync = 1;
SELECT b, c, d FROM crash_02919;
ALTER TABLE crash_02919 UPDATE b = 0.1 WHERE 1=1 SETTINGS mutations_sync = 1;
SELECT b, c, d FROM crash_02919;
DROP TABLE crash_02919;
