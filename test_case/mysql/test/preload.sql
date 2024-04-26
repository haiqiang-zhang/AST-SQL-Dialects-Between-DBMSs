
--
-- Testing of PRELOAD
--

--disable_warnings
drop table if exists t1, t2;


create table t1 (
  a int not null auto_increment,
  b char(16) not null,
  primary key (a),
  key (b)
);

create table t2(
  a int not null auto_increment,
  b char(16) not null,
  primary key (a),
  key (b)
);

insert into t1(b) values 
  ('test0'),
  ('test1'),
  ('test2'),
  ('test3'),
  ('test4'),
  ('test5'),
  ('test6'),
  ('test7');
  
insert into t2(b) select b from t1;
insert into t1(b) select b from t2;
insert into t2(b) select b from t1;
insert into t1(b) select b from t2;
insert into t2(b) select b from t1;
insert into t1(b) select b from t2;
insert into t2(b) select b from t1;
insert into t1(b) select b from t2;
insert into t2(b) select b from t1;
insert into t1(b) select b from t2;
insert into t2(b) select b from t1;
insert into t1(b) select b from t2;
insert into t2(b) select b from t1;
insert into t1(b) select b from t2;
insert into t2(b) select b from t1;
insert into t1(b) select b from t2;
insert into t2(b) select b from t1;
insert into t1(b) select b from t2;

select count(*) from t1;
select count(*) from t2;

select count(*) from t1 where b = 'test1';
select count(*) from t1 where b = 'test1';
select @@preload_buffer_size;
select count(*) from t1 where b = 'test1';
set session preload_buffer_size=256*1024;
select @@preload_buffer_size;
select count(*) from t1 where b = 'test1';
set session preload_buffer_size=1*1024;
select @@preload_buffer_size;
select count(*) from t1 where b = 'test1';
select count(*) from t2 where b = 'test1';

drop table t1, t2;
