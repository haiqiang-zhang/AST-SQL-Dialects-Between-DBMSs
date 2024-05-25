drop table if EXISTS l;
drop table if EXISTS r;
CREATE TABLE l (luid Nullable(Int16), name String)
ENGINE=MergeTree order by luid settings allow_nullable_key=1 as
select * from VALUES ((1231, 'John'),(6666, 'Ksenia'),(Null, '---'));
CREATE TABLE r (ruid Nullable(Int16), name String)
ENGINE=MergeTree order by ruid  settings allow_nullable_key=1 as
select * from VALUES ((1231, 'John'),(1232, 'Johny'));
