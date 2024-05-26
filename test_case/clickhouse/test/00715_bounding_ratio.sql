select 1.0 = boundingRatio(timestamp, event) from rate_test;
drop table if exists rate_test2;
create table rate_test2 (uid UInt32 default 1,timestamp DateTime, event UInt32) engine=Memory;
insert into rate_test2(timestamp, event) values ('2018-01-01 01:01:01',1001),('2018-01-01 01:01:02',1002),('2018-01-01 01:01:03',1003),('2018-01-01 01:01:04',1004),('2018-01-01 01:01:05',1005),('2018-01-01 01:01:06',1006),('2018-01-01 01:01:07',1007),('2018-01-01 01:01:08',1008);
select 1.0 = boundingRatio(timestamp, event) from rate_test2;
drop table rate_test;
drop table rate_test2;
SELECT boundingRatio(number, number * 1.5) FROM numbers(10);
SELECT boundingRatio(number, exp(number)) = exp(1) - 1 FROM numbers(2);
