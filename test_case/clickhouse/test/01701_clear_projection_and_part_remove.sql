set mutations_sync = 2;
alter table tp_1 add projection pp (select x, count() group by x);
insert into tp_1 select number, number from numbers(4);
alter table tp_1 detach partition '0';
alter table tp_1 clear projection pp;
alter table tp_1 drop projection pp;
alter table tp_1 attach partition '0';
optimize table tp_1 final;
drop table tp_1;
