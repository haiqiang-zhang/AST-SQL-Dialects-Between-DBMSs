drop table if exists t1;
create table t1 (xxx char(128));
insert into t1 (xxx) values('this is a test of some long text to see what happens');
