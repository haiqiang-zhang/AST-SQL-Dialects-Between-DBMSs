set sql_mode='traditional';
create table t1 (d date);
insert into t1 (d) select date_sub('2000-01-01', INTERVAL 2001 YEAR);
insert into t1 (d) select date_add('2000-01-01',interval 8000 year);
insert into t1 values (date_add(NULL, INTERVAL 1 DAY));
insert into t1 values (date_add('2000-01-04', INTERVAL NULL DAY));
set sql_mode='';
insert into t1 (d) select date_sub('2000-01-01', INTERVAL 2001 YEAR);
insert into t1 (d) select date_add('2000-01-01',interval 8000 year);
insert into t1 values (date_add(NULL, INTERVAL 1 DAY));
insert into t1 values (date_add('2000-01-04', INTERVAL NULL DAY));
select * from t1;
drop table t1;

--
-- Bug#21811
--
-- Make sure we end up with an appropriate
-- date format (DATE) after addition operation
--
SELECT CAST('2006-09-26' AS DATE) + INTERVAL 1 DAY;
SELECT CAST('2006-09-26' AS DATE) + INTERVAL 1 MONTH;
SELECT CAST('2006-09-26' AS DATE) + INTERVAL 1 YEAR;
SELECT CAST('2006-09-26' AS DATE) + INTERVAL 1 WEEK;

--
-- Bug#28450: The Item_date_add_interval in select list may fail the field 
--            type assertion.
--
create table t1 (a int, b varchar(10));
insert into t1 values (1, '2001-01-01'),(2, '2002-02-02');
select '2007-01-01' + interval a day from t1;
select b + interval a day from t1;
drop table t1;
SELECT ADDDATE('8112-06-20', REPEAT('1', 32));

-- Document resolver actions of various ADDDATE parameters

SELECT ADDDATE(DATE'2021-01-01', INTERVAL 1 DAY);
SELECT ADDDATE(DATE'2021-01-01', INTERVAL 1 HOUR);
SELECT ADDDATE(TIMESTAMP'2021-01-01 00:00:00', INTERVAL 1 DAY);
SELECT ADDDATE(TIMESTAMP'2021-01-01 00:00:00', INTERVAL 1 HOUR);
SELECT DATE(ts) = CURRENT_DATE + INTERVAL '1' DAY AS is_tomorrow, TIME(ts)
FROM (SELECT ADDDATE(TIME'00:00:00', INTERVAL 1 DAY) AS ts) AS dt;
SELECT ADDDATE(TIME'00:00:00', INTERVAL 1 HOUR);
SELECT ADDDATE('2021-01-01', INTERVAL 1 DAY);
SELECT ADDDATE('2021-01-01', INTERVAL 1 HOUR);
SELECT ADDDATE('2021-01-01 00:00:00', INTERVAL 1 DAY);
SELECT ADDDATE('2021-01-01 00:00:00', INTERVAL 1 HOUR);
SELECT ADDDATE('00:00:00', INTERVAL 1 DAY);
SELECT ADDDATE('00:00:00', INTERVAL 1 HOUR);

set @d='2021-01-01';
set @t='00:00:00';
set @ts='2021-01-01 00:00:00';

-- Document resolver actions of various ADDTIME parameters

SELECT ADDTIME(DATE'2021-01-01', '01:01:01');
SELECT ADDTIME(TIMESTAMP'2021-01-01 00:00:00', TIME'01:01:01');
SELECT ADDTIME(TIME'00:00:00', TIME'01:01:01');
SELECT ADDTIME('2021-01-01', '01:01:01');
SELECT ADDTIME('2021-01-01 00:00:00', TIME'01:01:01');
SELECT ADDTIME('00:00:00', TIME'01:01:01');
