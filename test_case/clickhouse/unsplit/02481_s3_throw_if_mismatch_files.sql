-- Tag no-fasttest: Depends on AWS

-- { echo }
drop table if exists test_02481_mismatch_files;
set s3_truncate_on_insert=1;
