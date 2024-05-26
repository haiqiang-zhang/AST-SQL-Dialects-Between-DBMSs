drop table if exists parent;
drop table if exists child;
create table parent (id int, primary key(id)) engine MergeTree;
create table child  (id int, pid int, primary key(id), foreign key(pid) references parent(pid)) engine MergeTree;
