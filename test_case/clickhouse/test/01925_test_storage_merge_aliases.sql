select 'alias1';
select colAlias0, colAlias1, colAlias2, colAlias3 from alias_1;
select colAlias3, colAlias2, colAlias1, colAlias0 from merge;
select * from merge;
create table alias_2
(
    dt Date,
    col Int32,
    col2 Int32,
    colAlias0 UInt32 alias col,
    colAlias3 Int32 alias col3 + colAlias0,
    colAlias1 UInt32 alias colAlias0 + col2,
    colAlias2 Int32 alias colAlias0 + colAlias1,
    col3 Int32
)
engine = MergeTree()
order by (dt);
insert into alias_2 (dt, col, col2, col3) values ('2020-02-01', 1, 2, 3);
select 'alias2';
select colAlias0, colAlias1, colAlias2, colAlias3 from alias_2;
select colAlias3, colAlias2, colAlias1, colAlias0 from merge order by dt;
select * from merge order by dt;
