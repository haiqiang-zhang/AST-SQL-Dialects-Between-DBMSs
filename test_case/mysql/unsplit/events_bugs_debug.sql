CREATE EVENT event1 ON SCHEDULE EVERY 1 YEAR DO SELECT 1;
SELECT @@event_scheduler='DISABLED';
