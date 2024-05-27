set allow_experimental_parallel_reading_from_replicas = 0;
drop table if exists sample_final;
create table sample_final (CounterID UInt32, EventDate Date, EventTime DateTime, UserID UInt64, Sign Int8) engine = CollapsingMergeTree(Sign) order by (CounterID, EventDate, intHash32(UserID), EventTime) sample by intHash32(UserID) SETTINGS index_granularity = 8192, index_granularity_bytes = '10Mi';
insert into sample_final select number / (8192 * 4), toDate('2019-01-01'), toDateTime('2019-01-01 00:00:01') + number, number / (8192 * 2), number % 3 = 1 ? -1 : 1 from numbers(1000000);