drop table if exists local_02175;
drop table if exists dist_02175;
create table local_02175 engine=Memory() as select * from system.one;
drop table local_02175;
