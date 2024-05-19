CREATE TEMP TABLE x (
	a serial,
	b int,
	c text not null default 'stuff',
	d text,
	e text
) ;

CREATE FUNCTION fn_x_before () RETURNS TRIGGER AS '
  BEGIN
		NEW.e := ''before trigger fired''::text;
		return NEW;
	END;
' LANGUAGE plpgsql;

CREATE FUNCTION fn_x_after () RETURNS TRIGGER AS '
  BEGIN
		UPDATE x set e=''after trigger fired'' where c=''stuff'';
		return NULL;
	END;
' LANGUAGE plpgsql;

CREATE TRIGGER trg_x_after AFTER INSERT ON x
FOR EACH ROW EXECUTE PROCEDURE fn_x_after();

CREATE TRIGGER trg_x_before BEFORE INSERT ON x
FOR EACH ROW EXECUTE PROCEDURE fn_x_before();

COPY x (a, b, c, d, e) from stdin;
9999	\N	\\N	\NN	\N
10000	21	31	41	51

COPY x (b, d) from stdin;
1	test_1

COPY x (b, d) from stdin;
2	test_2
3	test_3
4	test_4
5	test_5

COPY x (a, b, c, d, e) from stdin;
10001	22	32	42	52
10002	23	33	43	53
10003	24	34	44	54
10004	25	35	45	55
10005	26	36	46	56

COPY x (xyz) from stdin;

COPY x from stdin (format CSV, FORMAT CSV);
COPY x from stdin (freeze off, freeze on);
COPY x from stdin (delimiter ',', delimiter ',');
COPY x from stdin (null ' ', null ' ');
COPY x from stdin (header off, header on);
COPY x from stdin (quote ':', quote ':');
COPY x from stdin (escape ':', escape ':');
COPY x from stdin (force_quote (a), force_quote *);
COPY x from stdin (force_not_null (a), force_not_null (b));
COPY x from stdin (force_null (a), force_null (b));
COPY x from stdin (convert_selectively (a), convert_selectively (b));
COPY x from stdin (encoding 'sql_ascii', encoding 'sql_ascii');
COPY x from stdin (on_error ignore, on_error ignore);

COPY x to stdin (format BINARY, delimiter ',');
COPY x to stdin (format BINARY, null 'x');
COPY x from stdin (format BINARY, on_error ignore);
COPY x from stdin (on_error unsupported);
COPY x to stdin (format TEXT, force_quote(a));
COPY x from stdin (format CSV, force_quote(a));
COPY x to stdout (format TEXT, force_not_null(a));
COPY x to stdin (format CSV, force_not_null(a));
COPY x to stdout (format TEXT, force_null(a));
COPY x to stdin (format CSV, force_null(a));
COPY x to stdin (format BINARY, on_error unsupported);

COPY x (a, b, c, d, e, d, c) from stdin;

COPY x from stdin;

COPY x from stdin;
2000	230	23	23
COPY x from stdin;
2001	231	\N	\N

COPY x from stdin;
2002	232	40	50	60	70	80

COPY x (b, c, d, e) from stdin delimiter ',' null 'x';
x,45,80,90
x,\x,\\x,\\\x
x,\,,\\\,,\\

COPY x from stdin WITH DELIMITER AS ';' NULL AS '';
3000;;c;;

COPY x from stdin WITH DELIMITER AS ':' NULL AS E'\\X' ENCODING 'sql_ascii';
4000:\X:C:\X:\X
4001:1:empty::
4002:2:null:\X:\X
4003:3:Backslash:\\:\\
4004:4:BackslashX:\\X:\\X
4005:5:N:\N:\N
4006:6:BackslashN:\\N:\\N
4007:7:XX:\XX:\XX
4008:8:Delimiter:\::\:

COPY x TO stdout WHERE a = 1;
COPY x from stdin WHERE a = 50004;
50003	24	34	44	54
50004	25	35	45	55
50005	26	36	46	56

COPY x from stdin WHERE a > 60003;
60001	22	32	42	52
60002	23	33	43	53
60003	24	34	44	54
60004	25	35	45	55
60005	26	36	46	56

COPY x from stdin WHERE f > 60003;

