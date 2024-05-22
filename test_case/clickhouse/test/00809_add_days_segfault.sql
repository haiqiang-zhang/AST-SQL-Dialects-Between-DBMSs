SELECT ignore(addDays(toDateTime(0), -1));
SELECT ignore(subtractDays(toDateTime(0), 1));
SELECT ignore(addDays(toDate(0), -1));
SELECT ignore(subtractDays(toDate(0), 1));
SET send_logs_level = 'fatal';
SELECT ignore(addDays((CAST((96.338) AS DateTime)), -3));
SELECT ignore(subtractDays((CAST((-5263074.47) AS DateTime)), -737895));
