desc table enums;
insert into enums (k) values (0);
select * from enums;
alter table enums modify column e Enum8('world' = 2, 'hello' = 1, '!' = 3);
desc table enums;
insert into enums (e, sign, letter) values ('!', 'plus', 'b');
select * from enums ORDER BY _part;
alter table enums
    modify column e Enum16('world' = 2, 'hello' = 1, '!' = 3),
    modify column sign Enum16('minus' = -1, 'plus' = 1),
    modify column letter Enum16('a' = 0, 'b' = 1, 'c' = 2, 'no letter' = -256);
desc table enums;
select * from enums ORDER BY _part;
alter table enums
    modify column e Enum8('world' = 2, 'hello' = 1, '!' = 3),
    modify column sign Enum8('minus' = -1, 'plus' = 1);
desc table enums;
insert into enums (letter, e) values ('c', 'world');
select * from enums ORDER BY _part;
drop table enums;
create table enums (e Enum8('a' = 0, 'b' = 1, 'c' = 2, 'd' = 3)) engine = TinyLog;
insert into enums values ('d'), ('b'), ('a'), ('c'), ('a'), ('d');
select * from enums;
select * from enums order by e;
select * from enums order by e desc;
select count(), e from enums group by e order by e;
select any(e) from enums;
select * from enums where e in ('a', 'd');
select * from enums where e in (select e from enums);
select distinct e from enums;
select * from enums where e = e;
select * from enums where e = 'a' or e = 'd';
select * from enums where e != 'a';
select *, e < 'b' from enums;
select *, e > 'b' from enums;
select toInt8(e), toInt16(e), toUInt64(e), toString(e), e from enums;
drop table if exists enums_copy;
create table enums_copy engine = TinyLog as select * from enums;
select * from enums_copy;
drop table enums_copy;
drop table enums;
