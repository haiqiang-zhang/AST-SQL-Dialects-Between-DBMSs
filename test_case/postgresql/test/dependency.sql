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
SELECT typowner = relowner
FROM pg_type JOIN pg_class c ON typrelid = c.oid WHERE typname = 'deptest_t';
RESET SESSION AUTHORIZATION;
SELECT typowner = relowner
FROM pg_type JOIN pg_class c ON typrelid = c.oid WHERE typname = 'deptest_t';
