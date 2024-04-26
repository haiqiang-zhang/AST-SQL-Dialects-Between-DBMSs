create procedure p_verify_reprepare_count(expected int)
begin
  declare old_reprepare_count int default @reprepare_count;

  select variable_value from
  performance_schema.session_status where
  variable_name='com_stmt_reprepare'
  into @reprepare_count;

  if old_reprepare_count + expected <> @reprepare_count then
    select concat("Expected: ", expected,
                   ", actual: ", @reprepare_count - old_reprepare_count)
    as "ERROR";
    select '' as "SUCCESS";
  end if;
set @reprepare_count= 0;

create table t1 (a int) engine=MyISAM;

insert into t1 values (1), (2), (3);

drop table t1;
create table t1 (a1 int, a2 int) engine=myisam;
insert into t1 values (1, 10), (2, 20), (3, 30);

alter table t1 add column b varchar(50) default NULL;

alter table t1 drop column b;

drop table t1;
create table t1 (a1 int, a2 int) engine=myisam;
insert into t1 values (1, 10), (2, 20), (3, 30);

alter table t1 add column b varchar(50) default NULL;

alter table t1 drop column b;

drop table t1;
create table t1 (a1 int, a2 int) engine=myisam;
insert into t1 values (1, 10), (2, 20), (3, 30);

alter table t1 add column b varchar(50) default NULL;

alter table t1 drop column b;

drop table t1;
drop procedure p_verify_reprepare_count;