COPY x from stdin WHERE a = max(x.b);

COPY x from stdin WHERE a IN (SELECT 1 FROM x);

COPY x from stdin WHERE a IN (generate_series(1,5));

COPY x from stdin WHERE a = row_number() over(b);


SELECT * FROM x;

COPY x TO stdout;
COPY x (c, e) TO stdout;
COPY x (b, e) TO stdout WITH NULL 'I''m null';

CREATE TEMP TABLE y (
	col1 text,
	col2 text
);

INSERT INTO y VALUES ('Jackson, Sam', E'\\h');
INSERT INTO y VALUES ('It is "perfect".',E'\t');
INSERT INTO y VALUES ('', NULL);

COPY y TO stdout WITH CSV;
COPY y TO stdout WITH CSV QUOTE '''' DELIMITER '|';
COPY y TO stdout WITH CSV FORCE QUOTE col2 ESCAPE E'\\' ENCODING 'sql_ascii';
COPY y TO stdout WITH CSV FORCE QUOTE *;


COPY y TO stdout (FORMAT CSV);
COPY y TO stdout (FORMAT CSV, QUOTE '''', DELIMITER '|');
COPY y TO stdout (FORMAT CSV, FORCE_QUOTE (col2), ESCAPE E'\\');
COPY y TO stdout (FORMAT CSV, FORCE_QUOTE *);



CREATE TEMP TABLE testnl (a int, b text, c int);

COPY testnl FROM stdin CSV;
1,"a field with two LFs

inside",2

CREATE TEMP TABLE testeoc (a text);

COPY testeoc FROM stdin CSV;
a\.
c\.d
"\."

COPY testeoc TO stdout CSV;


CREATE TEMP TABLE testnull(a int, b text);
INSERT INTO testnull VALUES (1, E'\\0'), (NULL, NULL);

COPY testnull TO stdout WITH NULL AS E'\\0';

COPY testnull FROM stdin WITH NULL AS E'\\0';
42	\\0

SELECT * FROM testnull;

BEGIN;
CREATE TABLE vistest (LIKE testeoc);
COPY vistest FROM stdin CSV;
a0
b
COMMIT;
SELECT * FROM vistest;
BEGIN;
TRUNCATE vistest;
COPY vistest FROM stdin CSV;
a1
b
SELECT * FROM vistest;
SAVEPOINT s1;
TRUNCATE vistest;
COPY vistest FROM stdin CSV;
d1
e
SELECT * FROM vistest;
COMMIT;
SELECT * FROM vistest;

BEGIN;
TRUNCATE vistest;
COPY vistest FROM stdin CSV FREEZE;
a2
b
SELECT * FROM vistest;
SAVEPOINT s1;
TRUNCATE vistest;
COPY vistest FROM stdin CSV FREEZE;
d2
e
SELECT * FROM vistest;
COMMIT;
SELECT * FROM vistest;

BEGIN;
TRUNCATE vistest;
COPY vistest FROM stdin CSV FREEZE;
x
y
SELECT * FROM vistest;
COMMIT;
TRUNCATE vistest;
COPY vistest FROM stdin CSV FREEZE;
p
g
BEGIN;
TRUNCATE vistest;
SAVEPOINT s1;
COPY vistest FROM stdin CSV FREEZE;
m
k
COMMIT;
BEGIN;
INSERT INTO vistest VALUES ('z');
SAVEPOINT s1;
TRUNCATE vistest;
ROLLBACK TO SAVEPOINT s1;
COPY vistest FROM stdin CSV FREEZE;
d3
e
COMMIT;
CREATE FUNCTION truncate_in_subxact() RETURNS VOID AS
$$
BEGIN
	TRUNCATE vistest;
EXCEPTION
  WHEN OTHERS THEN
	INSERT INTO vistest VALUES ('subxact failure');
