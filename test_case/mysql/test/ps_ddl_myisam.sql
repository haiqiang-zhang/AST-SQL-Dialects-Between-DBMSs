select variable_value from
  performance_schema.session_status where
  variable_name='com_stmt_reprepare'
  into @reprepare_count;
select '' as "SUCCESS";
create table t1 (a int) engine=MyISAM;
insert into t1 values (1), (2), (3);
prepare stmt from "repair table t1";
drop table t1;
create table t1 (a1 int, a2 int) engine=myisam;
insert into t1 values (1, 10), (2, 20), (3, 30);
alter table t1 add column b varchar(50) default NULL;
alter table t1 drop column b;
prepare stmt from "analyze table t1";
drop table t1;
create table t1 (a1 int, a2 int) engine=myisam;
insert into t1 values (1, 10), (2, 20), (3, 30);
alter table t1 add column b varchar(50) default NULL;
alter table t1 drop column b;
prepare stmt from "optimize table t1";
drop table t1;
create table t1 (a1 int, a2 int) engine=myisam;
insert into t1 values (1, 10), (2, 20), (3, 30);
alter table t1 add column b varchar(50) default NULL;
alter table t1 drop column b;
drop table t1;
