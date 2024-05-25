-- Tests are in order of the type appearance in the docs

SET allow_experimental_object_type = 1;
SELECT '-- Uppercase tests';
SELECT 'Binary(N)' AS mysql_type, CAST('foo' AS BINARY(3)) AS result, toTypeName(result) AS native_type;
SELECT 'Char' AS mysql_type, CAST(44 AS CHAR) AS result, toTypeName(result) AS native_type;
SELECT 'Date' AS mysql_type, CAST('2021-02-03' AS DATE) AS result, toTypeName(result) AS native_type;
SELECT 'DateTime' AS mysql_type, CAST('2021-02-03 12:01:02' AS DATETIME) AS result, toTypeName(result) AS native_type;
SELECT 'Decimal' AS mysql_type, CAST(45.1 AS DECIMAL) AS result, toTypeName(result) AS native_type;
SELECT 'Decimal(M)' AS mysql_type, CAST(46.2 AS DECIMAL(4)) AS result, toTypeName(result) AS native_type;
SELECT 'Decimal(M, D)' AS mysql_type, CAST(47.21 AS DECIMAL(4, 2)) AS result, toTypeName(result) AS native_type;
SELECT 'Double' AS mysql_type, CAST(48.11 AS DOUBLE) AS result, toTypeName(result) AS native_type;
SELECT 'Real' AS mysql_type, CAST(49.22 AS REAL) AS result, toTypeName(result) AS native_type;
SELECT 'Signed' AS mysql_type, CAST(50 AS SIGNED) AS result, toTypeName(result) AS native_type;
SELECT 'Unsigned' AS mysql_type, CAST(52 AS UNSIGNED) AS result, toTypeName(result) AS native_type;
SELECT 'Year' AS mysql_type, CAST(2007 AS YEAR) AS result, toTypeName(result) AS native_type;
SELECT '-- Lowercase tests';
select 'Binary(N)' as mysql_type, cast('foo' as binary(3)) as result, toTypeName(result) as native_type;
select 'Char' as mysql_type, cast(44 as char) as result, toTypeName(result) as native_type;
select 'Date' as mysql_type, cast('2021-02-03' as date) as result, toTypeName(result) as native_type;
select 'DateTime' as mysql_type, cast('2021-02-03 12:01:02' as datetime) as result, toTypeName(result) as native_type;
select 'Decimal' as mysql_type, cast(45.1 as decimal) as result, toTypeName(result) as native_type;
select 'Decimal(M)' as mysql_type, cast(46.2 as decimal(4)) as result, toTypeName(result) as native_type;
select 'Decimal(M, D)' as mysql_type, cast(47.21 as decimal(4, 2)) as result, toTypeName(result) as native_type;
select 'Double' as mysql_type, cast(48.11 as double) as result, toTypeName(result) as native_type;
select 'Real' as mysql_type, cast(49.22 as real) as result, toTypeName(result) as native_type;
select 'Signed' as mysql_type, cast(50 as signed) as result, toTypeName(result) as native_type;
select 'Unsigned' as mysql_type, cast(52 as unsigned) as result, toTypeName(result) as native_type;
select 'Year' as mysql_type, cast(2007 as year) as result, toTypeName(result) as native_type;
