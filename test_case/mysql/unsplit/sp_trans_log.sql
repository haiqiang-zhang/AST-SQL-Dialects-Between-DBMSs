drop function if exists bug23333;
drop table if exists t1,t2;
CREATE TABLE t1 (a int  NOT NULL auto_increment primary key) ENGINE=MyISAM;
CREATE TABLE t2 (a int  NOT NULL auto_increment, b int, PRIMARY KEY (a)) ENGINE=InnoDB;
insert into t2 values (1,1);
select count(*) from t1 into @a;
drop table t1,t2;
drop function if exists bug23333;
