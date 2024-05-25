create table test (j json);
insert into test values ('{"duck": 42}'), (NULL), ('{"goose": 43}');
select typeof(j), j from test;
select typeof(j), j from test;
