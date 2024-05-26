drop table if exists t1,t2,t3,t4;
drop view if exists v1;
drop procedure if exists p1;
drop procedure if exists p2;
drop function if exists f1;
drop function if exists f2;
create table t1 (
	id   char(16) not null default '',
        data int not null
) engine=myisam;
create table t2 (
	s   char(16),
        i   int,
	d   double
) engine=myisam;
drop procedure if exists foo42;
create procedure foo42()
  insert into test.t1 values ("foo", 42);
