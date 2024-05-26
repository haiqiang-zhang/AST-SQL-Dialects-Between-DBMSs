select '10000000';
select count() from tsv;
insert into tsv(a) select number from numbers(10000000);
select '20000000';
insert into tsv(a) select number from numbers(10000000);
select '30000000';
drop table tsv;
