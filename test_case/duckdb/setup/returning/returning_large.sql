CREATE TABLE table1 (a INTEGER DEFAULT -1, b INTEGER DEFAULT -2, c INTEGER DEFAULT -3);
insert into table1(a) select * from range (0, 4000, 1) t1(a);
