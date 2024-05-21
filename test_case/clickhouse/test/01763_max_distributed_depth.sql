SET prefer_localhost_replica = 1;
DROP TABLE IF EXISTS tt6;
DROP TABLE IF EXISTS tt7;
INSERT INTO tt6 VALUES (1, 1, 1, 1, 'ok');
SELECT * FROM tt6;
SET max_distributed_depth = 0;
INSERT INTO tt6 VALUES (1, 1, 1, 1, 'ok');
-- stack overflow
SELECT * FROM tt6;
DROP TABLE tt6;
DROP TABLE tt7;