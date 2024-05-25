SELECT count() FROM logs AS plogs WHERE plogs.date = '2019-11-20';
INSERT INTO logs VALUES('2019-11-20 00:00:00');
SELECT count() FROM logs AS plogs WHERE plogs.date = '2019-11-20';
DROP TABLE logs;
