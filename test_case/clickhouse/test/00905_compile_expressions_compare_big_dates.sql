SELECT toDate(d) AS dd FROM foo_c WHERE (dd >= '2019-02-06') AND (toDate(d) <= toDate('2019-08-09')) GROUP BY dd ORDER BY dd;
SELECT toDate(d) FROM foo_c WHERE (d > toDate('2019-02-10')) AND (d <= toDate('2022-01-01')) ORDER BY d;
DROP TABLE IF EXISTS foo_c;
