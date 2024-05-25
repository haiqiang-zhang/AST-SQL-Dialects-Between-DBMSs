SET send_logs_level = 'fatal';
drop table if exists rmt;
drop table if exists rmt2;
set replication_alter_partitions_sync=0;
system flush logs;
