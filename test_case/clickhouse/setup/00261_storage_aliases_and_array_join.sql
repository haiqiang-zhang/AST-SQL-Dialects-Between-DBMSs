drop table if exists aliases_test;
set allow_deprecated_syntax_for_merge_tree=1;
create table aliases_test (
date Date, id UInt64,
array default ['zero','one','two'],
d1 default array,
a1 alias array, a2 alias a1, a3 alias a2,
a4 alias arrayMap(x -> toString(x), range(3)), a5 alias a4, a6 alias a5,
`struct.d1` default array,
`struct.a1` alias array, `struct.a2` alias struct.a1, `struct.a3` alias struct.a2,
`struct.a4` alias arrayMap(x -> toString(x), range(3)), `struct.a5` alias struct.a4, `struct.a6` alias struct.a5
) engine=MergeTree(date, id, 1);
insert into aliases_test (id) values (0);
