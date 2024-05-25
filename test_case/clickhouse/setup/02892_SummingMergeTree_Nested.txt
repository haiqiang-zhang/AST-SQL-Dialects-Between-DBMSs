drop table if exists nested_smt;
create table nested_smt (
     date date,
     val UInt64,
     counters_Map Nested (
         id UInt8,
         count Int32
     )
)
ENGINE = SummingMergeTree()
ORDER BY (date);
