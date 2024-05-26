SELECT 'Various intervals';
SELECT dateDiff('year', toDate('2017-12-31'), toDate('2016-01-01'));
SELECT 'Date and DateTime arguments';
SELECT 'Constant and non-constant arguments';
SELECT 'Case insensitive';
SELECT DATEDIFF('year', today(), today() - INTERVAL 10 YEAR);
SELECT 'Dependance of timezones';
SELECT 'Additional test';
