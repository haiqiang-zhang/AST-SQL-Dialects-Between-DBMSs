select countSubstrings('aaaxxxaa\0xxx', pattern) from tab where id = 1;
select countSubstringsCaseInsensitive('aaaxxxaa\0xxx', pattern) from tab where id = 1;
select countSubstringsCaseInsensitiveUTF8('aaaxxxaa\0xxx', pattern) from tab where id = 1;
insert into tab values (2, 'aaaaa\0x', 'x');
select position('aaaaa\0x', pattern) from tab where id = 2;
select positionCaseInsensitive('aaaaa\0x', pattern) from tab where id = 2;
select positionCaseInsensitiveUTF8('aaaaa\0x', pattern) from tab where id = 2;
drop table if exists tab;
