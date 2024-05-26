SET Calendar = 'gregorian';
SET TimeZone = 'America/Los_Angeles';
CREATE TABLE attimezone (ts TIMESTAMP, tstz TIMESTAMPTZ, ttz TIMETZ, tz VARCHAR);
INSERT INTO attimezone (VALUES
	('2001-02-16 20:38:40', '2001-02-16 19:38:40-08', '19:38:40-08', 'America/Phoenix'),
	('2001-02-16 18:38:40', '2001-02-16 20:38:40-05', '20:38:40-05', 'America/Phoenix'),
	('infinity', 'infinity', '19:38:40-08', 'America/Phoenix'),
	('-infinity', '-infinity', '20:38:40-05', 'America/Phoenix'),
	(NULL, NULL, NULL, 'America/Phoenix'),
	('2001-02-16 20:38:40', '2001-02-16 19:38:40-08', '19:38:40+08', 'Europe/Duck'),
	('2001-02-16 18:38:40', '2001-02-16 20:38:40-05', '20:38:40+15:59', 'Europe/Duck'),
	('infinity', 'infinity', '12:15:37.123456-08', 'Europe/Duck'),
	('-infinity', '-infinity', '20:38:40-15:59', 'Europe/Duck'),
	(NULL, NULL, NULL, 'Europe/Duck'),
	('2001-02-16 20:38:40', '2001-02-16 19:38:40-08', '19:38:40-08', NULL),
	('2001-02-16 18:38:40', '2001-02-16 20:38:40-05', '20:38:40-05', NULL),
	('infinity', 'infinity', '12:15:37.123456-08', NULL),
	('-infinity', '-infinity', '20:38:40-15:59', NULL),
);
SET TimeZone = 'Asia/Amman';
SET TimeZone = 'America/Chihuahua';
SET TimeZone = 'America/Ciudad_Juarez';
SET TimeZone = 'Egypt';
SET TimeZone = 'Asia/Beirut';
SET TimeZone = 'America/Nuuk';
SET TimeZone = 'America/Scoresbysund';
SET TimeZone = 'Asia/Almaty';
