PRAGMA enable_verification;
create table a(i integer);
insert into a values (42);
INSERT INTO a SELECT rowid FROM a;
UPDATE a SET i=rowid;
