-- Tag no-fasttest: Depends on AWS

-- { echo }
drop table if exists test_02245_s3_nested_parquet1;
drop table if exists test_02245_s3_nested_parquet2;
insert into test_02245_s3_nested_parquet1 values (1, (2, 'a'));
insert into test_02245_s3_nested_parquet2 values (1, (2, (3, 'a')));
drop table if exists test_02245_s3_nested_arrow1;
drop table if exists test_02245_s3_nested_arrow2;
insert into test_02245_s3_nested_arrow1 values (1, (2, 'a'));
insert into test_02245_s3_nested_arrow2 values (1, (2, (3, 'a')));
drop table if exists test_02245_s3_nested_orc1;
drop table if exists test_02245_s3_nested_orc2;
insert into test_02245_s3_nested_orc1 values (1, (2, 'a'));
insert into test_02245_s3_nested_orc2 values (1, (2, (3, 'a')));