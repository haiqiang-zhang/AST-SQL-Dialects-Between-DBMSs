SELECT cast('1234' AS UInt32);
SELECT substring('1234' FROM 2);
SELECT trim(LEADING 'a' AS arg_1 FROM 'abca' AS arg_2), arg_1, arg_2;
SELECT EXTRACT(DAY FROM toDate('2019-05-05') as arg_1), arg_1;
SELECT extract('1234' AS arg_1, '123' AS arg_2), arg_1, arg_2;
SELECT position(('123' AS arg_1) IN ('1234' AS arg_2)), arg_1, arg_2;
SELECT dateAdd(DAY, 1 AS arg_1, toDate('2019-05-05') AS arg_2), arg_1, arg_2;
SELECT dateSub(DAY, 1 AS arg_1, toDate('2019-05-05') AS arg_2), arg_1, arg_2;
SELECT dateDiff(DAY, toDate('2019-05-05') AS arg_1, toDate('2019-05-06') AS arg_2), arg_1, arg_2;
