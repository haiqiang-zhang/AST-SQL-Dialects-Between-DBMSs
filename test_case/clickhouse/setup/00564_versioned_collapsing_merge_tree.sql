set allow_deprecated_syntax_for_merge_tree=1;
set optimize_on_insert = 0;
drop table if exists mult_tab;
create table mult_tab (date Date, value String, version UInt64, sign Int8) engine = VersionedCollapsingMergeTree(date, (date), 8192, sign, version);
insert into mult_tab select '2018-01-31', 'str_' || toString(number), 0, if(number % 2, 1, -1) from system.numbers limit 10;
insert into mult_tab select '2018-01-31', 'str_' || toString(number), 0, if(number % 2, 1, -1) from system.numbers limit 10;
