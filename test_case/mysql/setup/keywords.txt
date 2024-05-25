drop table if exists t1;
create table t1 (time time, date date, timestamp timestamp,
quarter int, week int, year int, timestampadd int, timestampdiff int);
insert into t1 values ("12:22:22","97:02:03","1997-01-02",1,2,3,4,5);
