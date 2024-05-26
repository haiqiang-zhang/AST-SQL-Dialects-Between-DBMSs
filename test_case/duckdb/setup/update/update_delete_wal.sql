SET wal_autocheckpoint='1TB';
create table test (id bigint primary key, c1 text);
insert into test (id, c1) values (1, 'foo');
insert into test (id, c1) values (2, 'bar');
begin transaction;
delete from test where id = 1;
update test set c1='baz' where id=2;
commit;
