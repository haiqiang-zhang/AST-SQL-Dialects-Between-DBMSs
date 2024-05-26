drop table if exists prewhere_column_missing;
set allow_deprecated_syntax_for_merge_tree=1;
create table prewhere_column_missing (d Date default '2015-01-01', x UInt64) engine=MergeTree(d, x, 1);
insert into prewhere_column_missing (x) values (0);
