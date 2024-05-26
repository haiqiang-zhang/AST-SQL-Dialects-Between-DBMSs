SELECT '-------------------------';
insert into test_zkinsert (name, path, value) values ('testc', '/2-insert-testx', 'x');
insert into test_zkinsert (name, path, value) values ('testz', '/2-insert-testx', 'y');
insert into test_zkinsert (name, path, value) values ('testc', '/2-insert-testz//c/cd/dd//', 'y');
insert into test_zkinsert (name, path) values ('testc', '/2-insert-testz//c/cd/');
insert into test_zkinsert (name, value, path) values ('testb', 'z', '/2-insert-testx');
drop table if exists test_zkinsert;
