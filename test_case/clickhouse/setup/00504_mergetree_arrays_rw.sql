set allow_deprecated_syntax_for_merge_tree=1;
drop table if exists test_ins_arr;
create table test_ins_arr (date Date, val Array(UInt64)) engine = MergeTree(date, (date), 8192);
insert into test_ins_arr select toDate('2017-10-02'), [number, 42] from system.numbers limit 10000;
