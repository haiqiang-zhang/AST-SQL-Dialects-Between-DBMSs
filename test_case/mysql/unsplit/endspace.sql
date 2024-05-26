drop table if exists t1;
create table t1 (text1 varchar(32) not NULL, KEY key1 (text1)) charset latin1;
insert into t1 values ('teststring'), ('nothing'), ('teststring\t');
select * from t1 ignore key (key1) where text1='teststring' or 
  text1 like 'teststring_%' ORDER BY text1;
select * from t1 where text1='teststring' or text1 like 'teststring_%';
select * from t1 where text1='teststring' or text1 > 'teststring\t';
select * from t1 order by text1;
alter table t1 modify text1 char(32) binary not null;
select * from t1 ignore key (key1) where text1='teststring' or 
  text1 like 'teststring_%' ORDER BY text1;
select concat('|', text1, '|') as c from t1 where text1='teststring' or text1 like 'teststring_%' order by c;
select concat('|', text1, '|') from t1 where text1='teststring' or text1 > 'teststring\t';
select text1, length(text1) from t1 order by text1;
alter table t1 modify text1 blob not null, drop key key1, add key key1 (text1(20));
insert into t1 values ('teststring ');
alter table t1 modify text1 text not null, pack_keys=1;
select concat('|', text1, '|') as c from t1 where text1='teststring' or text1 like 'teststring_%' order by c;
drop table t1;
create table t1 (text1 varchar(32) not NULL, KEY key1 (text1)) charset latin1 pack_keys=0;
insert into t1 values ('teststring'), ('nothing'), ('teststring\t');
select concat('|', text1, '|') as c from t1 where text1='teststring' or text1 like 'teststring_%' order by c;
drop table t1;
create table t1 (text1 varchar(32) not NULL, KEY key1 using BTREE (text1))
charset latin1 engine=heap;
insert into t1 values ('teststring'), ('nothing'), ('teststring\t');
select * from t1 ignore key (key1) where text1='teststring' or 
  text1 like 'teststring_%' ORDER BY text1;
select * from t1 where text1='teststring' or text1 like 'teststring_%';
select * from t1 where text1='teststring' or text1 >= 'teststring\t';
select * from t1 order by text1;
alter table t1 modify text1 char(32) binary not null;
select * from t1 order by text1;
drop table t1;
create table t1 (text1 varchar(32) not NULL, KEY key1 (text1))
charset latin1 engine=innodb;
insert into t1 values ('teststring'), ('nothing'), ('teststring\t');
select * from t1 where text1='teststring' or text1 like 'teststring_%';
select * from t1 where text1='teststring' or text1 > 'teststring\t';
select * from t1 order by text1;
alter table t1 modify text1 char(32) binary not null;
select * from t1 order by text1;
alter table t1 modify text1 blob not null, drop key key1, add key key1 (text1(20));
insert into t1 values ('teststring ');
alter table t1 modify text1 text not null, pack_keys=1;
select * from t1 where text1 like 'teststring_%';
drop table t1;
