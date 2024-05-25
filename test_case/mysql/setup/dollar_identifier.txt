create table $t(id int);
drop table $t;
create table t(id int, $id int, $id2 int, `$$id` int, $ int, $1 int,
               `$$$` int, id$$$ int, 1$ int, `$$` int, _$ int, b$$lit$$ int);
