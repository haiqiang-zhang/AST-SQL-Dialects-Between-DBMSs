SELECT count()
FROM foo ANY INNER JOIN bar USING (dimension_1)
WHERE (foo.server_date <= '2020-11-07') AND (toDate(foo.server_time, 'Asia/Yekaterinburg') <= '2020-11-07');
SELECT toDateTime(foo.server_time, 'UTC')
FROM foo
ANY INNER JOIN bar USING (dimension_1)
WHERE toDate(foo.server_time, 'UTC') <= toDate('2020-04-30');
SET any_join_distinct_right_table_keys = 1;
DROP TABLE foo;
DROP TABLE bar;
