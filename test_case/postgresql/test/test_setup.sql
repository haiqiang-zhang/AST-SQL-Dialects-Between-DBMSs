SET synchronous_commit = on;
GRANT ALL ON SCHEMA public TO public;
CREATE TABLE CHAR_TBL(f1 char(4));
INSERT INTO CHAR_TBL (f1) VALUES
  ('a'),
  ('ab'),
  ('abcd'),
  ('abcd    ');
VACUUM CHAR_TBL;
CREATE TABLE FLOAT8_TBL(f1 float8);
INSERT INTO FLOAT8_TBL(f1) VALUES
  ('0.0'),
  ('-34.84'),
  ('-1004.30'),
  ('-1.2345678901234e+200'),
  ('-1.2345678901234e-200');
VACUUM FLOAT8_TBL;
CREATE TABLE INT2_TBL(f1 int2);
INSERT INTO INT2_TBL(f1) VALUES
  ('0   '),
  ('  1234 '),
  ('    -1234'),
  ('32767'),  
  ('-32767');
VACUUM INT2_TBL;
CREATE TABLE INT4_TBL(f1 int4);
INSERT INTO INT4_TBL(f1) VALUES
  ('   0  '),
  ('123456     '),
  ('    -123456'),
  ('2147483647'),  
  ('-2147483647');
VACUUM INT4_TBL;
CREATE TABLE INT8_TBL(q1 int8, q2 int8);
INSERT INTO INT8_TBL VALUES
  ('  123   ','  456'),
  ('123   ','4567890123456789'),
  ('4567890123456789','123'),
  (+4567890123456789,'4567890123456789'),
  ('+4567890123456789','-4567890123456789');
VACUUM INT8_TBL;
CREATE TABLE POINT_TBL(f1 point);
INSERT INTO POINT_TBL(f1) VALUES
  ('(0.0,0.0)'),
  ('(-10.0,0.0)'),
  ('(-3.0,4.0)'),
  ('(5.1, 34.5)'),
  ('(-5.0,-12.0)'),
  ('(1e-300,-1e-300)'),  
  ('(1e+300,Inf)'),  
  ('(Inf,1e+300)'),  
  (' ( Nan , NaN ) '),
  ('10.0,10.0');
CREATE TABLE TEXT_TBL (f1 text);
INSERT INTO TEXT_TBL VALUES
  ('doh!'),
  ('hi de ho neighbor');
VACUUM TEXT_TBL;
CREATE TABLE VARCHAR_TBL(f1 varchar(4));
INSERT INTO VARCHAR_TBL (f1) VALUES
  ('a'),
  ('ab'),
  ('abcd'),
  ('abcd    ');
VACUUM VARCHAR_TBL;
CREATE TABLE onek (
	unique1		int4,
	unique2		int4,
	two			int4,
	four		int4,
	ten			int4,
	twenty		int4,
	hundred		int4,
	thousand	int4,
	twothousand	int4,
	fivethous	int4,
	tenthous	int4,
	odd			int4,
	even		int4,
	stringu1	name,
	stringu2	name,
	string4		name
);
VACUUM ANALYZE onek;
CREATE TABLE onek2 AS SELECT * FROM onek;
VACUUM ANALYZE onek2;
CREATE TABLE tenk1 (
	unique1		int4,
	unique2		int4,
	two			int4,
	four		int4,
	ten			int4,
	twenty		int4,
	hundred		int4,
	thousand	int4,
	twothousand	int4,
	fivethous	int4,
	tenthous	int4,
	odd			int4,
	even		int4,
	stringu1	name,
	stringu2	name,
	string4		name
);
VACUUM ANALYZE tenk1;
CREATE TABLE tenk2 AS SELECT * FROM tenk1;
VACUUM ANALYZE tenk2;
CREATE TABLE person (
	name 		text,
	age			int4,
	location 	point
);
VACUUM ANALYZE person;
CREATE TABLE emp (
	salary 		int4,
	manager 	name
) INHERITS (person);
VACUUM ANALYZE emp;
CREATE TABLE student (
	gpa 		float8
) INHERITS (person);
VACUUM ANALYZE student;
CREATE TABLE stud_emp (
	percent 	int4
) INHERITS (emp, student);
VACUUM ANALYZE stud_emp;
CREATE TABLE road (
	name		text,
	thepath 	path
);
VACUUM ANALYZE road;
CREATE TABLE ihighway () INHERITS (road);
INSERT INTO ihighway
   SELECT *
   FROM ONLY road
   WHERE name ~ 'I- .*';
VACUUM ANALYZE ihighway;
CREATE TABLE shighway (
	surface		text
) INHERITS (road);
INSERT INTO shighway
   SELECT *, 'asphalt'
   FROM ONLY road
   WHERE name ~ 'State Hwy.*';
VACUUM ANALYZE shighway;
create type stoplight as enum ('red', 'yellow', 'green');
create type float8range as range (subtype = float8, subtype_diff = float8mi);
create type textrange as range (subtype = text, collation = "C");
create function part_hashtext_length(value text, seed int8)
    returns int8 as $$
    select length(coalesce(value, ''))::int8
    $$ language sql strict immutable parallel safe;
