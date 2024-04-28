CREATE TABLE integers(i INTEGER);;
create table tconstraint1(i integer primary key default(3), j blob not null);;
create table tconstraint2(i integer, j integer, k integer, l integer unique, primary key(i, j, k));;
CREATE INDEX i_index ON integers(i);;
CREATE VIEW v1 AS SELECT 42;
SELECT * FROM sqlite_master;;
SELECT EXISTS(SELECT * FROM sqlite_master);
SELECT EXISTS(SELECT * FROM sqlite_master OFFSET 1);
SELECT COUNT(*) FROM sqlite_master WHERE name='test';
SELECT COUNT(*) FROM sqlite_master WHERE name='integers';
SELECT * FROM sqlite_master WHERE name='tconstraint1';;
SELECT * FROM sqlite_master WHERE name='tconstraint2';;
SELECT * REPLACE (trim(sql, chr(10)) as sql) FROM sqlite_master WHERE name='i_index';;
SELECT "type", "name", "tbl_name", rootpage FROM sqlite_master WHERE name='v1';;
