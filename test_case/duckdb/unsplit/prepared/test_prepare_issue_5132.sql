create table test as select 42 i;
prepare q1 as SELECT cast(? AS VARCHAR) FROM test;
execute q1('oops');