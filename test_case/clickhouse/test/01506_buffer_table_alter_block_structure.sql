SELECT * FROM buf;
INSERT INTO buf (timestamp, s) VALUES (toDateTime('2020-01-01 00:06:00'), 'hello');
SELECT * FROM buf ORDER BY timestamp;
DROP TABLE IF EXISTS buf;
DROP TABLE IF EXISTS buf_dest;
