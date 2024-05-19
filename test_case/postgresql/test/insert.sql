create table inserttest (col1 int4, col2 int4 NOT NULL, col3 text default 'testing');
insert into inserttest (col1, col2, col3) values (DEFAULT, DEFAULT, DEFAULT);
insert into inserttest (col2, col3) values (3, DEFAULT);
insert into inserttest (col1, col2, col3) values (DEFAULT, 5, DEFAULT);
insert into inserttest values (DEFAULT, 5, 'test');
insert into inserttest values (DEFAULT, 7);

select * from inserttest;

insert into inserttest (col1, col2, col3) values (DEFAULT, DEFAULT);
insert into inserttest (col1, col2, col3) values (1, 2);
insert into inserttest (col1) values (1, 2);
insert into inserttest (col1) values (DEFAULT, DEFAULT);

select * from inserttest;

insert into inserttest values(10, 20, '40'), (-1, 2, DEFAULT),
    ((select 2), (select i from (values(3)) as foo (i)), 'values are fun!');

select * from inserttest;

insert into inserttest values(30, 50, repeat('x', 10000));

select col1, col2, char_length(col3) from inserttest;

drop table inserttest;

CREATE TABLE large_tuple_test (a int, b text) WITH (fillfactor = 10);
ALTER TABLE large_tuple_test ALTER COLUMN b SET STORAGE plain;

INSERT INTO large_tuple_test (select 1, NULL);

INSERT INTO large_tuple_test (select 2, repeat('a', 1000));
SELECT pg_size_pretty(pg_relation_size('large_tuple_test'::regclass, 'main'));

INSERT INTO large_tuple_test (select 3, NULL);

INSERT INTO large_tuple_test (select 4, repeat('a', 8126));

DROP TABLE large_tuple_test;


create type insert_test_type as (if1 int, if2 text[]);

create table inserttest (f1 int, f2 int[],
                         f3 insert_test_type, f4 insert_test_type[]);

insert into inserttest (f2[1], f2[2]) values (1,2);
insert into inserttest (f2[1], f2[2]) values (3,4), (5,6);
insert into inserttest (f2[1], f2[2]) select 7,8;
insert into inserttest (f2[1], f2[2]) values (1,default);  

insert into inserttest (f3.if1, f3.if2) values (1,array['foo']);
insert into inserttest (f3.if1, f3.if2) values (1,'{foo}'), (2,'{bar}');
insert into inserttest (f3.if1, f3.if2) select 3, '{baz,quux}';
insert into inserttest (f3.if1, f3.if2) values (1,default);  

insert into inserttest (f3.if2[1], f3.if2[2]) values ('foo', 'bar');
insert into inserttest (f3.if2[1], f3.if2[2]) values ('foo', 'bar'), ('baz', 'quux');
insert into inserttest (f3.if2[1], f3.if2[2]) select 'bear', 'beer';

insert into inserttest (f4[1].if2[1], f4[1].if2[2]) values ('foo', 'bar');
insert into inserttest (f4[1].if2[1], f4[1].if2[2]) values ('foo', 'bar'), ('baz', 'quux');
insert into inserttest (f4[1].if2[1], f4[1].if2[2]) select 'bear', 'beer';

select * from inserttest;

create table inserttest2 (f1 bigint, f2 text);
create rule irule1 as on insert to inserttest2 do also
  insert into inserttest (f3.if2[1], f3.if2[2])
  values (new.f1,new.f2);
create rule irule2 as on insert to inserttest2 do also
  insert into inserttest (f4[1].if1, f4[1].if2[2])
  values (1,'fool'),(new.f1,new.f2);
create rule irule3 as on insert to inserttest2 do also
  insert into inserttest (f4[1].if1, f4[1].if2[2])
  select new.f1, new.f2;

drop table inserttest2;
drop table inserttest;


create domain insert_pos_ints as int[] check (value[1] > 0);

create domain insert_test_domain as insert_test_type
  check ((value).if2[1] is not null);

create table inserttesta (f1 int, f2 insert_pos_ints);
create table inserttestb (f3 insert_test_domain, f4 insert_test_domain[]);

