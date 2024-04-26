
--
-- Fulltext configurable parameters
--
--disable_warnings
drop table if exists t1;

-- Save ft_boolean_syntax variable
let $saved_ft_boolean_syntax=`select @@global.ft_boolean_syntax`;

create table t1 (b text not null);
insert t1 values ('aaaaaa bbbbbb cccccc');
insert t1 values ('bbbbbb cccccc');
insert t1 values ('aaaaaa cccccc');
select * from t1 where match b against ('+aaaaaa bbbbbb' in boolean mode);
set ft_boolean_syntax=' +-><()~*:""&|';
set global ft_boolean_syntax=' +-><()~*:""&|';
select * from t1 where match b against ('+aaaaaa bbbbbb' in boolean mode);
set global ft_boolean_syntax='@ -><()~*:""&|';
select * from t1 where match b against ('+aaaaaa bbbbbb' in boolean mode);
select * from t1 where match b against ('+aaaaaa @bbbbbb' in boolean mode);
set global ft_boolean_syntax='@ -><()~*:""@|';
set global ft_boolean_syntax='+ -><()~*:""@!|';
drop table t1;

-- Restore ft_boolean_syntax variable
--disable_query_log
eval set global ft_boolean_syntax='$saved_ft_boolean_syntax';
