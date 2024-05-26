drop table if exists test54378;
set allow_deprecated_syntax_for_merge_tree=1;
create table test54378 (part_date Date, pk_date Date, date Date) Engine=MergeTree(part_date, pk_date, 8192);
insert into test54378 values ('2018-04-19', '2018-04-19', '2018-04-19');