insert into inserttesta (f2[1], f2[2]) values (1,2);
insert into inserttesta (f2[1], f2[2]) values (3,4), (5,6);
insert into inserttesta (f2[1], f2[2]) select 7,8;
insert into inserttesta (f2[1], f2[2]) values (1,default);  
insert into inserttesta (f2[1], f2[2]) values (0,2);
insert into inserttesta (f2[1], f2[2]) values (3,4), (0,6);
insert into inserttesta (f2[1], f2[2]) select 0,8;

insert into inserttestb (f3.if1, f3.if2) values (1,array['foo']);
insert into inserttestb (f3.if1, f3.if2) values (1,'{foo}'), (2,'{bar}');
insert into inserttestb (f3.if1, f3.if2) select 3, '{baz,quux}';
insert into inserttestb (f3.if1, f3.if2) values (1,default);  
insert into inserttestb (f3.if1, f3.if2) values (1,array[null]);
insert into inserttestb (f3.if1, f3.if2) values (1,'{null}'), (2,'{bar}');
insert into inserttestb (f3.if1, f3.if2) select 3, '{null,quux}';

insert into inserttestb (f3.if2[1], f3.if2[2]) values ('foo', 'bar');
insert into inserttestb (f3.if2[1], f3.if2[2]) values ('foo', 'bar'), ('baz', 'quux');
insert into inserttestb (f3.if2[1], f3.if2[2]) select 'bear', 'beer';

insert into inserttestb (f3, f4[1].if2[1], f4[1].if2[2]) values (row(1,'{x}'), 'foo', 'bar');
insert into inserttestb (f3, f4[1].if2[1], f4[1].if2[2]) values (row(1,'{x}'), 'foo', 'bar'), (row(2,'{y}'), 'baz', 'quux');
insert into inserttestb (f3, f4[1].if2[1], f4[1].if2[2]) select row(1,'{x}')::insert_test_domain, 'bear', 'beer';

select * from inserttesta;
select * from inserttestb;

create table inserttest2 (f1 bigint, f2 text);
create rule irule1 as on insert to inserttest2 do also
  insert into inserttestb (f3.if2[1], f3.if2[2])
  values (new.f1,new.f2);
create rule irule2 as on insert to inserttest2 do also
  insert into inserttestb (f4[1].if1, f4[1].if2[2])
  values (1,'fool'),(new.f1,new.f2);
create rule irule3 as on insert to inserttest2 do also
  insert into inserttestb (f4[1].if1, f4[1].if2[2])
  select new.f1, new.f2;

drop table inserttest2;
drop table inserttesta;
drop table inserttestb;
drop domain insert_pos_ints;
drop domain insert_test_domain;


create domain insert_nnarray as int[]
  check (value[1] is not null and value[2] is not null);

create domain insert_test_domain as insert_test_type
  check ((value).if1 is not null and (value).if2 is not null);

create table inserttesta (f1 insert_nnarray);
insert into inserttesta (f1[1]) values (1);  
insert into inserttesta (f1[1], f1[2]) values (1, 2);

create table inserttestb (f1 insert_test_domain);
insert into inserttestb (f1.if1) values (1);  
insert into inserttestb (f1.if1, f1.if2) values (1, '{foo}');

drop table inserttesta;
drop table inserttestb;
drop domain insert_nnarray;
drop type insert_test_type cascade;

create table range_parted (
	a text,
	b int
) partition by range (a, (b+0));

insert into range_parted values ('a', 11);

create table part1 partition of range_parted for values from ('a', 1) to ('a', 10);
create table part2 partition of range_parted for values from ('a', 10) to ('a', 20);
create table part3 partition of range_parted for values from ('b', 1) to ('b', 10);
create table part4 partition of range_parted for values from ('b', 10) to ('b', 20);

insert into part1 values ('a', 11);
insert into part1 values ('b', 1);
insert into part1 values ('a', 1);
insert into part4 values ('b', 21);
insert into part4 values ('a', 10);
insert into part4 values ('b', 10);

insert into part1 values (null);
insert into part1 values (1);

create table list_parted (
	a text,
	b int
) partition by list (lower(a));
create table part_aa_bb partition of list_parted FOR VALUES IN ('aa', 'bb');
create table part_cc_dd partition of list_parted FOR VALUES IN ('cc', 'dd');
create table part_null partition of list_parted FOR VALUES IN (null);

