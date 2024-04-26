select @@session.transaction_isolation;
drop table if exists t0, t1, t2, t3, t4, t5;
drop view if exists v1, v2;
drop procedure if exists p1;
drop procedure if exists p2;
drop function if exists f1;
drop function if exists f2;
drop function if exists f3;
drop function if exists f4;
drop function if exists f5;
drop function if exists f6;
drop function if exists f7;
drop function if exists f8;
drop function if exists f9;
drop function if exists f10;
drop function if exists f11;
drop function if exists f12;
drop function if exists f13;
drop function if exists f14;
drop function if exists f15;
create table t1 (i int primary key) engine=innodb;
insert into t1 values (1), (2), (3), (4), (5);
create table t2 (j int primary key) engine=innodb;
insert into t2 values (1), (2), (3), (4), (5);
create table t3 (k int primary key) engine=innodb;
insert into t3 values (1), (2), (3);
create table t4 (l int primary key) engine=innodb;
insert into t4 values (1);
create table t5 (l int primary key) engine=innodb;
insert into t5 values (1);
create view v1 as select i from t1;
create view v2 as select j from t2 where j in (select i from t1);
create procedure p1(k int) insert into t2 values (k);
create function f1() returns int
begin
  declare j int;
  select i from t1 where i = 1 into j;
create function f2() returns int
begin
  declare k int;
  select i from t1 where i = 1 into k;
  insert into t2 values (k + 5);
create function f3() returns int
begin
  return (select i from t1 where i = 3);
create function f4() returns int
begin
  if (select i from t1 where i = 3) then
    return 1;
    return 0;
  end if;
create function f5() returns int
begin
  insert into t2 values ((select i from t1 where i = 1) + 5);
create function f6() returns int
begin
  declare k int;
  select i from v1 where i = 1 into k;
create function f7() returns int
begin
  declare k int;
  select j from v2 where j = 1 into k;
create function f8() returns int
begin
  declare k int;
  select i from v1 where i = 1 into k;
  insert into t2 values (k+5);
create function f9() returns int
begin
  update v2 set j=j+10 where j=1;
create function f10() returns int
begin
  return f1();
create function f11() returns int
begin
  declare k int;
  set k= f1();
  insert into t2 values (k+5);
create function f12(p int) returns int
begin
  insert into t2 values (p);
create function f13(p int) returns int
begin
  return p;
create procedure p2(inout p int)
begin
  select i from t1 where i = 1 into p;
create function f14() returns int
begin
  declare k int;
  insert into t2 values (k+5);
create function f15() returns int
begin
  declare k int;
create trigger t4_bi before insert on t4 for each row
begin
  declare k int;
  select i from t1 where i=1 into k;
  set new.l= k+1;
create trigger t4_bu before update on t4 for each row
begin
  if (select i from t1 where i=1) then
    set new.l= 2;
  end if;
create trigger t4_bd before delete on t4 for each row
begin
  if !(select i from v1 where i=1) then
    signal sqlstate '45000';
  end if;
create trigger t5_bi before insert on t5 for each row
begin
  set new.l= f1()+1;
create trigger t5_bu before update on t5 for each row
begin
  declare j int;
  set new.l= j + 1;
