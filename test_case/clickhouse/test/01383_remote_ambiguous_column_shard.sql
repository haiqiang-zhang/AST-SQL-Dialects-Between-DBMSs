DROP DATABASE IF EXISTS test_01383;
CREATE DATABASE test_01383;
create table test_01383.fact (id1 Int64, id2 Int64, value Int64) ENGINE = MergeTree() ORDER BY id1;
create table test_01383.dimension (id1 Int64, name String) ENGINE = MergeTree() ORDER BY id1;
insert into test_01383.fact values (1,2,10),(2,2,10),(3,3,10),(4,3,10);
insert into test_01383.dimension values (1,'name_1'),(2,'name_1'),(3,'name_3'),(4, 'name_4');
DROP DATABASE test_01383;