END;
$$ language plpgsql;
BEGIN;
INSERT INTO vistest VALUES ('z');
SELECT truncate_in_subxact();
COPY vistest FROM stdin CSV FREEZE;
d4
e
SELECT * FROM vistest;
COMMIT;
SELECT * FROM vistest;
CREATE TEMP TABLE forcetest (
    a INT NOT NULL,
    b TEXT NOT NULL,
    c TEXT,
    d TEXT,
    e TEXT
);
BEGIN;
COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL(b), FORCE_NULL(c));
1,,""
COMMIT;
SELECT b, c FROM forcetest WHERE a = 1;
BEGIN;
COPY forcetest (a, b, c, d) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL(c,d), FORCE_NULL(c,d));
2,'a',,""
COMMIT;
SELECT c, d FROM forcetest WHERE a = 2;
BEGIN;
COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NULL(b), FORCE_NOT_NULL(c));
3,,""
ROLLBACK;
BEGIN;
COPY forcetest (d, e) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL(b));
ROLLBACK;
BEGIN;
COPY forcetest (d, e) FROM STDIN WITH (FORMAT csv, FORCE_NULL(b));
ROLLBACK;
BEGIN;
COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL *, FORCE_NULL *);
4,,""
COMMIT;
SELECT b, c FROM forcetest WHERE a = 4;
BEGIN;
COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL *);
5,,""
COMMIT;
SELECT b, c FROM forcetest WHERE a = 5;
BEGIN;
COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NULL *);
6,"b",""
COMMIT;
SELECT b, c FROM forcetest WHERE a = 6;
BEGIN;
COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NOT_NULL *, FORCE_NOT_NULL(b));
ROLLBACK;
BEGIN;
COPY forcetest (a, b, c) FROM STDIN WITH (FORMAT csv, FORCE_NULL *, FORCE_NULL(b));
ROLLBACK;


create table check_con_tbl (f1 int);
create function check_con_function(check_con_tbl) returns bool as $$
begin
  raise notice 'input = %', row_to_json($1);
  return $1.f1 > 0;
end $$ language plpgsql immutable;
alter table check_con_tbl add check (check_con_function(check_con_tbl.*));
copy check_con_tbl from stdin;
1
copy check_con_tbl from stdin;
0
select * from check_con_tbl;

CREATE ROLE regress_rls_copy_user;
CREATE ROLE regress_rls_copy_user_colperms;
CREATE TABLE rls_t1 (a int, b int, c int);

COPY rls_t1 (a, b, c) from stdin;
1	4	1
2	3	2
3	2	3
4	1	4

CREATE POLICY p1 ON rls_t1 FOR SELECT USING (a % 2 = 0);
ALTER TABLE rls_t1 ENABLE ROW LEVEL SECURITY;
ALTER TABLE rls_t1 FORCE ROW LEVEL SECURITY;

GRANT SELECT ON TABLE rls_t1 TO regress_rls_copy_user;
GRANT SELECT (a, b) ON TABLE rls_t1 TO regress_rls_copy_user_colperms;

COPY rls_t1 TO stdout;
COPY rls_t1 (a, b, c) TO stdout;

COPY rls_t1 (a) TO stdout;
COPY rls_t1 (a, b) TO stdout;

COPY rls_t1 (b, a) TO stdout;

SET SESSION AUTHORIZATION regress_rls_copy_user;

COPY rls_t1 TO stdout;
COPY rls_t1 (a, b, c) TO stdout;

COPY rls_t1 (a) TO stdout;
COPY rls_t1 (a, b) TO stdout;

COPY rls_t1 (b, a) TO stdout;

RESET SESSION AUTHORIZATION;

SET SESSION AUTHORIZATION regress_rls_copy_user_colperms;

COPY rls_t1 TO stdout;
COPY rls_t1 (a, b, c) TO stdout;

COPY rls_t1 (c) TO stdout;

COPY rls_t1 (a) TO stdout;
COPY rls_t1 (a, b) TO stdout;

RESET SESSION AUTHORIZATION;

CREATE TABLE instead_of_insert_tbl(id serial, name text);
CREATE VIEW instead_of_insert_tbl_view AS SELECT ''::text AS str;

COPY instead_of_insert_tbl_view FROM stdin; 
test1

CREATE FUNCTION fun_instead_of_insert_tbl() RETURNS trigger AS $$
BEGIN
  INSERT INTO instead_of_insert_tbl (name) VALUES (NEW.str);
  RETURN NULL;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER trig_instead_of_insert_tbl_view
  INSTEAD OF INSERT ON instead_of_insert_tbl_view
  FOR EACH ROW EXECUTE PROCEDURE fun_instead_of_insert_tbl();