let $con_aux= con1;
let $table= t1;
let $statement= select * from t1;
let $statement= update t2, t1 set j= j - 1 where i = j;
let $wait_statement= $statement;
let $statement= delete t2 from t1, t2 where i = j;
let $wait_statement= $statement;
let $statement= describe t1;
let $statement= show create table t1;
let $statement= show keys from t1;
let $statement= call p1((select i + 5 from t1 where i = 1));
let $wait_statement= $statement;
let $statement= create table t0 engine=innodb select * from t1;
let $wait_statement= $statement;
drop table t0;
let $statement= create table t0 engine=innodb select j from t2 where j in (select i from t1);
let $wait_statement= $statement;
drop table t0;
let $statement= delete from t2 where j in (select i from t1);
let $wait_statement= $statement;
let $statement= delete t2 from t3, t2 where k = j and j in (select i from t1);
let $wait_statement= $statement;
let $statement= do (select i from t1 where i = 1);
let $wait_statement= $statement;
let $statement= insert into t2 select i+5 from t1;
let $wait_statement= $statement;
let $statement= insert into t2 values ((select i+5 from t1 where i = 4));
let $wait_statement= $statement;
let $statement= load data infile '../../std_data/rpl_loaddata.dat' into table t2 (@a, @b) set j= @b + (select i from t1 where i = 1);
let $wait_statement= $statement;
let $statement= replace into t2 select i+5 from t1;
let $wait_statement= $statement;
let $statement= replace into t2 values ((select i+5 from t1 where i = 4));
let $wait_statement= $statement;
let $statement= select * from t2 where j in (select i from t1);
let $statement= set @a:= (select i from t1 where i = 1);
let $wait_statement= $statement;
let $statement= show tables from test where Tables_in_test = 't2' and (select i from t1 where i = 1);
let $wait_statement= $statement;
let $statement= show columns from t2 where (select i from t1 where i = 1);
let $wait_statement= $statement;
let $statement= update t2 set j= j-10 where j in (select i from t1);
let $wait_statement= $statement;
let $statement= update t2, t3 set j= j -10 where j=k and j in (select i from t1);
let $wait_statement= $statement;
let $statement= select * from v1;
let $statement= select * from v2;
let $statement= select * from t2 where j in (select i from v1);
let $statement= select * from t3 where k in (select j from v2);
let $statement= update t2 set j= j-10 where j in (select i from v1);
let $wait_statement= $statement;
let $statement= update t3 set k= k-10 where k in (select j from v2);
let $wait_statement= $statement;
let $statement= update t2, v1 set j= j-10 where j = i;
let $wait_statement= $statement;
let $statement= update v2 set j= j-10 where j = 3;
let $wait_statement= $statement;
let $statement= select f1();
let $wait_statement= select i from t1 where i = 1 into j;
let $statement= set @a:= f1();
let $wait_statement= select i from t1 where i = 1 into j;
let $statement= insert into t2 values (f1() + 5);
let $wait_statement= select i from t1 where i = 1 into j;
let $statement= select f2();
let $wait_statement= select i from t1 where i = 1 into k;
let $statement= set @a:= f2();
let $wait_statement= select i from t1 where i = 1 into k;
let $statement= select f3();
let $wait_statement= $statement;
let $statement= set @a:= f3();
let $wait_statement= $statement;
let $statement= select f4();
let $wait_statement= $statement;
let $statement= set @a:= f4();
let $wait_statement= $statement;
let $statement= insert into t2 values (f3() + 5);
let $wait_statement= $statement;
let $statement= insert into t2 values (f4() + 6);
let $wait_statement= $statement;
let $statement= select f5();
let $wait_statement= insert into t2 values ((select i from t1 where i = 1) + 5);
let $statement= set @a:= f5();
let $wait_statement= insert into t2 values ((select i from t1 where i = 1) + 5);
let $statement= select f6();
let $wait_statement= select i from v1 where i = 1 into k;
let $statement= set @a:= f6();
let $wait_statement= select i from v1 where i = 1 into k;
let $statement= select f7();
let $wait_statement= select j from v2 where j = 1 into k;
let $statement= set @a:= f7();
let $wait_statement= select j from v2 where j = 1 into k;
let $statement= insert into t3 values (f6() + 5);
let $wait_statement= select i from v1 where i = 1 into k;
let $statement= insert into t3 values (f7() + 5);
let $wait_statement= select j from v2 where j = 1 into k;
let $statement= select f8();
let $wait_statement= select i from v1 where i = 1 into k;
let $statement= select f9();
let $wait_statement= update v2 set j=j+10 where j=1;
let $statement= select f10();
let $wait_statement= select i from t1 where i = 1 into j;
let $statement= insert into t2 values (f10() + 5);
let $wait_statement= select i from t1 where i = 1 into j;
let $statement= select f11();
let $wait_statement= select i from t1 where i = 1 into j;
let $statement= select f12((select i+10 from t1 where i=1));
let $statement= insert into t2 values (f13((select i+10 from t1 where i=1)));
let $wait_statement= $statement;
let $statement= call p2(@a);
let $statement= select f14();
let $wait_statement= select i from t1 where i = 1 into p;
let $statement= select f15();
let $wait_statement= select i from t1 where i = 1 into p;
let $statement= insert into t2 values (f15()+5);
let $wait_statement= select i from t1 where i = 1 into p;
let $statement= insert into t4 values (2);
let $wait_statement= select i from t1 where i=1 into k;
let $statement= update t4 set l= 2 where l = 1;
let $wait_statement= $statement;
let $statement= delete from t4 where l = 1;
let $wait_statement= $statement;
let $statement= insert into t5 values (2);
let $wait_statement= select i from t1 where i = 1 into j;
let $statement= update t5 set l= 2 where l = 1;
let $wait_statement= select i from t1 where i = 1 into p;
drop function f1;
drop function f2;
drop function f3;
drop function f4;
drop function f5;
drop function f6;
drop function f7;
drop function f8;
drop function f9;
drop function f10;
drop function f11;
drop function f12;
drop function f13;
drop function f14;
drop function f15;
drop view v1, v2;
drop procedure p1;
drop procedure p2;
drop table t1, t2, t3, t4, t5;
drop table if exists t1, t2;
create table t1 (i int auto_increment not null primary key) engine=innodb;
create table t2 (i int) engine=innodb;
insert into t1 values (1), (2), (3), (4), (5);
insert into t2 select count(*) from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 add column j int";
insert into t1 values (6);
drop tables t1, t2;
create table t1 (i int auto_increment not null primary key) engine=innodb
  partition by hash (i) partitions 4;
create table t2 (i int) engine=innodb;
insert into t1 values (1), (2), (3), (4), (5);
select * from t1;
let $wait_condition=
  select count(*) = 1 from information_schema.processlist
  where state = "Waiting for table metadata lock" and
        info = "alter table t1 rebuild partition p0";
insert into t2 select count(*) from t1;
drop tables t1, t2;
