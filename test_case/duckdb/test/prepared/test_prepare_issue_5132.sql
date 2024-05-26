prepare q1 as SELECT cast(? AS VARCHAR) FROM test;
execute q1('oops');
