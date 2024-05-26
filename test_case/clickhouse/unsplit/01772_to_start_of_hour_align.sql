SELECT toStartOfInterval(toDateTime('2021-03-23 03:58:00'), INTERVAL 11 HOUR);
SELECT toStartOfHour(toDateTime('2021-03-23 13:58:00', 'Asia/Kolkata'));
SELECT toDateTime('2010-03-28 00:00:00', 'Europe/Moscow') + INTERVAL 15 * number MINUTE AS src, toStartOfInterval(src, INTERVAL 2 HOUR) AS rounded, toUnixTimestamp(src) AS t FROM numbers(20);
