
create table t1(a int, key(a)) engine=innodb;
insert into t1 values (0);
create procedure p1()
begin
  declare counter integer default 0;
   if rand()>0.5 then start transaction;
   if rand()>0.5 then select count(*) from t1 for update;
   update t1 set a = 1 where a >= 0;
   set counter = counter + 1;
end $
delimiter ;

drop procedure p1;
drop table t1;
