drop table if exists test_table_hdfs_syntax;
create table test_table_hdfs_syntax (id UInt32) ENGINE = HDFS('');
create table test_table_hdfs_syntax (id UInt32) ENGINE = HDFS('','','', '');
drop table if exists test_table_hdfs_syntax;