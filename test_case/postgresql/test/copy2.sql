SELECT * FROM x;
CREATE TEMP TABLE y (
	col1 text,
	col2 text
);
INSERT INTO y VALUES ('Jackson, Sam', E'\\h');
INSERT INTO y VALUES ('It is "perfect".',E'\t');
INSERT INTO y VALUES ('', NULL);
CREATE TEMP TABLE testnl (a int, b text, c int);
CREATE TEMP TABLE testnull(a int, b text);
INSERT INTO testnull VALUES (1, E'\\0'), (NULL, NULL);
BEGIN;
COMMIT;
BEGIN;
COMMIT;
BEGIN;
COMMIT;
BEGIN;
END;
BEGIN;
COMMIT;
CREATE TEMP TABLE forcetest (
    a INT NOT NULL,
    b TEXT NOT NULL,
    c TEXT,
    d TEXT,
    e TEXT
);
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
BEGIN;
ROLLBACK;
create table check_con_tbl (f1 int);
create function check_con_function(check_con_tbl) returns bool as $$
begin
  raise notice 'input = %', row_to_json($1);
  return $1.f1 > 0;
end $$ language plpgsql immutable;
alter table check_con_tbl add check (check_con_function(check_con_tbl.*));
CREATE TABLE rls_t1 (a int, b int, c int);
ALTER TABLE rls_t1 ENABLE ROW LEVEL SECURITY;
ALTER TABLE rls_t1 FORCE ROW LEVEL SECURITY;
RESET SESSION AUTHORIZATION;
RESET SESSION AUTHORIZATION;
CREATE TABLE instead_of_insert_tbl(id serial, name text);
CREATE VIEW instead_of_insert_tbl_view AS SELECT ''::text AS str;
BEGIN;
CREATE VIEW instead_of_insert_tbl_view_2 as select ''::text as str;
COMMIT;
CREATE TABLE check_ign_err (n int, m int[], k int);
DROP TABLE x, y;
DROP TABLE rls_t1 CASCADE;
DROP TABLE instead_of_insert_tbl;
DROP VIEW instead_of_insert_tbl_view;
DROP TABLE check_ign_err;
create temp table copy_default (
	id integer primary key,
	text_value text not null default 'test',
	ts_value timestamp without time zone not null default '2022-07-05'
);
truncate copy_default;
truncate copy_default;
truncate copy_default;
truncate copy_default;
truncate copy_default;
truncate copy_default;