COPY instead_of_insert_tbl_view FROM stdin;
test1

SELECT * FROM instead_of_insert_tbl;

BEGIN;
CREATE VIEW instead_of_insert_tbl_view_2 as select ''::text as str;
CREATE TRIGGER trig_instead_of_insert_tbl_view_2
  INSTEAD OF INSERT ON instead_of_insert_tbl_view_2
  FOR EACH ROW EXECUTE PROCEDURE fun_instead_of_insert_tbl();

COPY instead_of_insert_tbl_view_2 FROM stdin;
test1

SELECT * FROM instead_of_insert_tbl;
COMMIT;

CREATE TABLE check_ign_err (n int, m int[], k int);
COPY check_ign_err FROM STDIN WITH (on_error stop);
1	{1}	1
a	{2}	2
3	{3}	3333333333
4	{a, 4}	4

5	{5}	5
COPY check_ign_err FROM STDIN WITH (on_error ignore);
1	{1}	1
a	{2}	2
3	{3}	3333333333
4	{a, 4}	4

5	{5}	5
6	a
7	{7}	a
8	{8}	8
SELECT * FROM check_ign_err;

CREATE TABLE hard_err(foo widget);
COPY hard_err FROM STDIN WITH (on_error ignore);
1

COPY check_ign_err FROM STDIN WITH (on_error ignore);
1	{1}

COPY check_ign_err FROM STDIN WITH (on_error ignore);
1	{1}	3	abc

DROP TABLE forcetest;
DROP TABLE vistest;
DROP FUNCTION truncate_in_subxact();
DROP TABLE x, y;
DROP TABLE rls_t1 CASCADE;
DROP ROLE regress_rls_copy_user;
DROP ROLE regress_rls_copy_user_colperms;
DROP FUNCTION fn_x_before();
DROP FUNCTION fn_x_after();
DROP TABLE instead_of_insert_tbl;
DROP VIEW instead_of_insert_tbl_view;
DROP VIEW instead_of_insert_tbl_view_2;
DROP FUNCTION fun_instead_of_insert_tbl();
DROP TABLE check_ign_err;
DROP TABLE hard_err;


create temp table copy_default (
	id integer primary key,
	text_value text not null default 'test',
	ts_value timestamp without time zone not null default '2022-07-05'
);

copy copy_default from stdin;
1	value	'2022-07-04'
2	\D	'2022-07-05'

select id, text_value, ts_value from copy_default;

truncate copy_default;

copy copy_default from stdin with (format csv);
1,value,2022-07-04
2,\D,2022-07-05

select id, text_value, ts_value from copy_default;

truncate copy_default;

copy copy_default from stdin with (format binary, default '\D');

copy copy_default from stdin with (default E'\n');
copy copy_default from stdin with (default E'\r');

copy copy_default from stdin with (delimiter ';', default 'test;test');

copy copy_default from stdin with (format csv, quote '"', default 'test"test');

copy copy_default from stdin with (default '\N');

copy copy_default from stdin with (default '\D');
2	\D	'2022-07-05'

copy copy_default from stdin with (format csv, default '\D');
2,\D,2022-07-05

copy copy_default from stdin with (default '\D');
1	\D	'2022-07-04'
2	\\D	'2022-07-04'
3	"\D"	'2022-07-04'

select id, text_value, ts_value from copy_default;

truncate copy_default;

copy copy_default from stdin with (format csv, default '\D');
1,\D,2022-07-04
2,\\D,2022-07-04
3,"\D",2022-07-04

select id, text_value, ts_value from copy_default;

truncate copy_default;

copy copy_default from stdin with (default '\D');
1	value	'2022-07-04'
2	\D	'2022-07-03'
3	\D	\D

select id, text_value, ts_value from copy_default;

truncate copy_default;

copy copy_default from stdin with (format csv, default '\D');
1,value,2022-07-04
2,\D,2022-07-03
3,\D,\D

select id, text_value, ts_value from copy_default;

truncate copy_default;

copy (select 1 as test) TO stdout with (default '\D');
