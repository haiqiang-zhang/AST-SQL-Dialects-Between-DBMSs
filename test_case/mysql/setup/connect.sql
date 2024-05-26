drop table if exists t1,t2;
create table t1 (id integer not null auto_increment primary key);
create temporary table t2(id integer not null auto_increment primary key);
delete from t1 where id like @id;
