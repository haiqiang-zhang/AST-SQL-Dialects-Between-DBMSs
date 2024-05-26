select count() from (select * from test union distinct select * from test);
select uuid from test union distinct select uuid from test;
select uuid from test union distinct select uuid from test union all select uuid from test where name = '1';
select uuid from (select * from test union distinct select * from test);
