explain pipeline select * from test final SETTINGS enable_vertical_final = 0;
select * from test final;
set max_threads =2;
explain pipeline select * from test final SETTINGS enable_vertical_final = 0;
DROP TABLE test;
