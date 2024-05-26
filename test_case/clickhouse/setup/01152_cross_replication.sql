DROP DATABASE IF EXISTS shard_0;
DROP DATABASE IF EXISTS shard_1;
SET distributed_ddl_output_mode='none';
DROP TABLE IF EXISTS demo_loan_01568_dist;
CREATE DATABASE shard_0;
CREATE DATABASE shard_1;
SET distributed_ddl_output_mode='throw';
SET distributed_ddl_output_mode='none';
