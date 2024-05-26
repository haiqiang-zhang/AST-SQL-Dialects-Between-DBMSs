SELECT sparkbar(2)(event_date,cnt) FROM spark_bar_test;
WITH number DIV 50 AS k, toUInt32(number % 50) AS value SELECT k, sparkbar(50, 0, 99)(number, value) FROM numbers(100) GROUP BY k ORDER BY k;
SELECT sparkbar(128, 0, 9223372036854775806)(toUInt64(9223372036854775806), number % 65535) FROM numbers(100);
DROP TABLE IF EXISTS spark_bar_test;
