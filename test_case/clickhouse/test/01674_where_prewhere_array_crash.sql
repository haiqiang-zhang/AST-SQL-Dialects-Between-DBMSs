drop table if exists tab;
create table tab  (x UInt64, `arr.a` Array(UInt64), `arr.b` Array(UInt64)) engine = MergeTree order by x;
drop table if exists tab;
