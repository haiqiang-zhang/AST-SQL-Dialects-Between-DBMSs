set allow_experimental_analyzer = 1;
set distributed_product_mode = 'local';
drop table if exists shard1;
drop table if exists shard2;
drop table if exists distr1;
drop table if exists distr2;
create table shard1 (id Int32) engine = MergeTree order by cityHash64(id);
create table shard2 (id Int32) engine = MergeTree order by cityHash64(id);
insert into shard1 (id) values (0), (1);
insert into shard2 (id) values (1), (2);
drop table shard1;
drop table shard2;
