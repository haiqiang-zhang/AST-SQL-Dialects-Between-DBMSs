SELECT s FROM buffer_table1;
insert into merge_tree_table1 values ('a', 1);
select s from buffer_table1 where x = 1;
select s from buffer_table1 where x = 2;
DROP TABLE IF EXISTS merge_tree_table1;
DROP TABLE buffer_table1;
