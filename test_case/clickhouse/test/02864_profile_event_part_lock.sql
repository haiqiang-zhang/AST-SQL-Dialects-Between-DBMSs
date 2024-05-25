SELECT any(value > 0) from system.events WHERE event = 'PartsLockHoldMicroseconds' or event = 'PartsLockWaitMicroseconds';
DROP TABLE IF EXISTS random_mt;
