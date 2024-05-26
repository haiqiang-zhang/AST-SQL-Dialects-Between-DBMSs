DROP TABLE IF EXISTS spark_bar_test;
CREATE TABLE spark_bar_test (`cnt` UInt64,`event_date` Date) ENGINE = MergeTree ORDER BY event_date SETTINGS index_granularity = 8192;
INSERT INTO spark_bar_test VALUES(1,'2020-01-01'),(4,'2020-01-02'),(5,'2020-01-03'),(2,'2020-01-04'),(3,'2020-01-05'),(7,'2020-01-06'),(6,'2020-01-07'),(8,'2020-01-08'),(2,'2020-01-11');
SELECT sparkbar(2)(event_date,cnt) FROM spark_bar_test;
WITH number DIV 50 AS k, toUInt32(number % 50) AS value SELECT k, sparkbar(50, 0, 99)(number, value) FROM numbers(100) GROUP BY k ORDER BY k;
SELECT sparkbar(128, 0, 9223372036854775806)(toUInt64(9223372036854775806), number % 65535) FROM numbers(100);
DROP TABLE IF EXISTS spark_bar_test;
