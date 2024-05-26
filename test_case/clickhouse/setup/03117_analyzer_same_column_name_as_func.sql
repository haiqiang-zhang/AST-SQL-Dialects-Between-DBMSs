SET allow_experimental_analyzer=1;
create table x(
    a UInt64,
    `sipHash64(a)` UInt64
) engine = MergeTree order by a;
insert into x select number, number from VALUES('number UInt64', 1000, 10000, 100000);