insert into part_aa_bb values ('cc', 1);
insert into part_aa_bb values ('AAa', 1);
insert into part_aa_bb values (null);
insert into part_cc_dd values ('cC', 1);
insert into part_null values (null, 0);

create table part_ee_ff partition of list_parted for values in ('ee', 'ff') partition by range (b);
create table part_ee_ff1 partition of part_ee_ff for values from (1) to (10);
create table part_ee_ff2 partition of part_ee_ff for values from (10) to (20);

create table part_default partition of list_parted default;
insert into part_default values ('aa', 2);
insert into part_default values (null, 2);
insert into part_default values ('Zz', 2);
drop table part_default;
create table part_xx_yy partition of list_parted for values in ('xx', 'yy') partition by list (a);
create table part_xx_yy_p1 partition of part_xx_yy for values in ('xx');
create table part_xx_yy_defpart partition of part_xx_yy default;
create table part_default partition of list_parted default partition by range(b);
create table part_default_p1 partition of part_default for values from (20) to (30);
create table part_default_p2 partition of part_default for values from (30) to (40);

insert into part_ee_ff1 values ('EE', 11);
insert into part_default_p2 values ('gg', 43);
insert into part_ee_ff1 values ('cc', 1);
insert into part_default values ('gg', 43);
insert into part_ee_ff1 values ('ff', 1);
insert into part_ee_ff2 values ('ff', 11);
insert into part_default_p1 values ('cd', 25);
insert into part_default_p2 values ('de', 35);
insert into list_parted values ('ab', 21);
insert into list_parted values ('xx', 1);
insert into list_parted values ('yy', 2);
select tableoid::regclass, * from list_parted;


insert into range_parted values ('a', 0);
insert into range_parted values ('a', 1);
insert into range_parted values ('a', 10);
insert into range_parted values ('a', 20);
insert into range_parted values ('b', 1);
insert into range_parted values ('b', 10);
insert into range_parted values ('a');

create table part_def partition of range_parted default;
insert into part_def values ('b', 10);
insert into part_def values ('c', 10);
insert into range_parted values (null, null);
insert into range_parted values ('a', null);
insert into range_parted values (null, 19);
insert into range_parted values ('b', 20);

select tableoid::regclass, * from range_parted;
insert into list_parted values (null, 1);
insert into list_parted (a) values ('aA');
insert into list_parted values ('EE', 0);
insert into part_ee_ff values ('EE', 0);
insert into list_parted values ('EE', 1);
insert into part_ee_ff values ('EE', 10);
select tableoid::regclass, * from list_parted;

create table part_gg partition of list_parted for values in ('gg') partition by range (b);
create table part_gg1 partition of part_gg for values from (minvalue) to (1);
create table part_gg2 partition of part_gg for values from (1) to (10) partition by range (b);
create table part_gg2_1 partition of part_gg2 for values from (1) to (5);
create table part_gg2_2 partition of part_gg2 for values from (5) to (10);

create table part_ee_ff3 partition of part_ee_ff for values from (20) to (30) partition by range (b);
create table part_ee_ff3_1 partition of part_ee_ff3 for values from (20) to (25);
create table part_ee_ff3_2 partition of part_ee_ff3 for values from (25) to (30);

truncate list_parted;
insert into list_parted values ('aa'), ('cc');
insert into list_parted select 'Ff', s.a from generate_series(1, 29) s(a);
insert into list_parted select 'gg', s.a from generate_series(1, 9) s(a);
insert into list_parted (b) values (1);
select tableoid::regclass::text, a, min(b) as min_b, max(b) as max_b from list_parted group by 1, 2 order by 1;


create table hash_parted (
	a int
) partition by hash (a part_test_int4_ops);
create table hpart0 partition of hash_parted for values with (modulus 4, remainder 0);
create table hpart1 partition of hash_parted for values with (modulus 4, remainder 1);
create table hpart2 partition of hash_parted for values with (modulus 4, remainder 2);
create table hpart3 partition of hash_parted for values with (modulus 4, remainder 3);

insert into hash_parted values(generate_series(1,10));

insert into hpart0 values(12),(16);
insert into hpart0 values(11);
insert into hpart3 values(11);

