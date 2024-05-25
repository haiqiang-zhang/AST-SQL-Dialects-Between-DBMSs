SET allow_experimental_analyzer=1;
create table table_local engine = Memory AS select * from numbers(10);
