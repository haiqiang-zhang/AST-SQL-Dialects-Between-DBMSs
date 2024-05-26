drop table if exists t_00712_2;
set allow_deprecated_syntax_for_merge_tree=1;
create table t_00712_2 (date Date, counter UInt64, sampler UInt64, alias_col alias date + 1) engine = MergeTree(date, intHash32(sampler), (counter, date, intHash32(sampler)), 8192);
insert into t_00712_2 values ('2018-01-01', 1, 1);
