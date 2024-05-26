SELECT 'toStartOfDay';
SELECT toStartOfDay(toDateTime(1412106600), 'Asia/Istanbul');
SELECT 'toMonday';
SELECT toMonday(toDateTime(1419800400), 'Asia/Istanbul');
SELECT 'toStartOfWeek (Sunday)';
SELECT toStartOfWeek(toDateTime(1419800400), 0, 'Asia/Istanbul');
SELECT 'toStartOfWeek (Monday)';
SELECT 'toLastDayOfWeek (Sunday)';
SELECT toLastDayOfWeek(toDateTime(1419800400), 0, 'Asia/Istanbul');
SELECT 'toLastDayOfWeek (Monday)';
SELECT 'toStartOfMonth';
SELECT toStartOfMonth(toDateTime(1419800400), 'Asia/Istanbul');
SELECT 'toStartOfQuarter';
SELECT toStartOfQuarter(toDateTime(1412106600), 'Asia/Istanbul');
SELECT 'toStartOfYear';
SELECT toStartOfYear(toDateTime(1419800400), 'Asia/Istanbul');
SELECT 'toTime';
SELECT toString(toTime(toDateTime(1420102800), 'Asia/Istanbul'), 'Asia/Istanbul'), toString(toTime(toDateTime(1428310800), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT 'toYear';
SELECT toYear(toDateTime(1412106600), 'Asia/Istanbul');
SELECT 'toMonth';
SELECT toMonth(toDateTime(1412106600), 'Asia/Istanbul');
SELECT 'toDayOfMonth';
SELECT toDayOfMonth(toDateTime(1412106600), 'Asia/Istanbul');
SELECT 'toDayOfWeek';
SELECT toDayOfWeek(toDateTime(1412106600), 0, 'Asia/Istanbul');
SELECT 'toHour';
SELECT toHour(toDateTime(1412106600), 'Asia/Istanbul');
SELECT 'toMinute';
SELECT toMinute(toDateTime(1412106600), 'Asia/Istanbul');
SELECT 'toSecond';
SELECT toSecond(toDateTime(1412106600), 'Asia/Istanbul');
SELECT 'toStartOfMinute';
SELECT 'toStartOfFiveMinutes';
SELECT 'toStartOfTenMinutes';
SELECT 'toStartOfFifteenMinutes';
SELECT 'toStartOfHour';
SELECT 'toStartOfInterval';
SELECT toStartOfInterval(toDateTime(1549483055), INTERVAL 1 year, 'Asia/Istanbul');
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
SELECT 'toString';
SELECT 'toUnixTimestamp';
SELECT toUnixTimestamp(toString(toDateTime(1426415400), 'Asia/Istanbul'), 'Asia/Istanbul');
SELECT 'date_trunc';
SELECT date_trunc('year', toDateTime('2020-01-01 04:11:22', 'Europe/London'), 'America/Vancouver');
