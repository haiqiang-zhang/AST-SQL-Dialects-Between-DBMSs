CREATE DOMAIN sqljsonb_int_not_null AS int NOT NULL;
CREATE TYPE rainbow AS ENUM ('red', 'orange', 'yellow', 'green', 'blue', 'purple');
CREATE DOMAIN rgb AS rainbow CHECK (VALUE IN ('red', 'green', 'blue'));
CREATE TYPE comp_abc AS (a text, b int, c timestamp);
DROP TYPE comp_abc;
CREATE TYPE sqljsonb_rec AS (a int, t text, js json, jb jsonb, jsa json[]);
CREATE TYPE sqljsonb_reca AS (reca sqljsonb_rec[]);
SELECT check_clause
FROM information_schema.check_constraints
WHERE constraint_name LIKE 'test_jsonb_constraint%'
ORDER BY 1;
CREATE TABLE test_jsonb_mutability(js jsonb, b int);
CREATE OR REPLACE FUNCTION ret_setint() RETURNS SETOF integer AS
$$
BEGIN
    RETURN QUERY EXECUTE 'select 1 union all select 1';
END;
$$
LANGUAGE plpgsql IMMUTABLE;
DROP TABLE test_jsonb_mutability;
DROP FUNCTION ret_setint;
CREATE TEMP TABLE jsonpaths (path) AS SELECT '$';
