SELECT toDate('1970-01-01') + number AS d, toISOWeek(d), toISOYear(d) FROM numbers(15);
SELECT toDateTime(toDate('1970-01-02') + number, 'Asia/Istanbul') AS t, toISOWeek(t), toISOYear(t) FROM numbers(15);
