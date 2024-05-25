select * from p order by i settings max_partitions_to_read = 2;
select * from p order by i settings max_partitions_to_read = 0;
alter table p modify setting max_partitions_to_read = 2;
select * from p order by i;
drop table if exists p;
