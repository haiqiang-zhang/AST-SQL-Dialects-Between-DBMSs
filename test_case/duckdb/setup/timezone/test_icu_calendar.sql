SET Calendar = 'gregorian';
SET TimeZone = 'America/Los_Angeles';
SET TimeZone = 'Asia/Tokyo';
CREATE TABLE timestamps AS SELECT ts::TIMESTAMPTZ AS ts, era FROM (VALUES
	('0645-06-30 00:00:00+00', 'Taika'),
	('1867-01-01 00:00:00+00', 'Keiou'),
	('1868-09-07 00:00:00+00', 'Keiou'),
	('1868-09-08 00:00:00+00', 'Meiji'),
	('1912-07-29 00:00:00+00', 'Meiji'),
	('1912-07-30 00:00:00+00', 'Taisho'),
	('1926-12-24 00:00:00+00', 'Taisho'),
	('1926-12-25 00:00:00+00', 'Showa'),
	('1989-01-06 00:00:00+00', 'Showa'),
	('1989-01-08 00:00:00+00', 'Heisei'),
	('2019-05-01 00:00:00+00', 'Reiwa'),
	('2022-01-01 00:00:00+00', 'Reiwa')
) tbl(ts, era);
SET Calendar = 'japanese';
SET CALENDAR='islamic-umalqura';
