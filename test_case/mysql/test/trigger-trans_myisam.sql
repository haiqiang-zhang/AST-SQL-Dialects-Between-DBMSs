
-- Note, for InnoDB to allow concurrent UPDATE and INSERT the
-- table must have a unique key.
create table t1 (c int primary key) engine=innodb;
create table t2 (c int) engine=myisam;
create table t3 (c int) engine=myisam;
insert into t1 (c) values (1);

create trigger trg_bug26141_ai after insert on t1
for each row
begin
  insert into t2 (c) values (1);
  select release_lock("lock_bug26141_sync") into @a;
  select get_lock("lock_bug26141_wait", 1000) into @a;

create trigger trg_bug26141_au after update on t1
for each row
begin
  insert into t3 (c) values (1);

-- Establish an alternative connection.
--connect (connection_aux,localhost,root,,test,,)
--connect (connection_update,localhost,root,,test,,)

connection connection_aux;
select get_lock("lock_bug26141_wait", 0);

--
connection default;
select get_lock("lock_bug26141_sync", /* must not be priorly locked */ 0);
select get_lock("lock_bug26141_sync", 1000);
update t1 set c=3 where c=1;
select release_lock("lock_bug26141_sync");
select release_lock("lock_bug26141_wait");
select * from t1;
select * from t2;
select * from t3;

-- Drops the trigger as well.
drop table t1, t2, t3;
