show create table child;
create table child2 (id int, pid int, primary key(id), 
                     foreign key(pid) references parent(pid) on delete cascade) engine MergeTree;
show create table child2;
create table child3 (id int, pid int, primary key(id), 
                     foreign key(pid) references parent(pid) on delete cascade on update restrict) engine MergeTree;
show create table child3;
drop table child3;
drop table child2;
drop table child;
drop table parent;
