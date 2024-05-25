SELECT count() from 02581_trips WHERE description = '';
SELECT name FROM system.parts WHERE database=currentDatabase() AND table = '02581_trips' AND active ORDER BY name;
SYSTEM STOP MERGES 02581_trips;
ALTER TABLE 02581_trips UPDATE description='5' WHERE id IN (SELECT (number*10 + 5)::UInt32 FROM numbers(200000000)) SETTINGS mutations_sync=0;
ALTER TABLE 02581_trips UPDATE description='6' WHERE id IN (SELECT (number*10 + 6)::UInt32 FROM numbers(200000000)) SETTINGS mutations_sync=0;
ALTER TABLE 02581_trips DELETE WHERE id IN (SELECT (number*10 + 7)::UInt32 FROM numbers(200000000)) SETTINGS mutations_sync=0;
ALTER TABLE 02581_trips UPDATE description='8' WHERE id IN (SELECT (number*10 + 8)::UInt32 FROM numbers(200000000)) SETTINGS mutations_sync=0;
SYSTEM START MERGES 02581_trips;
SELECT count(), _part from 02581_trips WHERE description = '' GROUP BY _part ORDER BY _part;
