create table t1 (d date);
insert into t1 values (date_add(NULL, INTERVAL 1 DAY));
insert into t1 values (date_add('2000-01-04', INTERVAL NULL DAY));
insert into t1 values (date_add(NULL, INTERVAL 1 DAY));
insert into t1 values (date_add('2000-01-04', INTERVAL NULL DAY));
