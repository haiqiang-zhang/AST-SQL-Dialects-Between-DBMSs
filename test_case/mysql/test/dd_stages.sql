let $con1_thread_id=`select thread_id from performance_schema.threads where processlist_id = connection_id()`;
update performance_schema.threads set instrumented = 'NO' where processlist_id = connection_id();
create table t1(a int);
drop table t1;
create table t1(a int);
insert into t1 values (1), (2), (3), (4), (5);
drop table t1;
select event_name from performance_schema.events_stages_history_long
  where thread_id = @con1_thread_id and
        event_name like '%Opening %tables' or
        event_name like '%Locking system tables' or
        event_name like '%System lock';
update performance_schema.threads set instrumented = 'YES' where processlist_id = connection_id();
