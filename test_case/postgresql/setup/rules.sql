create table rtest_t1 (a int4, b int4);
create table rtest_t2 (a int4, b int4);
create table rtest_t3 (a int4, b int4);
create view rtest_v1 as select * from rtest_t1;
create rule rtest_v1_ins as on insert to rtest_v1 do instead
	insert into rtest_t1 values (new.a, new.b);
create rule rtest_v1_upd as on update to rtest_v1 do instead
	update rtest_t1 set a = new.a, b = new.b
	where a = old.a;
create rule rtest_v1_del as on delete to rtest_v1 do instead
	delete from rtest_t1 where a = old.a;
