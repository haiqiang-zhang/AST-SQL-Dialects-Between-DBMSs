drop table if exists t1,t2,t3,t4,t5,t6,t7;
CREATE TABLE t1 (a blob, b text, c blob(250), d text(70000), e text(70000000));
create table t3 (a long, b long byte);
drop table if exists t1,t2;
create table t1 (nr int(5) not null auto_increment,b blob,str char(10), primary key (nr));
insert into t1 values (null,"a","A");
insert into t1 values (null,"bbb","BBB");
insert into t1 values (null,"ccc","CCC");
