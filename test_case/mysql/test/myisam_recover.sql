
set @start_table_open_cache=@@global.table_open_cache;
set @start_table_definition_cache=@@global.table_definition_cache;
set global table_open_cache=256;
set global table_definition_cache=400;
drop procedure if exists p_create;
create procedure p_create()
begin
  declare i int default 1;
  set @lock_table_stmt="lock table ";
  set @drop_table_stmt="drop table ";
    set @table_name=concat("t_", i);
    set @opt_comma=if(i=1, "", ", ");
    set @lock_table_stmt=concat(@lock_table_stmt, @opt_comma,
                                @table_name, " read");
    set @drop_table_stmt=concat(@drop_table_stmt, @opt_comma, @table_name);
    set @create_table_stmt=concat("create table if not exists ",
                                  @table_name, " (a int)");
    prepare stmt from @create_table_stmt;
    execute stmt;
    deallocate prepare stmt;
    set i= i+1;
  end while;
drop procedure p_create;
let $lock=`select @lock_table_stmt`;
drop table if exists t1, t1_mrg, t1_copy;
let $MYSQLD_DATADIR=`select @@datadir`;
create table t1 (a int, key(a)) engine=myisam;
create table t1_mrg (a int) union (t1) engine=merge;
insert into  t1 (a) values (1), (2), (3);
insert into  t1 (a) values (4), (5), (6);
select * from t1_mrg;
drop table t1, t1_mrg;
set @@global.table_definition_cache=@start_table_definition_cache;
set @@global.table_open_cache=@start_table_open_cache;

create table t1 (a int, key(a)) engine=myisam;
create table t2 (a int);
insert into t2 values (1);
insert into  t1 (a) values (1);
insert into  t1 (a) values (4);
set autocommit = 0;
select * from t2;
select * from t1;
let $wait_condition=
  SELECT count(*) = 1 FROM information_schema.processlist WHERE state
  LIKE "Waiting%" AND info = "ALTER TABLE t2 ADD val INT";
SET autocommit = 1;
drop table t1, t2;
