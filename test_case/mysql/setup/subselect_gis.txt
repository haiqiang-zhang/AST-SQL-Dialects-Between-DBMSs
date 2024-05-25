drop table if exists t1;
create table t1(City VARCHAR(30),Location geometry);
insert into t1 values("Paris",ST_GeomFromText('POINT(2.33 48.87)'));
