set allow_deprecated_syntax_for_merge_tree=1;
create table merge_distributed1 ( CounterID UInt32,  StartDate Date,  Sign Int8,  VisitID UInt64,  UserID UInt64,  StartTime DateTime,   ClickLogID UInt64) ENGINE = CollapsingMergeTree(StartDate, intHash32(UserID), tuple(CounterID, StartDate, intHash32(UserID), VisitID, ClickLogID), 8192, Sign);
insert into merge_distributed1 values (1, '2013-09-19', 1, 0, 2, '2013-09-19 12:43:06', 3);
alter table merge_distributed1 add column dummy String after CounterID;
insert into merge_distributed1 values (1, 'Hello, Alter Table!','2013-09-19', 1, 0, 2, '2013-09-19 12:43:06', 3);
drop table merge_distributed1;
