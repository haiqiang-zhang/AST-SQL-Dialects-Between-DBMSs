DROP TABLE IF EXISTS open_events_tmp;
DROP TABLE IF EXISTS tracking_events_tmp;
CREATE TABLE open_events_tmp (`APIKey` UInt32, `EventDate` Date) ENGINE = MergeTree PARTITION BY toMonday(EventDate) ORDER BY (APIKey, EventDate);
CREATE TABLE tracking_events_tmp (`APIKey` UInt32, `EventDate` Date) ENGINE = MergeTree PARTITION BY toYYYYMM(EventDate) ORDER BY (APIKey, EventDate);
insert into open_events_tmp select 2, '2020-07-10' from numbers(32);
insert into open_events_tmp select 2, '2020-07-11' from numbers(31);
insert into open_events_tmp select 2, '2020-07-12' from numbers(30);
insert into tracking_events_tmp select 2, '2020-07-09' from numbers(1555);
insert into tracking_events_tmp select 2, '2020-07-10' from numbers(1881);
insert into tracking_events_tmp select 2, '2020-07-11' from numbers(1623);
DROP TABLE open_events_tmp;
DROP TABLE tracking_events_tmp;