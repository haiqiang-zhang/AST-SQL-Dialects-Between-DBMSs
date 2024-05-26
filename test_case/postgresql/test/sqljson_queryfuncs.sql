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
