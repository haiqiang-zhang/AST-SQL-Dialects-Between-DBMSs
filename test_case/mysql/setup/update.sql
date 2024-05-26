drop table if exists t1,t2;
create table t1 (a int auto_increment , primary key (a));
insert into t1 values (NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL),(NULL);
update t1 set a=a+10 where a > 34;
update t1 set a=a+100 where a > 0;
update t1 set a=a+100 limit 0;
update t1 set a=a+100 where a=1 and a=2;
