CREATE FUNCTION cp_testfunc1(a int) RETURNS int LANGUAGE SQL AS $$ SELECT a $$;
CREATE TABLE cp_test (a int, b text);
