drop table if exists set_index;
create table set_index (a Int32, b Int32, INDEX b_set b type set(0) granularity 1) engine MergeTree order by tuple();
insert into set_index values (1, 2);