select tableoid::regclass as part, a, a%4 as "remainder = a % 4"
from hash_parted order by part;


drop table range_parted, list_parted;
drop table hash_parted;

create table list_parted (a int) partition by list (a);
create table part_default partition of list_parted default;
insert into part_default values (null);
insert into part_default values (1);
insert into part_default values (-1);
select tableoid::regclass, a from list_parted;
drop table list_parted;

create table mlparted (a int, b int) partition by range (a, b);
create table mlparted1 (b int not null, a int not null) partition by range ((b+0));
create table mlparted11 (like mlparted1);
alter table mlparted11 drop a;
alter table mlparted11 add a int;
alter table mlparted11 drop a;
alter table mlparted11 add a int not null;
select attrelid::regclass, attname, attnum
from pg_attribute
where attname = 'a'
 and (attrelid = 'mlparted'::regclass
   or attrelid = 'mlparted1'::regclass
   or attrelid = 'mlparted11'::regclass)
order by attrelid::regclass::text;

alter table mlparted1 attach partition mlparted11 for values from (2) to (5);
alter table mlparted attach partition mlparted1 for values from (1, 2) to (1, 10);

insert into mlparted values (1, 2);
select tableoid::regclass, * from mlparted;

insert into mlparted (a, b) values (1, 5);

truncate mlparted;
alter table mlparted add constraint check_b check (b = 3);

create function mlparted11_trig_fn()
returns trigger AS
$$
begin
  NEW.b := 4;
  return NEW;
end;
$$
language plpgsql;
create trigger mlparted11_trig before insert ON mlparted11
  for each row execute procedure mlparted11_trig_fn();

insert into mlparted values (1, 2);
drop trigger mlparted11_trig on mlparted11;
drop function mlparted11_trig_fn();

insert into mlparted1 (a, b) values (2, 3);

create table lparted_nonullpart (a int, b char) partition by list (b);
create table lparted_nonullpart_a partition of lparted_nonullpart for values in ('a');
insert into lparted_nonullpart values (1);
drop table lparted_nonullpart;

alter table mlparted drop constraint check_b;
create table mlparted12 partition of mlparted1 for values from (5) to (10);
create table mlparted2 (b int not null, a int not null);
alter table mlparted attach partition mlparted2 for values from (1, 10) to (1, 20);
create table mlparted3 partition of mlparted for values from (1, 20) to (1, 30);
create table mlparted4 (like mlparted);
alter table mlparted4 drop a;
alter table mlparted4 add a int not null;
alter table mlparted attach partition mlparted4 for values from (1, 30) to (1, 40);
with ins (a, b, c) as
  (insert into mlparted (b, a) select s.a, 1 from generate_series(2, 39) s(a) returning tableoid::regclass, *)
  select a, b, min(c), max(c) from ins group by a, b order by 1;

alter table mlparted add c text;
create table mlparted5 (c text, a int not null, b int not null) partition by list (c);
create table mlparted5a (a int not null, c text, b int not null);
alter table mlparted5 attach partition mlparted5a for values in ('a');
alter table mlparted attach partition mlparted5 for values from (1, 40) to (1, 50);
alter table mlparted add constraint check_b check (a = 1 and b < 45);
insert into mlparted values (1, 45, 'a');
create function mlparted5abrtrig_func() returns trigger as $$ begin new.c = 'b'; return new; end; $$ language plpgsql;
create trigger mlparted5abrtrig before insert on mlparted5a for each row execute procedure mlparted5abrtrig_func();
insert into mlparted5 (a, b, c) values (1, 40, 'a');
drop table mlparted5;
alter table mlparted drop constraint check_b;

create table mlparted_def partition of mlparted default partition by range(a);
create table mlparted_def1 partition of mlparted_def for values from (40) to (50);
create table mlparted_def2 partition of mlparted_def for values from (50) to (60);
insert into mlparted values (40, 100);
insert into mlparted_def1 values (42, 100);
insert into mlparted_def2 values (54, 50);
insert into mlparted values (70, 100);
insert into mlparted_def1 values (52, 50);
insert into mlparted_def2 values (34, 50);
create table mlparted_defd partition of mlparted_def default;
insert into mlparted values (70, 100);

select tableoid::regclass, * from mlparted_def;

