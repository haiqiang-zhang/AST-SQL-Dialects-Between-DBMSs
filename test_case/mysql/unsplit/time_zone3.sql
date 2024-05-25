drop table if exists t1;
create table t1 (i int, c varchar(20));
insert into t1 values
  (unix_timestamp("2004-01-01 00:00:00"), "2004-01-01 00:00:00");
insert into t1 values
  (unix_timestamp("2004-03-28 01:59:59"), "2004-03-28 01:59:59"),
  (unix_timestamp("2004-03-28 02:30:00"), "2004-03-28 02:30:00"),
  (unix_timestamp("2004-03-28 03:00:00"), "2004-03-28 03:00:00");
insert into t1 values
  (unix_timestamp('2004-05-01 00:00:00'),'2004-05-01 00:00:00');
insert into t1 values
  (unix_timestamp('2004-10-31 01:00:00'),'2004-10-31 01:00:00'),
  (unix_timestamp('2004-10-31 02:00:00'),'2004-10-31 02:00:00'),
  (unix_timestamp('2004-10-31 02:59:59'),'2004-10-31 02:59:59'),
  (unix_timestamp('2004-10-31 04:00:00'),'2004-10-31 04:00:00'),
  (unix_timestamp('2004-10-31 02:59:59'),'2004-10-31 02:59:59');
insert into t1 values
  (unix_timestamp('1981-07-01 03:59:59'),'1981-07-01 03:59:59'),
  (unix_timestamp('1981-07-01 04:00:00'),'1981-07-01 04:00:00');
insert into t1 values
  (unix_timestamp('2009-01-01 02:59:59'),'2009-01-01 02:59:59'),
  (unix_timestamp('2009-01-01 03:00:00'),'2009-01-01 03:00:00');
select i, from_unixtime(i), c from t1;
drop table t1;
create table t1 (ts timestamp);
insert into t1 values (19730101235900), (20040101235900);
select * from t1;
drop table t1;
SELECT FROM_UNIXTIME(1230768022), FROM_UNIXTIME(1230768023), FROM_UNIXTIME(1230768024);
