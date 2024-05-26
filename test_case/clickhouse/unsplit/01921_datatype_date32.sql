drop table if exists t1;
create table t1(x1 Date32) engine Memory;
insert into t1 values ('1900-01-01'),('1899-01-01'),('2299-12-15'),('2300-12-31'),('2021-06-22');
select '-------toYear---------';
select toYear(x1) from t1;
select '-------toMonth---------';
select toMonth(x1) from t1;
select '-------toQuarter---------';
select toQuarter(x1) from t1;
select '-------toDayOfMonth---------';
select toDayOfMonth(x1) from t1;
select '-------toDayOfWeek---------';
select toDayOfWeek(x1) from t1;
select '-------toDayOfYear---------';
select toDayOfYear(x1) from t1;
select '-------toHour---------';
select '-------toMinute---------';
select '-------toSecond---------';
select '-------toStartOfDay---------';
select toStartOfDay(x1, 'Asia/Istanbul') from t1;
select '-------toMonday---------';
select toMonday(x1) from t1;
select '-------toISOWeek---------';
select toISOWeek(x1) from t1;
select '-------toISOYear---------';
select toISOYear(x1) from t1;
select '-------toWeek---------';
select toWeek(x1) from t1;
select '-------toYearWeek---------';
select toYearWeek(x1) from t1;
select '-------toStartOfWeek---------';
select toStartOfWeek(x1) from t1;
select '-------toLastDayOfWeek---------';
select toLastDayOfWeek(x1) from t1;
select '-------toStartOfMonth---------';
select toStartOfMonth(x1) from t1;
select '-------toStartOfQuarter---------';
select toStartOfQuarter(x1) from t1;
select '-------toStartOfYear---------';
select toStartOfYear(x1) from t1;
select '-------toStartOfSecond---------';
select '-------toStartOfMinute---------';
select '-------toStartOfFiveMinutes---------';
select '-------toStartOfTenMinutes---------';
select '-------toStartOfFifteenMinutes---------';
select '-------toStartOfHour---------';
select '-------toStartOfISOYear---------';
select toStartOfISOYear(x1) from t1;
select '-------toRelativeYearNum---------';
select toRelativeYearNum(x1, 'Asia/Istanbul') from t1;
select '-------toRelativeQuarterNum---------';
select toRelativeQuarterNum(x1, 'Asia/Istanbul') from t1;
select '-------toRelativeMonthNum---------';
select toRelativeMonthNum(x1, 'Asia/Istanbul') from t1;
select '-------toRelativeWeekNum---------';
select toRelativeWeekNum(x1, 'Asia/Istanbul') from t1;
select '-------toRelativeDayNum---------';
select toRelativeDayNum(x1, 'Asia/Istanbul') from t1;
select '-------toRelativeHourNum---------';
select toRelativeHourNum(x1, 'Asia/Istanbul') from t1;
select '-------toRelativeMinuteNum---------';
select toRelativeMinuteNum(x1, 'Asia/Istanbul') from t1;
select '-------toRelativeSecondNum---------';
select toRelativeSecondNum(x1, 'Asia/Istanbul') from t1;
select '-------toTime---------';
select '-------toYYYYMM---------';
select toYYYYMM(x1) from t1;
select '-------toYYYYMMDD---------';
select toYYYYMMDD(x1) from t1;
select '-------toYYYYMMDDhhmmss---------';
select toYYYYMMDDhhmmss(x1) from t1;
select '-------addSeconds---------';
select addSeconds(x1, 3600) from t1;
select '-------addMinutes---------';
select addMinutes(x1, 60) from t1;
select '-------addHours---------';
select addHours(x1, 1) from t1;
select '-------addDays---------';
select '-------addWeeks---------';
select '-------addMonths---------';
select '-------addQuarters---------';
select '-------addYears---------';
select '-------subtractSeconds---------';
select subtractSeconds(x1, 3600) from t1;
select '-------subtractMinutes---------';
select subtractMinutes(x1, 60) from t1;
select '-------subtractHours---------';
select subtractHours(x1, 1) from t1;
select '-------subtractDays---------';
select '-------subtractWeeks---------';
select '-------subtractMonths---------';
select '-------subtractQuarters---------';
select '-------subtractYears---------';
select '-------toDate32---------';
select toDate32('1900-01-01'), toDate32(toDate('2000-01-01'));
select toDate32OrZero('1899-01-01'), toDate32OrNull('1899-01-01');
select (select toDate32OrZero(''));
select (select toDate32OrNull(''));
SELECT toString(T.d) dateStr
FROM
    (
    SELECT '1900-01-01'::Date32 d
    UNION ALL SELECT '1969-12-31'::Date32
    UNION ALL SELECT '1970-01-01'::Date32
    UNION ALL SELECT '2149-06-06'::Date32
    UNION ALL SELECT '2149-06-07'::Date32
    UNION ALL SELECT '2299-12-31'::Date32
    ) AS T
ORDER BY T.d;
