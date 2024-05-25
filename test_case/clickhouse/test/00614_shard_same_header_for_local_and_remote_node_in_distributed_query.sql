set allow_deprecated_syntax_for_merge_tree=1;
create table tab (date Date,  time DateTime, data String) ENGINE = MergeTree(date, (time, data), 8192);
insert into tab values ('2018-01-21','2018-01-21 15:12:13','test');
drop table tab;
