DROP TABLE IF EXISTS t1;
create table t1 (a varchar(2) character set ucs2 collate ucs2_bin, key(a));
insert into t1 values ('A'),('A'),('B'),('C'),('D'),('A\t');
insert into t1 values ('A\0'),('A\0'),('A\0'),('A\0'),('AZ');
