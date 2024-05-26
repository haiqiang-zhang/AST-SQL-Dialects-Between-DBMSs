SET send_logs_level = 'fatal';
DROP database IF EXISTS test_1603_rename_bug_ordinary;
set allow_deprecated_database_ordinary=1;
create database test_1603_rename_bug_ordinary engine=Ordinary;
create table test_1603_rename_bug_ordinary.foo engine=Memory as select * from numbers(100);
create table test_1603_rename_bug_ordinary.bar engine=Log as select * from numbers(200);
