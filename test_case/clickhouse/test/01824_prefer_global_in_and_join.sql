-- { echo }
CREATE DATABASE IF NOT EXISTS test_01824;
USE test_01824;
DROP TABLE IF EXISTS t1_shard;
DROP TABLE IF EXISTS t2_shard;
DROP TABLE IF EXISTS t1_distr;
DROP TABLE IF EXISTS t2_distr;
create table t1_shard (id Int32) engine MergeTree order by id;
create table t2_shard (id Int32) engine MergeTree order by id;
insert into t1_shard values (42);
insert into t2_shard values (42);
SET prefer_global_in_and_join = 1;
set distributed_product_mode = 'local';
DROP TABLE t1_shard;
DROP TABLE t2_shard;
DROP DATABASE test_01824;
