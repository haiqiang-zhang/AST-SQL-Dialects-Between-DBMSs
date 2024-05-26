SELECT uniqArray([1, 1, 2]),
       SUBSTRING('Hello, world', 7, 5),
       POW(1, 2), ROUND(TANh(1)), CrC32(''),
       SUM(number), MAX(number),
       flatten([[[BIT_AND(123)]], [[mod(3, 2)], [CAST('1' AS INTEGER)]]]),
       week(toDate('2000-12-05')),
       CAST(arrayJoin([NULL, NULL]) AS Nullable(TEXT)),
       avgOrDefaultIf(number, number % 2),
       sumOrNull(number),
       toTypeName(sumOrNull(number)),
       countIf(toDate('2000-12-05') + number as d,
       toDayOfYear(d) % 2)
FROM numbers(100);
SELECT '';
SYSTEM FLUSH LOGS;
SELECT '';
SELECT '';
SELECT '';
SELECT '';
SELECT '';
SELECT '';
DROP database IF EXISTS test_query_log_factories_info1;
CREATE database test_query_log_factories_info1 ENGINE=Atomic;
SYSTEM FLUSH LOGS;
SELECT '';
CREATE OR REPLACE TABLE test_query_log_factories_info1.memory_table (id BIGINT, date DATETIME) ENGINE=Memory();
SYSTEM FLUSH LOGS;
SELECT '';
DROP TABLE test_query_log_factories_info1.memory_table;
DROP DATABASE test_query_log_factories_info1;