alter table mlparted add d int, add e int;
alter table mlparted drop e;
create table mlparted5 partition of mlparted
  for values from (1, 40) to (1, 50) partition by range (c);
create table mlparted5_ab partition of mlparted5
  for values from ('a') to ('c') partition by list (c);
create table mlparted5_cd partition of mlparted5
  for values from ('c') to ('e') partition by list (c);
create table mlparted5_a partition of mlparted5_ab for values in ('a');
create table mlparted5_b (d int, b int, c text, a int);
alter table mlparted5_ab attach partition mlparted5_b for values in ('b');
truncate mlparted;
insert into mlparted values (1, 2, 'a', 1);
insert into mlparted values (1, 40, 'a', 1);  
insert into mlparted values (1, 45, 'b', 1);  
insert into mlparted values (1, 45, 'c', 1);  
insert into mlparted values (1, 45, 'f', 1);  
select tableoid::regclass, * from mlparted order by a, b, c, d;
alter table mlparted drop d;
truncate mlparted;
alter table mlparted add e int, add d int;
alter table mlparted drop e;
insert into mlparted values (1, 2, 'a', 1);
insert into mlparted values (1, 40, 'a', 1);  
insert into mlparted values (1, 45, 'b', 1);  
insert into mlparted values (1, 45, 'c', 1);  
insert into mlparted values (1, 45, 'f', 1);  
select tableoid::regclass, * from mlparted order by a, b, c, d;
alter table mlparted drop d;
drop table mlparted5;

create table key_desc (a int, b int) partition by list ((a+0));
create table key_desc_1 partition of key_desc for values in (1) partition by range (b);

create user regress_insert_other_user;
grant select (a) on key_desc_1 to regress_insert_other_user;
grant insert on key_desc to regress_insert_other_user;

set role regress_insert_other_user;
insert into key_desc values (1, 1);

reset role;
grant select (b) on key_desc_1 to regress_insert_other_user;
set role regress_insert_other_user;
insert into key_desc values (1, 1);

insert into key_desc values (2, 1);
reset role;
revoke all on key_desc from regress_insert_other_user;
revoke all on key_desc_1 from regress_insert_other_user;
drop role regress_insert_other_user;
drop table key_desc, key_desc_1;

create table mcrparted (a int, b int, c int) partition by range (a, abs(b), c);
create table mcrparted0 partition of mcrparted for values from (minvalue, 0, 0) to (1, maxvalue, maxvalue);
create table mcrparted2 partition of mcrparted for values from (10, 6, minvalue) to (10, maxvalue, minvalue);
create table mcrparted4 partition of mcrparted for values from (21, minvalue, 0) to (30, 20, minvalue);

create table mcrparted0 partition of mcrparted for values from (minvalue, minvalue, minvalue) to (1, maxvalue, maxvalue);
create table mcrparted1 partition of mcrparted for values from (2, 1, minvalue) to (10, 5, 10);
create table mcrparted2 partition of mcrparted for values from (10, 6, minvalue) to (10, maxvalue, maxvalue);
create table mcrparted3 partition of mcrparted for values from (11, 1, 1) to (20, 10, 10);
create table mcrparted4 partition of mcrparted for values from (21, minvalue, minvalue) to (30, 20, maxvalue);
create table mcrparted5 partition of mcrparted for values from (30, 21, 20) to (maxvalue, maxvalue, maxvalue);

insert into mcrparted values (null, null, null);

insert into mcrparted values (0, 1, 1);
insert into mcrparted0 values (0, 1, 1);

insert into mcrparted values (9, 1000, 1);
insert into mcrparted1 values (9, 1000, 1);
insert into mcrparted values (10, 5, -1);
insert into mcrparted1 values (10, 5, -1);
insert into mcrparted values (2, 1, 0);
insert into mcrparted1 values (2, 1, 0);

insert into mcrparted values (10, 6, 1000);
insert into mcrparted2 values (10, 6, 1000);
insert into mcrparted values (10, 1000, 1000);
insert into mcrparted2 values (10, 1000, 1000);

insert into mcrparted values (11, 1, -1);
insert into mcrparted3 values (11, 1, -1);

insert into mcrparted values (30, 21, 20);
insert into mcrparted5 values (30, 21, 20);
insert into mcrparted4 values (30, 21, 20);	

