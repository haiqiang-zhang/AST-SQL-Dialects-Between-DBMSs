PRAGMA enable_verification;
create table a(i integer);
insert into a values (42), (44);
create table b(rowid integer);
insert into b values (42), (22);
UPDATE b SET rowid=5;
INSERT INTO b (rowid) VALUES (5);
