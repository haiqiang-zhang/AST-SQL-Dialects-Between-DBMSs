SELECT 'toStartOfDay';
SELECT toStartOfDay(toDateTime(1412106600), 'Asia/Istanbul');
SELECT toStartOfDay(toDateTime(1412106600), 'Europe/Paris');
SELECT toStartOfDay(toDateTime(1412106600), 'Europe/London');
SELECT toStartOfDay(toDateTime(1412106600), 'Asia/Tokyo');
SELECT toStartOfDay(toDateTime(1412106600), 'Pacific/Pitcairn');
SELECT toStartOfDay(toDate(16343), 'Asia/Istanbul');
SELECT toStartOfDay(toDate(16343), 'Europe/Paris');
SELECT toStartOfDay(toDate(16343), 'Europe/London');
SELECT toStartOfDay(toDate(16343), 'Asia/Tokyo');
SELECT toStartOfDay(toDate(16343), 'Pacific/Pitcairn');
SELECT 'toMonday';
SELECT toMonday(toDateTime(1419800400), 'Asia/Istanbul');
SELECT toMonday(toDateTime(1419800400), 'Europe/Paris');
SELECT toMonday(toDateTime(1419800400), 'Europe/London');
SELECT toMonday(toDateTime(1419800400), 'Asia/Tokyo');
SELECT toMonday(toDateTime(1419800400), 'Pacific/Pitcairn');
SELECT toMonday(toDate(16433));
SELECT 'toStartOfWeek (Sunday)';
SELECT toStartOfWeek(toDateTime(1419800400), 0, 'Asia/Istanbul');
SELECT toStartOfWeek(toDateTime(1419800400), 0, 'Europe/Paris');
SELECT toStartOfWeek(toDateTime(1419800400), 0, 'Europe/London');
SELECT toStartOfWeek(toDateTime(1419800400), 0, 'Asia/Tokyo');
SELECT toStartOfWeek(toDateTime(1419800400), 0, 'Pacific/Pitcairn');
SELECT toStartOfWeek(toDate(16433), 0);
SELECT 'toStartOfWeek (Monday)';
SELECT toStartOfWeek(toDateTime(1419800400), 1, 'Asia/Istanbul');
SELECT toStartOfWeek(toDateTime(1419800400), 1, 'Europe/Paris');
SELECT toStartOfWeek(toDateTime(1419800400), 1, 'Europe/London');
SELECT toStartOfWeek(toDateTime(1419800400), 1, 'Asia/Tokyo');
SELECT toStartOfWeek(toDateTime(1419800400), 1, 'Pacific/Pitcairn');
SELECT toStartOfWeek(toDate(16433), 1);
SELECT 'toLastDayOfWeek (Sunday)';
SELECT toLastDayOfWeek(toDateTime(1419800400), 0, 'Asia/Istanbul');
SELECT toLastDayOfWeek(toDateTime(1419800400), 0, 'Europe/Paris');
SELECT toLastDayOfWeek(toDateTime(1419800400), 0, 'Europe/London');
SELECT toLastDayOfWeek(toDateTime(1419800400), 0, 'Asia/Tokyo');
SELECT toLastDayOfWeek(toDateTime(1419800400), 0, 'Pacific/Pitcairn');
SELECT toLastDayOfWeek(toDate(16433), 0);
SELECT 'toLastDayOfWeek (Monday)';
SELECT toLastDayOfWeek(toDateTime(1419800400), 1, 'Asia/Istanbul');
SELECT toLastDayOfWeek(toDateTime(1419800400), 1, 'Europe/Paris');
SELECT toLastDayOfWeek(toDateTime(1419800400), 1, 'Europe/London');
SELECT toLastDayOfWeek(toDateTime(1419800400), 1, 'Asia/Tokyo');
SELECT toLastDayOfWeek(toDateTime(1419800400), 1, 'Pacific/Pitcairn');
SELECT toLastDayOfWeek(toDate(16433), 1);
SELECT 'toStartOfMonth';
SELECT toStartOfMonth(toDateTime(1419800400), 'Asia/Istanbul');
SELECT toStartOfMonth(toDateTime(1419800400), 'Europe/Paris');
SELECT toStartOfMonth(toDateTime(1419800400), 'Europe/London');
SELECT toStartOfMonth(toDateTime(1419800400), 'Asia/Tokyo');
SELECT toStartOfMonth(toDateTime(1419800400), 'Pacific/Pitcairn');
SELECT toStartOfMonth(toDate(16433));
SELECT 'toStartOfQuarter';
SELECT toStartOfQuarter(toDateTime(1412106600), 'Asia/Istanbul');
SELECT toStartOfQuarter(toDateTime(1412106600), 'Europe/Paris');
SELECT toStartOfQuarter(toDateTime(1412106600), 'Europe/London');
SELECT toStartOfQuarter(toDateTime(1412106600), 'Asia/Tokyo');
SELECT toStartOfQuarter(toDateTime(1412106600), 'Pacific/Pitcairn');
SELECT toStartOfQuarter(toDate(16343));
SELECT 'toStartOfYear';
SELECT toStartOfYear(toDateTime(1419800400), 'Asia/Istanbul');
SELECT toStartOfYear(toDateTime(1419800400), 'Europe/Paris');
SELECT toStartOfYear(toDateTime(1419800400), 'Europe/London');
SELECT toStartOfYear(toDateTime(1419800400), 'Asia/Tokyo');
SELECT toStartOfYear(toDateTime(1419800400), 'Pacific/Pitcairn');
SELECT toStartOfYear(toDate(16433));
SELECT 'toTime';
SELECT toString(toTime(toDateTime(1420102800), 'Asia/Istanbul'), 'Asia/Istanbul'), toString(toTime(toDateTime(1428310800), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toTime(toDateTime(1420102800), 'Europe/Paris'), 'Europe/Paris'), toString(toTime(toDateTime(1428310800), 'Europe/Paris'), 'Europe/Paris');
SELECT toString(toTime(toDateTime(1420102800), 'Europe/London'), 'Europe/London'), toString(toTime(toDateTime(1428310800), 'Europe/London'), 'Europe/London');
SELECT toString(toTime(toDateTime(1420102800), 'Asia/Tokyo'), 'Asia/Tokyo'), toString(toTime(toDateTime(1428310800), 'Asia/Tokyo'), 'Asia/Tokyo');
SELECT toString(toTime(toDateTime(1420102800), 'Pacific/Pitcairn'), 'Pacific/Pitcairn'), toString(toTime(toDateTime(1428310800), 'Pacific/Pitcairn'), 'Pacific/Pitcairn');
SELECT 'toYear';
SELECT toYear(toDateTime(1412106600), 'Asia/Istanbul');
SELECT toYear(toDateTime(1412106600), 'Europe/Paris');
SELECT toYear(toDateTime(1412106600), 'Europe/London');
SELECT toYear(toDateTime(1412106600), 'Asia/Tokyo');
SELECT toYear(toDateTime(1412106600), 'Pacific/Pitcairn');
SELECT 'toMonth';
SELECT toMonth(toDateTime(1412106600), 'Asia/Istanbul');
SELECT toMonth(toDateTime(1412106600), 'Europe/Paris');
SELECT toMonth(toDateTime(1412106600), 'Europe/London');
SELECT toMonth(toDateTime(1412106600), 'Asia/Tokyo');
SELECT toMonth(toDateTime(1412106600), 'Pacific/Pitcairn');
SELECT 'toDayOfMonth';
SELECT toDayOfMonth(toDateTime(1412106600), 'Asia/Istanbul');
SELECT toDayOfMonth(toDateTime(1412106600), 'Europe/Paris');
SELECT toDayOfMonth(toDateTime(1412106600), 'Europe/London');
SELECT toDayOfMonth(toDateTime(1412106600), 'Asia/Tokyo');
SELECT toDayOfMonth(toDateTime(1412106600), 'Pacific/Pitcairn');
SELECT 'toDayOfWeek';
SELECT toDayOfWeek(toDateTime(1412106600), 0, 'Asia/Istanbul');
SELECT toDayOfWeek(toDateTime(1412106600), 0, 'Europe/Paris');
SELECT toDayOfWeek(toDateTime(1412106600), 0, 'Europe/London');
SELECT toDayOfWeek(toDateTime(1412106600), 0, 'Asia/Tokyo');
SELECT toDayOfWeek(toDateTime(1412106600), 0, 'Pacific/Pitcairn');
SELECT 'toHour';
SELECT toHour(toDateTime(1412106600), 'Asia/Istanbul');
SELECT toHour(toDateTime(1412106600), 'Europe/Paris');
SELECT toHour(toDateTime(1412106600), 'Europe/London');
SELECT toHour(toDateTime(1412106600), 'Asia/Tokyo');
SELECT toHour(toDateTime(1412106600), 'Pacific/Pitcairn');
SELECT 'toMinute';
SELECT toMinute(toDateTime(1412106600), 'Asia/Istanbul');
SELECT toMinute(toDateTime(1412106600), 'Europe/Paris');
SELECT toMinute(toDateTime(1412106600), 'Europe/London');
SELECT toMinute(toDateTime(1412106600), 'Asia/Tokyo');
SELECT toMinute(toDateTime(1412106600), 'Pacific/Pitcairn');
SELECT 'toSecond';
SELECT toSecond(toDateTime(1412106600), 'Asia/Istanbul');
SELECT toSecond(toDateTime(1412106600), 'Europe/Paris');
SELECT toSecond(toDateTime(1412106600), 'Europe/London');
SELECT toSecond(toDateTime(1412106600), 'Asia/Tokyo');
SELECT toSecond(toDateTime(1412106600), 'Pacific/Pitcairn');
SELECT 'toStartOfMinute';
SELECT toString(toStartOfMinute(toDateTime(1549483055), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfMinute(toDateTime(1549483055), 'Europe/Paris'), 'Europe/Paris');
SELECT toString(toStartOfMinute(toDateTime(1549483055), 'Europe/London'), 'Europe/London');
SELECT toString(toStartOfMinute(toDateTime(1549483055), 'Asia/Tokyo'), 'Asia/Tokyo');
SELECT toString(toStartOfMinute(toDateTime(1549483055), 'Pacific/Pitcairn'), 'Pacific/Pitcairn');
SELECT 'toStartOfFiveMinutes';
SELECT toString(toStartOfFiveMinutes(toDateTime(1549483055), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfFiveMinutes(toDateTime(1549483055), 'Europe/Paris'), 'Europe/Paris');
SELECT toString(toStartOfFiveMinutes(toDateTime(1549483055), 'Europe/London'), 'Europe/London');
SELECT toString(toStartOfFiveMinutes(toDateTime(1549483055), 'Asia/Tokyo'), 'Asia/Tokyo');
SELECT toString(toStartOfFiveMinutes(toDateTime(1549483055), 'Pacific/Pitcairn'), 'Pacific/Pitcairn');
SELECT 'toStartOfTenMinutes';
SELECT toString(toStartOfTenMinutes(toDateTime(1549483055), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfTenMinutes(toDateTime(1549483055), 'Europe/Paris'), 'Europe/Paris');
SELECT toString(toStartOfTenMinutes(toDateTime(1549483055), 'Europe/London'), 'Europe/London');
SELECT toString(toStartOfTenMinutes(toDateTime(1549483055), 'Asia/Tokyo'), 'Asia/Tokyo');
SELECT toString(toStartOfTenMinutes(toDateTime(1549483055), 'Pacific/Pitcairn'), 'Pacific/Pitcairn');
SELECT 'toStartOfFifteenMinutes';
SELECT toString(toStartOfFifteenMinutes(toDateTime(1549483055), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfFifteenMinutes(toDateTime(1549483055), 'Europe/Paris'), 'Europe/Paris');
SELECT toString(toStartOfFifteenMinutes(toDateTime(1549483055), 'Europe/London'), 'Europe/London');
SELECT toString(toStartOfFifteenMinutes(toDateTime(1549483055), 'Asia/Tokyo'), 'Asia/Tokyo');
SELECT toString(toStartOfFifteenMinutes(toDateTime(1549483055), 'Pacific/Pitcairn'), 'Pacific/Pitcairn');
SELECT 'toStartOfHour';
SELECT toString(toStartOfHour(toDateTime(1549483055), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfHour(toDateTime(1549483055), 'Europe/Paris'), 'Europe/Paris');
SELECT toString(toStartOfHour(toDateTime(1549483055), 'Europe/London'), 'Europe/London');
SELECT toString(toStartOfHour(toDateTime(1549483055), 'Asia/Tokyo'), 'Asia/Tokyo');
SELECT toString(toStartOfHour(toDateTime(1549483055), 'Pacific/Pitcairn'), 'Pacific/Pitcairn');
SELECT 'toStartOfInterval';
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 1 year, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 2 year, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 5 year, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 1 quarter, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 2 quarter, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 3 quarter, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 1 month, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 2 month, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 5 month, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 1 week, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 2 week, 'Asia/Istanbul');
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 6 week, 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 1 day, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 2 day, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 5 day, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 1 hour, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 2 hour, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 6 hour, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 24 hour, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 1 minute, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 2 minute, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 5 minute, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 20 minute, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 90 minute, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 1 second, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 2 second, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDateTime(1549483055), INTERVAL 5 second, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toStartOfInterval(toDate(17933), INTERVAL 1 year);
SELECT toStartOfInterval(toDate(17933), INTERVAL 2 year);
SELECT toStartOfInterval(toDate(17933), INTERVAL 5 year);
SELECT toStartOfInterval(toDate(17933), INTERVAL 1 quarter);
SELECT toStartOfInterval(toDate(17933), INTERVAL 2 quarter);
SELECT toStartOfInterval(toDate(17933), INTERVAL 3 quarter);
SELECT toStartOfInterval(toDate(17933), INTERVAL 1 month);
SELECT toStartOfInterval(toDate(17933), INTERVAL 2 month);
SELECT toStartOfInterval(toDate(17933), INTERVAL 5 month);
SELECT toStartOfInterval(toDate(17933), INTERVAL 1 week);
SELECT toStartOfInterval(toDate(17933), INTERVAL 2 week);
SELECT toStartOfInterval(toDate(17933), INTERVAL 6 week);
SELECT toString(toStartOfInterval(toDate(17933), INTERVAL 1 day, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDate(17933), INTERVAL 2 day, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toString(toStartOfInterval(toDate(17933), INTERVAL 5 day, 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT 'toRelativeYearNum';
SELECT toRelativeYearNum(toDateTime(1412106600), 'Asia/Istanbul') - toRelativeYearNum(toDateTime(0), 'Asia/Istanbul');
SELECT toRelativeYearNum(toDateTime(1412106600), 'Europe/Paris') - toRelativeYearNum(toDateTime(0), 'Europe/Paris');
SELECT toRelativeYearNum(toDateTime(1412106600), 'Europe/London') - toRelativeYearNum(toDateTime(0), 'Europe/London');
SELECT toRelativeYearNum(toDateTime(1412106600), 'Asia/Tokyo') - toRelativeYearNum(toDateTime(0), 'Asia/Tokyo');
SELECT toRelativeYearNum(toDateTime(1412106600), 'Pacific/Pitcairn') - toRelativeYearNum(toDateTime(0), 'Pacific/Pitcairn');
SELECT 'toRelativeMonthNum';
SELECT toRelativeMonthNum(toDateTime(1412106600), 'Asia/Istanbul') - toRelativeMonthNum(toDateTime(0), 'Asia/Istanbul');
SELECT toRelativeMonthNum(toDateTime(1412106600), 'Europe/Paris') - toRelativeMonthNum(toDateTime(0), 'Europe/Paris');
SELECT toRelativeMonthNum(toDateTime(1412106600), 'Europe/London') - toRelativeMonthNum(toDateTime(0), 'Europe/London');
SELECT toRelativeMonthNum(toDateTime(1412106600), 'Asia/Tokyo') - toRelativeMonthNum(toDateTime(0), 'Asia/Tokyo');
SELECT toRelativeMonthNum(toDateTime(1412106600), 'Pacific/Pitcairn') - toRelativeMonthNum(toDateTime(0), 'Pacific/Pitcairn');
SELECT 'toRelativeWeekNum';
SELECT toRelativeWeekNum(toDateTime(1412106600), 'Asia/Istanbul') - toRelativeWeekNum(toDateTime(0), 'Asia/Istanbul');
SELECT toRelativeWeekNum(toDateTime(1412106600), 'Europe/Paris') - toRelativeWeekNum(toDateTime(0), 'Europe/Paris');
SELECT toRelativeWeekNum(toDateTime(1412106600), 'Europe/London') - toRelativeWeekNum(toDateTime(0), 'Europe/London');
SELECT toRelativeWeekNum(toDateTime(1412106600), 'Asia/Tokyo') - toRelativeWeekNum(toDateTime(0), 'Asia/Tokyo');
SELECT toRelativeWeekNum(toDateTime(1412106600), 'Pacific/Pitcairn') - toRelativeWeekNum(toDateTime(0), 'Pacific/Pitcairn');
SELECT 'toRelativeDayNum';
SELECT toRelativeDayNum(toDateTime(1412106600), 'Asia/Istanbul') - toRelativeDayNum(toDateTime(0), 'Asia/Istanbul');
SELECT toRelativeDayNum(toDateTime(1412106600), 'Europe/Paris') - toRelativeDayNum(toDateTime(0), 'Europe/Paris');
SELECT toRelativeDayNum(toDateTime(1412106600), 'Europe/London') - toRelativeDayNum(toDateTime(0), 'Europe/London');
SELECT toRelativeDayNum(toDateTime(1412106600), 'Asia/Tokyo') - toRelativeDayNum(toDateTime(0), 'Asia/Tokyo');
SELECT toUInt16(toRelativeDayNum(toDateTime(1412106600), 'Pacific/Pitcairn') - toRelativeDayNum(toDateTime(0), 'Pacific/Pitcairn'));
SELECT 'toRelativeHourNum';
SELECT toRelativeHourNum(toDateTime(1412106600), 'Asia/Istanbul') - toRelativeHourNum(toDateTime(0), 'Asia/Istanbul');
SELECT toRelativeHourNum(toDateTime(1412106600), 'Europe/Paris') - toRelativeHourNum(toDateTime(0), 'Europe/Paris');
SELECT toRelativeHourNum(toDateTime(1412106600), 'Europe/London') - toRelativeHourNum(toDateTime(0), 'Europe/London');
SELECT toRelativeHourNum(toDateTime(1412106600), 'Asia/Tokyo') - toRelativeHourNum(toDateTime(0), 'Asia/Tokyo');
SELECT toRelativeHourNum(toDateTime(1412106600), 'Pacific/Pitcairn') - toRelativeHourNum(toDateTime(0), 'Pacific/Pitcairn');
SELECT 'toRelativeMinuteNum';
SELECT toRelativeMinuteNum(toDateTime(1412106600), 'Asia/Istanbul') - toRelativeMinuteNum(toDateTime(0), 'Asia/Istanbul');
SELECT toRelativeMinuteNum(toDateTime(1412106600), 'Europe/Paris') - toRelativeMinuteNum(toDateTime(0), 'Europe/Paris');
SELECT toRelativeMinuteNum(toDateTime(1412106600), 'Europe/London') - toRelativeMinuteNum(toDateTime(0), 'Europe/London');
SELECT toRelativeMinuteNum(toDateTime(1412106600), 'Asia/Tokyo') - toRelativeMinuteNum(toDateTime(0), 'Asia/Tokyo');
SELECT toRelativeMinuteNum(toDateTime(1412106600), 'Pacific/Pitcairn') - toRelativeMinuteNum(toDateTime(0), 'Pacific/Pitcairn');
SELECT 'toRelativeSecondNum';
SELECT toRelativeSecondNum(toDateTime(1412106600), 'Asia/Istanbul') - toRelativeSecondNum(toDateTime(0), 'Asia/Istanbul');
SELECT toRelativeSecondNum(toDateTime(1412106600), 'Europe/Paris') - toRelativeSecondNum(toDateTime(0), 'Europe/Paris');
SELECT toRelativeSecondNum(toDateTime(1412106600), 'Europe/London') - toRelativeSecondNum(toDateTime(0), 'Europe/London');
SELECT toRelativeSecondNum(toDateTime(1412106600), 'Asia/Tokyo') - toRelativeSecondNum(toDateTime(0), 'Asia/Tokyo');
SELECT toRelativeSecondNum(toDateTime(1412106600), 'Pacific/Pitcairn') - toRelativeSecondNum(toDateTime(0), 'Pacific/Pitcairn');
SELECT 'toDate';
SELECT toDate(toDateTime(1412106600), 'Asia/Istanbul');
SELECT toDate(toDateTime(1412106600), 'Europe/Paris');
SELECT toDate(toDateTime(1412106600), 'Europe/London');
SELECT toDate(toDateTime(1412106600), 'Asia/Tokyo');
SELECT toDate(toDateTime(1412106600), 'Pacific/Pitcairn');
SELECT toDate(1412106600, 'Asia/Istanbul');
SELECT toDate(1412106600, 'Europe/Paris');
SELECT toDate(1412106600, 'Europe/London');
SELECT toDate(1412106600, 'Asia/Tokyo');
SELECT toDate(1412106600, 'Pacific/Pitcairn');
SELECT toDate(16343);
SELECT 'toString';
SELECT toString(toDateTime(1436956200), 'Asia/Istanbul');
SELECT toString(toDateTime(1436956200), 'Europe/Paris');
SELECT toString(toDateTime(1436956200), 'Europe/London');
SELECT toString(toDateTime(1436956200), 'Asia/Tokyo');
SELECT toString(toDateTime(1436956200), 'Pacific/Pitcairn');
SELECT 'toUnixTimestamp';
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Asia/Istanbul'), 'Europe/Paris');
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Asia/Istanbul'), 'Europe/London');
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Asia/Istanbul'), 'Asia/Tokyo');
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Asia/Istanbul'), 'Pacific/Pitcairn');
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Europe/Paris'), 'Europe/Paris');
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Europe/London'), 'Europe/London');
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Asia/Tokyo'), 'Asia/Tokyo');
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Pacific/Pitcairn'), 'Pacific/Pitcairn');
SELECT 'date_trunc';
SELECT date_trunc('year', toDateTime('2020-01-01 04:11:22', 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('year', toDateTime('2020-01-01 12:11:22', 'Europe/London'), 'Europe/London');
SELECT date_trunc('year', toDateTime('2020-01-01 20:11:22', 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('quarter', toDateTime('2020-01-01 04:11:22', 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('quarter', toDateTime('2020-01-01 12:11:22', 'Europe/London'), 'Europe/London');
SELECT date_trunc('quarter', toDateTime('2020-01-01 20:11:22', 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('month', toDateTime('2020-01-01 04:11:22', 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('month', toDateTime('2020-01-01 12:11:22', 'Europe/London'), 'Europe/London');
SELECT date_trunc('month', toDateTime('2020-01-01 20:11:22', 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('week', toDateTime('2020-01-01 04:11:22', 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('week', toDateTime('2020-01-01 12:11:22', 'Europe/London'), 'Europe/London');
SELECT date_trunc('week', toDateTime('2020-01-01 20:11:22', 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('day', toDateTime('2020-01-01 04:11:22', 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('day', toDateTime('2020-01-01 12:11:22', 'Europe/London'), 'Europe/London');
SELECT date_trunc('day', toDateTime('2020-01-01 20:11:22', 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('hour', toDateTime('2020-01-01 04:11:22', 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('hour', toDateTime('2020-01-01 12:11:22', 'Europe/London'), 'Europe/London');
SELECT date_trunc('hour', toDateTime('2020-01-01 20:11:22', 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('minute', toDateTime('2020-01-01 04:11:22', 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('minute', toDateTime('2020-01-01 12:11:22', 'Europe/London'), 'Europe/London');
SELECT date_trunc('minute', toDateTime('2020-01-01 20:11:22', 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('second', toDateTime('2020-01-01 04:11:22', 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('second', toDateTime('2020-01-01 12:11:22', 'Europe/London'), 'Europe/London');
SELECT date_trunc('second', toDateTime('2020-01-01 20:11:22', 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('year', toDateTime64('2020-01-01 04:11:22.123', 3, 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('year', toDateTime64('2020-01-01 12:11:22.123', 3, 'Europe/London'), 'Europe/London');
SELECT date_trunc('year', toDateTime64('2020-01-01 20:11:22.123', 3, 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('quarter', toDateTime64('2020-01-01 04:11:22.123', 3, 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('quarter', toDateTime64('2020-01-01 12:11:22.123', 3, 'Europe/London'), 'Europe/London');
SELECT date_trunc('quarter', toDateTime64('2020-01-01 20:11:22.123', 3, 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('month', toDateTime64('2020-01-01 04:11:22.123', 3, 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('month', toDateTime64('2020-01-01 12:11:22.123', 3, 'Europe/London'), 'Europe/London');
SELECT date_trunc('month', toDateTime64('2020-01-01 20:11:22.123', 3, 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('week', toDateTime64('2020-01-01 04:11:22.123', 3, 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('week', toDateTime64('2020-01-01 12:11:22.123', 3, 'Europe/London'), 'Europe/London');
SELECT date_trunc('week', toDateTime64('2020-01-01 20:11:22.123', 3, 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('day', toDateTime64('2020-01-01 04:11:22.123', 3, 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('day', toDateTime64('2020-01-01 12:11:22.123', 3, 'Europe/London'), 'Europe/London');
SELECT date_trunc('day', toDateTime64('2020-01-01 20:11:22.123', 3, 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('hour', toDateTime64('2020-01-01 04:11:22.123', 3, 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('hour', toDateTime64('2020-01-01 12:11:22.123', 3, 'Europe/London'), 'Europe/London');
SELECT date_trunc('hour', toDateTime64('2020-01-01 20:11:22.123', 3, 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('minute', toDateTime64('2020-01-01 04:11:22.123', 3, 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('minute', toDateTime64('2020-01-01 12:11:22.123', 3, 'Europe/London'), 'Europe/London');
SELECT date_trunc('minute', toDateTime64('2020-01-01 20:11:22.123', 3, 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('second', toDateTime64('2020-01-01 04:11:22.123', 3, 'Europe/London'), 'America/Vancouver');
SELECT date_trunc('second', toDateTime64('2020-01-01 12:11:22.123', 3, 'Europe/London'), 'Europe/London');
SELECT date_trunc('second', toDateTime64('2020-01-01 20:11:22.123', 3, 'Europe/London'), 'Asia/Tokyo');
SELECT date_trunc('year', toDate('2020-01-01', 'Europe/London'));
SELECT date_trunc('quarter', toDate('2020-01-01', 'Europe/London'));
SELECT date_trunc('month', toDate('2020-01-01', 'Europe/London'));
SELECT date_trunc('week', toDate('2020-01-01', 'Europe/London'));
SELECT date_trunc('day', toDate('2020-01-01', 'Europe/London'), 'America/Vancouver');