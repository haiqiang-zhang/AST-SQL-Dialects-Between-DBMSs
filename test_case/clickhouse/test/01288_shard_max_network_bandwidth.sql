-- Limit to 100 KB/sec
SET max_network_bandwidth = 100000;
SET max_block_size = 100;
CREATE TEMPORARY TABLE times (t DateTime);
-- This query should execute in no less than 1.6 seconds if throttled.
INSERT INTO times SELECT now();
INSERT INTO times SELECT now();
SELECT max(t) - min(t) >= 1 FROM times;
