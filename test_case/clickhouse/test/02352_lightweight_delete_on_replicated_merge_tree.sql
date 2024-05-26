SELECT '-----Check that select and merge with lightweight delete.-----';
DROP TABLE IF EXISTS t_light_r1 SYNC;
DROP TABLE IF EXISTS t_light_r2 SYNC;
SELECT '-----Check fetch part with lightweight delete-----';
DROP TABLE IF EXISTS t_light_sync_r1 SYNC;
DROP TABLE IF EXISTS t_light_sync_r2 SYNC;
