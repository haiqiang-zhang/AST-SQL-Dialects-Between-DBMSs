SELECT color, toDateTime(timestamp) AS second
FROM order_test1
GROUP BY color, second
ORDER BY color ASC, second DESC;
select '';
select '';
SELECT  color, timestamp
FROM order_test1
GROUP BY color, timestamp
ORDER BY color ASC, timestamp DESC;
select '';
select '------cast to String----';
select '';
SELECT cast(color,'String') color, toDateTime(timestamp) AS second
FROM order_test1
GROUP BY color, second
ORDER BY color ASC, second DESC;
select '';
select '';
SELECT cast(color,'String') color, timestamp
FROM order_test1
GROUP BY color, timestamp
ORDER BY color ASC, timestamp DESC;
DROP TABLE order_test1;
