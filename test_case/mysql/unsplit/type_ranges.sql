drop table if exists t1,t2,t3;
UNLOCK TABLES;
UNLOCK TABLES;
CREATE TABLE t2 (
  auto int(5) unsigned NOT NULL auto_increment,
  string char(20),
  mediumblob_col mediumblob not null,
  new_field char(2),
  PRIMARY KEY (auto)
);
select * from t2;
drop table t2;
create table t1 (c int);
insert into t1 values(1),(2);
create table t2 select * from t1;
create table t3 select t1.c AS c1, t2.c AS c2,1 as "const" from t1, t2;
drop table t1,t2,t3;
create table t1 ( myfield INT NOT NULL, UNIQUE INDEX (myfield), unique (myfield), index(myfield));
drop table t1;
create table t1 ( id integer unsigned not null primary key );
create table t2 ( id integer unsigned not null primary key );
insert into t1 values (1), (2);
insert into t2 values (1);
select  t1.id as id_A,  t2.id as id_B from t1 left join t2 using ( id );
select  t1.id as id_A,  t2.id as id_B from t1 left join t2 on (t1.id = t2.id);
create table t3 (id_A integer unsigned not null, id_B integer unsigned null  );
insert into t3 select t1.id as id_A,  t2.id as id_B from t1 left join t2 using ( id );
select * from t3;
insert into t3 select t1.id as id_A,  t2.id as id_B from t1 left join t2 on (t1.id = t2.id);
select * from t3;
drop table t3;
create table t3 select t1.id as id_A,  t2.id as id_B from t1 left join t2 using ( id );
select * from t3;
drop table t3;
create table t3 select t1.id as id_A,  t2.id as id_B from t1 left join t2 on (t1.id = t2.id);
select * from t3;
drop table t1,t2,t3;
