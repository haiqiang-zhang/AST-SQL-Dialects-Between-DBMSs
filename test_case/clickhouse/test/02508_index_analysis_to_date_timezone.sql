SELECT uid, date, toDate(date) = toDate('2021-03-24') AS res FROM table WHERE res = 1 ORDER BY uid, date;
SELECT '---';
SELECT uid, date, toDate(date) = toDate('2021-03-24') AS res FROM table WHERE toDate(date) = toDate('2021-03-24') ORDER BY uid, date;
DROP TABLE table;
