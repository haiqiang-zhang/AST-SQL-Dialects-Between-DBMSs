create table test1(id integer primary key,a);
create table test2(id integer,b);
create view test as
      select test1.id as id,a as a,b as b
      from test1 join test2 on test2.id =  test1.id;
