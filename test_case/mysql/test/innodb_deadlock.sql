
set sql_mode="";
create table t1(a int)engine=innodb;
create table t2(b int)engine=innodb;
create procedure p1()
begin
  declare counter integer default 0;
    if rand()>0.5 then start transaction;
    if rand()>0.5 then 
      select var_samp(1), exists(select 1 from t1 lock in share mode) 
      from t1 into @a,@b;
    end if;
    if rand()>0.5 then 
      select var_samp(1), exists(select 1 from t1 for update)
      from t1 into @a,@b;
    end if;
    if rand()>0.5 then insert ignore into t1 values ();
    if rand()>0.5 then insert ignore into t2 values ();
    if rand()>0.5 then delete from t1;
    if rand()>0.5 then delete from t2;
    if rand()>0.5 then commit;
    set counter = counter + 1;
end $
delimiter ;

drop procedure p1;
drop table t1,t2;

set sql_mode=default;
