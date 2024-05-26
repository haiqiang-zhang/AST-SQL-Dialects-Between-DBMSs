create table t1 (a int not null,b int not null, primary key using BTREE (a)) engine=heap comment="testing heaps";
insert into t1 values(1,1),(2,2),(3,3),(4,4);
alter table t1 modify a int not null auto_increment, engine=myisam, comment="new myisam table";
