CREATE TABLE integers(i INTEGER);
create table tconstraint1(i integer primary key default(3), j blob not null);
create table tconstraint2(i integer, j integer, k integer, l integer unique, primary key(i, j, k));
CREATE INDEX i_index ON integers(i);
CREATE VIEW v1 AS SELECT 42;
