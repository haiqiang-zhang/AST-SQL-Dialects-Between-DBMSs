system stop merges t2;
insert into t2 select number from numbers_mt(1e6);
insert into t2 select number from numbers_mt(1e6);
