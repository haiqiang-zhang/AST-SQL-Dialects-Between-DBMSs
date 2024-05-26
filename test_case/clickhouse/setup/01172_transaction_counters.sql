drop table if exists txn_counters;
create table txn_counters (n Int64, creation_tid DEFAULT transactionID()) engine=MergeTree order by n SETTINGS old_parts_lifetime=3600;
insert into txn_counters(n) values (1);
