select load_file(concat(@tmpdir,"/outfile-test.1"));
select length(load_file(concat(@tmpdir,"/outfile-test.3")));
drop table t1;
CREATE TABLE t1 (a INT);
DROP TABLE t1;
create table t1(a int);
drop table t1;
create database mysqltest;
drop database mysqltest;
