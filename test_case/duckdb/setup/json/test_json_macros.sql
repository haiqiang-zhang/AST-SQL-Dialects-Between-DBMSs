pragma enable_verification;
create table t1 as select range + 10 n, range v from range(10);
insert into t1 values (0, NULL), (20, NULL), (21, NULL), (1, 10), (2, 11);
create table t2 (j json);
insert into t2 values ('{"a": 42}'), ('{"a": 42.42, "b": "duck"}');
