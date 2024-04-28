create table a (id int , primary key (id));;
create table b (id int , foreign_a int, foreign key (foreign_a) references a);;
insert into a (id) values (0);;
insert into b (id, foreign_a) VALUES (0, 0);;
SELECT * FROM pg_constraint

statement ok
create table a (id int , primary key (id));

statement ok
create table b (id int , foreign_a int, foreign key (foreign_a) references a);

statement ok
insert into a (id) values (0);

statement ok
insert into b (id, foreign_a) VALUES (0, 0);

query IIIIIIIIIIIIIIIIIIIIII
SELECT * EXCLUDE (OID, CONRELID, connamespace) FROM pg_catalog.pg_constraint;
