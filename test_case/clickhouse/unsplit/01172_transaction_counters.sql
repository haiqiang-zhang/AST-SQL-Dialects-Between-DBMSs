drop table if exists txn_counters;
create table txn_counters (n Int64, creation_tid DEFAULT transactionID()) engine=MergeTree order by n SETTINGS old_parts_lifetime=3600;
insert into txn_counters(n) values (1);
select transactionID();
system stop merges txn_counters;
set throw_on_unsupported_query_inside_transaction=0;
insert into txn_counters(n) values (2);
select 1, system.parts.name, txn_counters.creation_tid = system.parts.creation_tid from txn_counters join system.parts on txn_counters._part = system.parts.name where database=currentDatabase() and table='txn_counters' order by system.parts.name;
select 2, name, creation_csn, removal_tid, removal_csn from system.parts where database=currentDatabase() and table='txn_counters' order by system.parts.name;
insert into txn_counters(n) values (3);
select 3, system.parts.name, txn_counters.creation_tid = system.parts.creation_tid from txn_counters join system.parts on txn_counters._part = system.parts.name where database=currentDatabase() and table='txn_counters' order by system.parts.name;
select 4, name, creation_csn, removal_tid, removal_csn from system.parts where database=currentDatabase() and table='txn_counters' order by system.parts.name;
detach table txn_counters;
attach table txn_counters;
insert into txn_counters(n) values (4);
select 6, system.parts.name, txn_counters.creation_tid = system.parts.creation_tid from txn_counters join system.parts on txn_counters._part = system.parts.name where database=currentDatabase() and table='txn_counters' order by system.parts.name;
select 7, name, removal_tid, removal_csn from system.parts where database=currentDatabase() and table='txn_counters' and active order by system.parts.name;
insert into txn_counters(n) values (5);
alter table txn_counters drop partition id 'all';
system flush logs;
drop table txn_counters;
