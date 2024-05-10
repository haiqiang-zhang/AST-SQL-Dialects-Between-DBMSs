drop table if exists t1;
create table t1 (
  `a&b` int,
  `a<b` int,
  `a>b` text
);
insert into t1 values (1, 2, 'a&b a<b a>b');
drop table t1;
