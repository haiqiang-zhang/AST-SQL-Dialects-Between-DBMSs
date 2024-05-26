drop table if exists trepl;
set allow_deprecated_syntax_for_merge_tree=1;
create table trepl(d Date,a Int32, b Int32) engine = ReplacingMergeTree(d, (a,b), 8192);
insert into trepl values ('2018-09-19', 1, 1);
