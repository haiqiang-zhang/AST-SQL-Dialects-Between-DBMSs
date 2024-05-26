SELECT * FROM cp_test ORDER BY b COLLATE "C";
END;
SELECT * FROM cp_test ORDER BY b COLLATE "C";
END;
TRUNCATE cp_test;
SELECT * FROM cp_test;
TRUNCATE cp_test;
SELECT * FROM cp_test;
CREATE PROCEDURE ptest8(x text)
BEGIN ATOMIC
END;
SELECT pg_get_functiondef('ptest8'::regproc);
CALL ptest8('');
SELECT 1;
CREATE PROCEDURE ptest10(OUT a int, IN b int, IN c int)
LANGUAGE SQL AS $$ SELECT b - c $$;
CALL ptest10(null, 7, 4);
CREATE PROCEDURE ptest11(a OUT int, VARIADIC b int[]) LANGUAGE SQL
  AS $$ SELECT b[1] + b[2] $$;
CALL ptest11(null, 11, 12, 13);
CREATE PROCEDURE ptest10(IN a int, IN b int, IN c int)
LANGUAGE SQL AS $$ SELECT a + b - c $$;
begin;
drop procedure ptest10(out int, int, int);
drop procedure ptest10(int, int, int);
rollback;
begin;
drop procedure ptest10(in int, int, int);
drop procedure ptest10(int, int, int);
rollback;
RESET ROLE;
RESET ROLE;
ALTER ROUTINE cp_testfunc1(int) RENAME TO cp_testfunc1a;
ALTER ROUTINE cp_testfunc1a RENAME TO cp_testfunc1;
DROP ROUTINE cp_testfunc1(int);
DROP TABLE cp_test;
