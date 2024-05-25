SELECT toStartOfInterval(toDateTime('2021-03-23 03:58:00'), INTERVAL 11 HOUR);
SELECT toStartOfInterval(toDateTime('2021-03-23 13:58:00'), INTERVAL 11 HOUR);
SELECT toStartOfInterval(toDateTime('2021-03-23 23:58:00'), INTERVAL 11 HOUR);
SELECT toStartOfHour(toDateTime('2021-03-23 13:58:00', 'Asia/Kolkata'));
SELECT toStartOfInterval(toDateTime('2021-03-23 13:58:00', 'Asia/Kolkata'), INTERVAL 6 HOUR);
SELECT toStartOfInterval(toDateTime('2021-03-23 13:58:00', 'Asia/Kolkata'), INTERVAL 66 HOUR);

SELECT toDateTime('2010-03-28 00:00:00', 'Europe/Moscow') + INTERVAL 15 * number MINUTE AS src, toStartOfInterval(src, INTERVAL 2 HOUR) AS rounded, toUnixTimestamp(src) AS t FROM numbers(20);
SELECT toDateTime('2010-10-31 00:00:00', 'Europe/Moscow') + INTERVAL 15 * number MINUTE AS src, toStartOfInterval(src, INTERVAL 2 HOUR) AS rounded, toUnixTimestamp(src) AS t FROM numbers(20);
SELECT toDateTime('2020-04-05 00:00:00', 'Australia/Lord_Howe') + INTERVAL 15 * number MINUTE AS src, toStartOfInterval(src, INTERVAL 2 HOUR) AS rounded, toUnixTimestamp(src) AS t FROM numbers(20);
SELECT toDateTime('2020-10-04 00:00:00', 'Australia/Lord_Howe') + INTERVAL 15 * number MINUTE AS src, toStartOfInterval(src, INTERVAL 2 HOUR) AS rounded, toUnixTimestamp(src) AS t FROM numbers(20);
