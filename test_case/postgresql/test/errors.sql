
select 1;





select;

select * from nonesuch;

select nonesuch from pg_database;

select distinct from pg_database;

select * from pg_database where nonesuch = pg_database.datname;

select * from pg_database where pg_database.datname = nonesuch;

select distinct on (foobar) * from pg_database;

select null from pg_database group by datname for update;
select null from pg_database group by grouping sets (()) for update;



delete from;

delete from nonesuch;



drop table;

drop table nonesuch;




alter table rename;

alter table nonesuch rename to newnonesuch;

alter table nonesuch rename to stud_emp;

alter table stud_emp rename to student;

alter table stud_emp rename to stud_emp;



alter table nonesuchrel rename column nonesuchatt to newnonesuchatt;

alter table emp rename column nonesuchatt to newnonesuchatt;

alter table emp rename column salary to manager;

alter table emp rename column salary to ctid;



abort;

end;



create aggregate newavg2 (sfunc = int4pl,
			  basetype = int4,
			  stype = int4,
			  finalfunc = int2um,
			  initcond = '0');

create aggregate newcnt1 (sfunc = int4inc,
			  stype = int4,
			  initcond = '0');



drop index;

drop index 314159;

drop index nonesuch;



drop aggregate;

drop aggregate newcnt1;

drop aggregate 314159 (int);

drop aggregate newcnt (nonesuch);

drop aggregate nonesuch (int4);

drop aggregate newcnt (float4);



drop function ();

drop function 314159();

drop function nonesuch();



drop type;

drop type 314159;

drop type nonesuch;



drop operator;

drop operator equals;

drop operator ===;

drop operator int4, int4;

drop operator (int4, int4);

drop operator === ();

drop operator === (int4);

drop operator === (int4, int4);

drop operator = (nonesuch);

drop operator = ( , int4);

drop operator = (nonesuch, int4);

drop operator = (int4, nonesuch);

drop operator = (int4, );



drop rule;

drop rule 314159;

drop rule nonesuch on noplace;

drop tuple rule nonesuch;
drop instance rule nonesuch on noplace;
drop rewrite rule nonesuch;


select 1/0;

select 1::int8/0;

select 1/0::int8;

select 1::int2/0;

select 1/0::int2;

select 1::numeric/0;

select 1/0::numeric;

select 1::float8/0;

select 1/0::float8;

select 1::float4/0;

select 1/0::float4;



xxx;

CREATE foo;

CREATE TABLE ;

CREATE TABLE

INSERT INTO foo VALUES(123) foo;

INSERT INTO 123
VALUES(123);

INSERT INTO foo
VALUES(123) 123
;

CREATE TABLE foo
  (id INT4 UNIQUE NOT NULL, id2 TEXT NOT NULL PRIMARY KEY,
	id3 INTEGER NOT NUL,
   id4 INT4 UNIQUE NOT NULL, id5 TEXT UNIQUE NOT NULL);

CREATE TABLE foo(id INT4 UNIQUE NOT NULL, id2 TEXT NOT NULL PRIMARY KEY, id3 INTEGER NOT NUL,
id4 INT4 UNIQUE NOT NULL, id5 TEXT UNIQUE NOT NULL);

CREATE TABLE foo(
id3 INTEGER NOT NUL, id4 INT4 UNIQUE NOT NULL, id5 TEXT UNIQUE NOT NULL, id INT4 UNIQUE NOT NULL, id2 TEXT NOT NULL PRIMARY KEY);

CREATE TABLE foo(id INT4 UNIQUE NOT NULL, id2 TEXT NOT NULL PRIMARY KEY, id3 INTEGER NOT NUL, id4 INT4 UNIQUE NOT NULL, id5 TEXT UNIQUE NOT NULL);

CREATE
TEMPORARY
TABLE
foo(id INT4 UNIQUE NOT NULL, id2 TEXT NOT NULL PRIMARY KEY, id3 INTEGER NOT NUL,
id4 INT4
UNIQUE
NOT
NULL,
id5 TEXT
UNIQUE
NOT
NULL)
;

CREATE
TEMPORARY
TABLE
foo(
id3 INTEGER NOT NUL, id4 INT4 UNIQUE NOT NULL, id5 TEXT UNIQUE NOT NULL, id INT4 UNIQUE NOT NULL, id2 TEXT NOT NULL PRIMARY KEY)
;

CREATE
TEMPORARY
TABLE
foo
(id
INT4
UNIQUE NOT NULL, idx INT4 UNIQUE NOT NULL, idy INT4 UNIQUE NOT NULL, id2 TEXT NOT NULL PRIMARY KEY, id3 INTEGER NOT NUL, id4 INT4 UNIQUE NOT NULL, id5 TEXT UNIQUE NOT NULL,
idz INT4 UNIQUE NOT NULL,
idv INT4 UNIQUE NOT NULL);

CREATE
TEMPORARY
TABLE
foo
(id
INT4
UNIQUE
NOT
NULL
,
idm
INT4
UNIQUE
NOT
NULL,
idx INT4 UNIQUE NOT NULL, idy INT4 UNIQUE NOT NULL, id2 TEXT NOT NULL PRIMARY KEY, id3 INTEGER NOT NUL, id4 INT4 UNIQUE NOT NULL, id5 TEXT UNIQUE NOT NULL,
idz INT4 UNIQUE NOT NULL,
idv
INT4
UNIQUE
NOT
NULL);
