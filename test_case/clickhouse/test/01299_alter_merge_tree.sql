set allow_deprecated_syntax_for_merge_tree=1;
create table merge_tree ( CounterID UInt32,  StartDate Date,  Sign Int8,  VisitID UInt64,  UserID UInt64,  StartTime DateTime,   ClickLogID UInt64) ENGINE = CollapsingMergeTree(StartDate, intHash32(UserID), tuple(CounterID, StartDate, intHash32(UserID), VisitID, ClickLogID), 8192, Sign);
describe table merge_tree;
describe table merge_tree;
drop table merge_tree;
