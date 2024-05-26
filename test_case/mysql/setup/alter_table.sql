create table t1 (
col1 int not null auto_increment primary key,
col2 varchar(30) not null,
col3 varchar (20) not null,
col4 varchar(4) not null,
col5 enum('PENDING', 'ACTIVE', 'DISABLED') not null,
col6 int not null, to_be_deleted int);
insert into t1 values (2,4,3,5,"PENDING",1,7);