select tableoid::regclass::text, * from mcrparted order by 1;

drop table mcrparted;

create table brtrigpartcon (a int, b text) partition by list (a);
create table brtrigpartcon1 partition of brtrigpartcon for values in (1);
create or replace function brtrigpartcon1trigf() returns trigger as $$begin new.a := 2; return new; end$$ language plpgsql;
create trigger brtrigpartcon1trig before insert on brtrigpartcon1 for each row execute procedure brtrigpartcon1trigf();
insert into brtrigpartcon values (1, 'hi there');
insert into brtrigpartcon1 values (1, 'hi there');

create table inserttest3 (f1 text default 'foo', f2 text default 'bar', f3 int);
create role regress_coldesc_role;
grant insert on inserttest3 to regress_coldesc_role;
grant insert on brtrigpartcon to regress_coldesc_role;
revoke select on brtrigpartcon from regress_coldesc_role;
set role regress_coldesc_role;
with result as (insert into brtrigpartcon values (1, 'hi there') returning 1)
  insert into inserttest3 (f3) select * from result;
reset role;

revoke all on inserttest3 from regress_coldesc_role;
revoke all on brtrigpartcon from regress_coldesc_role;
drop role regress_coldesc_role;
drop table inserttest3;
drop table brtrigpartcon;
drop function brtrigpartcon1trigf();

create table donothingbrtrig_test (a int, b text) partition by list (a);
create table donothingbrtrig_test1 (b text, a int);
create table donothingbrtrig_test2 (c text, b text, a int);
alter table donothingbrtrig_test2 drop column c;
create or replace function donothingbrtrig_func() returns trigger as $$begin raise notice 'b: %', new.b; return NULL; end$$ language plpgsql;
create trigger donothingbrtrig1 before insert on donothingbrtrig_test1 for each row execute procedure donothingbrtrig_func();
create trigger donothingbrtrig2 before insert on donothingbrtrig_test2 for each row execute procedure donothingbrtrig_func();
alter table donothingbrtrig_test attach partition donothingbrtrig_test1 for values in (1);
alter table donothingbrtrig_test attach partition donothingbrtrig_test2 for values in (2);
insert into donothingbrtrig_test values (1, 'foo'), (2, 'bar');
copy donothingbrtrig_test from stdout;
1	baz
2	qux
select tableoid::regclass, * from donothingbrtrig_test;

drop table donothingbrtrig_test;
drop function donothingbrtrig_func();

create table mcrparted (a text, b int) partition by range(a, b);
create table mcrparted1_lt_b partition of mcrparted for values from (minvalue, minvalue) to ('b', minvalue);
create table mcrparted2_b partition of mcrparted for values from ('b', minvalue) to ('c', minvalue);
create table mcrparted3_c_to_common partition of mcrparted for values from ('c', minvalue) to ('common', minvalue);
create table mcrparted4_common_lt_0 partition of mcrparted for values from ('common', minvalue) to ('common', 0);
create table mcrparted5_common_0_to_10 partition of mcrparted for values from ('common', 0) to ('common', 10);
create table mcrparted6_common_ge_10 partition of mcrparted for values from ('common', 10) to ('common', maxvalue);
create table mcrparted7_gt_common_lt_d partition of mcrparted for values from ('common', maxvalue) to ('d', minvalue);
create table mcrparted8_ge_d partition of mcrparted for values from ('d', minvalue) to (maxvalue, maxvalue);


insert into mcrparted values ('aaa', 0), ('b', 0), ('bz', 10), ('c', -10),
    ('comm', -10), ('common', -10), ('common', 0), ('common', 10),
    ('commons', 0), ('d', -10), ('e', 0);
select tableoid::regclass, * from mcrparted order by a, b;
drop table mcrparted;

create table returningwrtest (a int) partition by list (a);
create table returningwrtest1 partition of returningwrtest for values in (1);
insert into returningwrtest values (1) returning returningwrtest;

alter table returningwrtest add b text;
create table returningwrtest2 (b text, c int, a int);
alter table returningwrtest2 drop c;
alter table returningwrtest attach partition returningwrtest2 for values in (2);
insert into returningwrtest values (2, 'foo') returning returningwrtest;
drop table returningwrtest;
