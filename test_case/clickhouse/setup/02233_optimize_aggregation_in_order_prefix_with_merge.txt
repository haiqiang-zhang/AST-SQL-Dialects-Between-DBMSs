drop table if exists data_02233;
create table data_02233 (partition Int, parent_key Int, child_key Int, value Int) engine=MergeTree() partition by partition order by parent_key;
insert into data_02233 values (1, 10, 100, 1000)(1, 20, 200, 2000);
insert into data_02233 values (2, 10, 100, 1000)(2, 20, 200, 2000);
