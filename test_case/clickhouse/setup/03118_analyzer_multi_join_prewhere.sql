SET allow_experimental_analyzer=1;
CREATE TABLE a1 ( ANIMAL Nullable(String) ) engine = MergeTree order by tuple();
insert into a1 values('CROCO');
