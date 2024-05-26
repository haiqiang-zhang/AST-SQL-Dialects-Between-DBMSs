CREATE TABLE deptest (f1 serial primary key, f2 text);
DROP TABLE deptest;
CREATE TABLE deptest1 (f1 int unique);
CREATE TABLE deptest (a serial primary key, b text);
RESET SESSION AUTHORIZATION;
CREATE SCHEMA deptest;
CREATE FUNCTION deptest_func() RETURNS void LANGUAGE plpgsql
  AS $$ BEGIN END; $$;
CREATE TYPE deptest_enum AS ENUM ('red');
CREATE TYPE deptest_range AS RANGE (SUBTYPE = int4);
CREATE TABLE deptest2 (f1 int);
CREATE SEQUENCE ss1;
ALTER TABLE deptest2 ALTER f1 SET DEFAULT nextval('ss1');
ALTER SEQUENCE ss1 OWNED BY deptest2.f1;
CREATE TYPE deptest_t AS (a int);
