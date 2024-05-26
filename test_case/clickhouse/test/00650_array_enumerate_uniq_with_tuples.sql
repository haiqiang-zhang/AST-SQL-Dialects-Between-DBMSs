select arrayEnumerateUniq(n.x) from tab_00650;
drop table tab_00650;
create table tab_00650 (val UInt32, n Nested(x Nullable(UInt8), y String)) engine = Memory;
insert into tab_00650 values (1, [1, Null, 2, 1, 1, 2, 1, Null, Null], ['a', 'a', 'a', 'b', 'a', 'b', 'b', 'b', 'a']);
drop table tab_00650;
