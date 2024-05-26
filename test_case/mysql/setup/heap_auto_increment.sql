drop table if exists t1;
create table t1 (a int not null auto_increment,b int, primary key (a)) engine=heap auto_increment=3;
insert into t1 values (1,1),(NULL,3),(NULL,4);
delete from t1 where a=4;
insert into t1 values (NULL,5),(NULL,6);
