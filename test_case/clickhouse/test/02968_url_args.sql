show create a;
create table b (x Int64) engine URL('https://example.com/', CSV, headers());
show create b;
create view e (x Int64) as select count() from url('https://example.com/', CSV, headers('foo' = 'bar', 'a' = '13'));
show create e;
create view f (x Int64) as select count() from url('https://example.com/', CSV, headers());
show create f;
