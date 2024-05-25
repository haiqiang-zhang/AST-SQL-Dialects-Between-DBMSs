alter table t add projection x (select * order by codectest);
insert into t values (1, 2);
select * from merge('', 't');
drop table t;
