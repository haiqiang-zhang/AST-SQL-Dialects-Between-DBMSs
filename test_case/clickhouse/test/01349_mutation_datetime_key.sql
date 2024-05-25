SELECT * FROM cdp_orders;
SET mutations_sync = 1;
ALTER TABLE cdp_orders DELETE WHERE order_time >= '2019-12-03 00:00:00';
SELECT * FROM cdp_orders;
DROP TABLE cdp_orders;
