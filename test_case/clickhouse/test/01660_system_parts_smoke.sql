SYSTEM STOP MERGES data_01660;
SELECT _state FROM system.parts WHERE database = currentDatabase() AND table = 'data_01660';
SELECT name, _state FROM system.parts WHERE database = currentDatabase() AND table = 'data_01660';
SELECT name, active FROM system.parts WHERE database = currentDatabase() AND table = 'data_01660';
SELECT '# two parts';
INSERT INTO data_01660 VALUES (0);
INSERT INTO data_01660 VALUES (1);
SELECT _state FROM system.parts WHERE database = currentDatabase() AND table = 'data_01660';
SELECT name, _state FROM system.parts WHERE database = currentDatabase() AND table = 'data_01660' ORDER BY name;
SELECT name, active FROM system.parts WHERE database = currentDatabase() AND table = 'data_01660' ORDER BY name;
SELECT '# optimize';
SYSTEM START MERGES data_01660;
OPTIMIZE TABLE data_01660 FINAL;
SELECT count(), _state FROM system.parts WHERE database = currentDatabase() AND table = 'data_01660' GROUP BY _state ORDER BY _state;
-- Empty active parts are clearing by async process
-- Inactive parts are clearing by async process also
SELECT '# truncate';
TRUNCATE data_01660;
SELECT if (count() > 0, 'HAVE PARTS', 'NO PARTS'), _state FROM system.parts WHERE database = currentDatabase() AND table = 'data_01660' GROUP BY _state ORDER BY _state;
SELECT '# drop';
DROP TABLE data_01660;
SELECT * FROM system.parts WHERE database = currentDatabase() AND table = 'data_01660';
