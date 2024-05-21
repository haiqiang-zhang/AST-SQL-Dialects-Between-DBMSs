drop table if exists local_02175;
drop table if exists dist_02175;
create table local_02175 engine=Memory() as select * from system.one;
create table dist_02175 as local_02175 engine=Distributed(test_cluster_two_shards, currentDatabase(), local_02175);
select * from dist_02175 l join local_02175 r using dummy;
select * from dist_02175 l global join local_02175 r using dummy;
drop table local_02175;
drop table dist_02175;