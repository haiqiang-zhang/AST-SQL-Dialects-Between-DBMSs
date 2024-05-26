PRAGMA enable_verification;
CREATE SCHEMA s;
create table s.a as select 'hello' as col1;
create view s.b as select * from s.a;
