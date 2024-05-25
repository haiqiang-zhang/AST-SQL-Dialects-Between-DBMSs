select * from t1 where a = 'a' AND c = 'd';
drop table t1;
create table t1 (a int not null) partition by range columns(a) (
  partition p0 values less than (10),
  partition p1 values less than (20),
  partition p2 values less than (30),
  partition p3 values less than (40),
  partition p4 values less than (50),
  partition p5 values less than (60),
  partition p6 values less than (70)
);
insert into t1 values (5),(15),(25),(35),(45),(55),(65);
insert into t1 values (5),(15),(25),(35),(45),(55),(65);
create table t2 (a int not null) partition by range(a) (
  partition p0 values less than (10),
  partition p1 values less than (20),
  partition p2 values less than (30),
  partition p3 values less than (40),
  partition p4 values less than (50),
  partition p5 values less than (60),
  partition p6 values less than (70)
);
insert into t2 values (5),(15),(25),(35),(45),(55),(65);
insert into t2 values (5),(15),(25),(35),(45),(55),(65);
drop table t1, t2;
create table t1 (a int not null, b int not null ) 
partition by range columns(a,b) (
  partition p01 values less than (2,10),
  partition p02 values less than (2,20),
  partition p03 values less than (2,30),

  partition p11 values less than (4,10),
  partition p12 values less than (4,20),
  partition p13 values less than (4,30),

  partition p21 values less than (6,10),
  partition p22 values less than (6,20),
  partition p23 values less than (6,30)
);
insert into t1 values (2,5), (2,15), (2,25),
  (4,5), (4,15), (4,25), (6,5), (6,15), (6,25);
insert into t1 select * from t1;
drop table t1;
