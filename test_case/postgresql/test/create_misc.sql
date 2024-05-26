ANALYZE a_star;
ANALYZE b_star;
ANALYZE c_star;
ANALYZE d_star;
ANALYZE e_star;
ANALYZE f_star;
SELECT * FROM a_star*;
SELECT *
   FROM b_star* x
   WHERE x.b = text 'bumble' or x.a < 3;
SELECT class, a
   FROM c_star* x
   WHERE x.c ~ text 'hi';
SELECT class, b, c
   FROM d_star* x
   WHERE x.a < 100;
SELECT class, c FROM e_star* x WHERE x.c NOTNULL;
SELECT * FROM f_star* x WHERE x.c ISNULL;
SELECT sum(a) FROM a_star*;
ALTER TABLE f_star RENAME COLUMN f TO ff;
ALTER TABLE e_star* RENAME COLUMN e TO ee;
ALTER TABLE d_star* RENAME COLUMN d TO dd;
ALTER TABLE c_star* RENAME COLUMN c TO cc;
ALTER TABLE b_star* RENAME COLUMN b TO bb;
ALTER TABLE a_star* RENAME COLUMN a TO aa;
SELECT class, aa
   FROM a_star* x
   WHERE aa ISNULL;
ALTER TABLE a_star RENAME COLUMN aa TO foo;
SELECT class, foo
   FROM a_star* x
   WHERE x.foo >= 2;
ALTER TABLE a_star RENAME COLUMN foo TO aa;
SELECT *
   from a_star*
   WHERE aa < 1000;
ALTER TABLE f_star ADD COLUMN f int4;
UPDATE f_star SET f = 10;
ALTER TABLE e_star* ADD COLUMN e int4;
SELECT * FROM e_star*;
ALTER TABLE a_star* ADD COLUMN a text;
SELECT relname, reltoastrelid <> 0 AS has_toast_table
   FROM pg_class
   WHERE oid::regclass IN ('a_star', 'c_star')
   ORDER BY 1;
SELECT class, aa, a FROM a_star*;
