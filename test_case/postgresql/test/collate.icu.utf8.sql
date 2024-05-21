CREATE SCHEMA collate_tests;
SET search_path = collate_tests;
CREATE TABLE collate_test1 (
    a int,
    b text COLLATE "en-x-icu" NOT NULL
);
CREATE TABLE collate_test_like (
    LIKE collate_test1
);
CREATE TABLE collate_test2 (
    a int,
    b text COLLATE "sv-x-icu"
);
CREATE TABLE collate_test3 (
    a int,
    b text COLLATE "C"
);
INSERT INTO collate_test1 VALUES (1, 'abc'), (2, 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤bc'), (3, 'bbc'), (4, 'ABC');
INSERT INTO collate_test2 SELECT * FROM collate_test1;
INSERT INTO collate_test3 SELECT * FROM collate_test1;
SELECT * FROM collate_test1 WHERE b >= 'bbc';
SELECT * FROM collate_test2 WHERE b >= 'bbc';
SELECT * FROM collate_test3 WHERE b >= 'bbc';
SELECT * FROM collate_test3 WHERE b >= 'BBC';
SELECT * FROM collate_test1 WHERE b COLLATE "C" >= 'bbc';
SELECT * FROM collate_test1 WHERE b >= 'bbc' COLLATE "C";
SELECT * FROM collate_test1 WHERE b COLLATE "C" >= 'bbc' COLLATE "C";
CREATE DOMAIN testdomain_sv AS text COLLATE "sv-x-icu";
CREATE TABLE collate_test4 (
    a int,
    b testdomain_sv
);
INSERT INTO collate_test4 SELECT * FROM collate_test1;
SELECT a, b FROM collate_test4 ORDER BY b;
CREATE TABLE collate_test5 (
    a int,
    b testdomain_sv COLLATE "en-x-icu"
);
INSERT INTO collate_test5 SELECT * FROM collate_test1;
SELECT a, b FROM collate_test5 ORDER BY b;
SELECT a, b FROM collate_test1 ORDER BY b;
SELECT a, b FROM collate_test2 ORDER BY b;
SELECT a, b FROM collate_test3 ORDER BY b;
SELECT a, b FROM collate_test1 ORDER BY b COLLATE "C";
SELECT * FROM collate_test1 ORDER BY b;
SELECT * FROM collate_test2 ORDER BY b;
SELECT * FROM collate_test3 ORDER BY b;
SELECT 'bbc' COLLATE "en-x-icu" > 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤bc' COLLATE "en-x-icu" AS "true";
SELECT 'bbc' COLLATE "sv-x-icu" > 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤bc' COLLATE "sv-x-icu" AS "false";
CREATE TABLE collate_test10 (
    a int,
    x text COLLATE "en-x-icu",
    y text COLLATE "tr-x-icu"
);
INSERT INTO collate_test10 VALUES (1, 'hij', 'hij'), (2, 'HIJ', 'HIJ');
SELECT a, lower(x), lower(y), upper(x), upper(y), initcap(x), initcap(y) FROM collate_test10;
SELECT a, lower(x COLLATE "C"), lower(y COLLATE "C") FROM collate_test10;
SELECT a, x, y FROM collate_test10 ORDER BY lower(y), a;
SELECT * FROM collate_test1 WHERE b LIKE 'abc';
SELECT * FROM collate_test1 WHERE b LIKE 'abc%';
SELECT * FROM collate_test1 WHERE b LIKE '%bc%';
SELECT * FROM collate_test1 WHERE b ILIKE 'abc';
SELECT * FROM collate_test1 WHERE b ILIKE 'abc%';
SELECT * FROM collate_test1 WHERE b ILIKE '%bc%';
SELECT 'TÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¼rkiye' COLLATE "en-x-icu" ILIKE '%KI%' AS "true";
SELECT 'TÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¼rkiye' COLLATE "tr-x-icu" ILIKE '%KI%' AS "false";
SELECT 'bÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ±t' ILIKE 'BIT' COLLATE "en-x-icu" AS "false";
SELECT 'bÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ±t' ILIKE 'BIT' COLLATE "tr-x-icu" AS "true";
SELECT relname FROM pg_class WHERE relname ILIKE 'abc%';
SELECT * FROM collate_test1 WHERE b ~ '^abc$';
SELECT * FROM collate_test1 WHERE b ~ '^abc';
SELECT * FROM collate_test1 WHERE b ~ 'bc';
SELECT * FROM collate_test1 WHERE b ~* '^abc$';
SELECT * FROM collate_test1 WHERE b ~* '^abc';
SELECT * FROM collate_test1 WHERE b ~* 'bc';
CREATE TABLE collate_test6 (
    a int,
    b text COLLATE "en-x-icu"
);
SELECT b,
       b ~ '^[[:alpha:]]+$' AS is_alpha,
       b ~ '^[[:upper:]]+$' AS is_upper,
       b ~ '^[[:lower:]]+$' AS is_lower,
       b ~ '^[[:digit:]]+$' AS is_digit,
       b ~ '^[[:alnum:]]+$' AS is_alnum,
       b ~ '^[[:graph:]]+$' AS is_graph,
       b ~ '^[[:print:]]+$' AS is_print,
       b ~ '^[[:punct:]]+$' AS is_punct,
       b ~ '^[[:space:]]+$' AS is_space
FROM collate_test6;
SELECT 'TÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¼rkiye' COLLATE "en-x-icu" ~* 'KI' AS "true";
SELECT 'TÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¼rkiye' COLLATE "tr-x-icu" ~* 'KI' AS "true";
SELECT 'bÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ±t' ~* 'BIT' COLLATE "en-x-icu" AS "false";
SELECT 'bÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ±t' ~* 'BIT' COLLATE "tr-x-icu" AS "false";
SELECT relname FROM pg_class WHERE relname ~* '^abc';
SELECT to_char(date '2010-04-01', 'DD TMMON YYYY');
SELECT to_char(date '2010-04-01', 'DD TMMON YYYY' COLLATE "tr-x-icu");
CREATE VIEW collview2 AS SELECT a, b FROM collate_test1 ORDER BY b COLLATE "C";
CREATE VIEW collview3 AS SELECT a, lower((x || x) COLLATE "C") FROM collate_test10;
SELECT table_name, view_definition FROM information_schema.views
  WHERE table_name LIKE 'collview%' ORDER BY 1;
SELECT a, coalesce(b, 'foo') FROM collate_test1 ORDER BY 2;
SELECT a, coalesce(b, 'foo') FROM collate_test2 ORDER BY 2;
SELECT a, coalesce(b, 'foo') FROM collate_test3 ORDER BY 2;
SELECT a, lower(coalesce(x, 'foo')), lower(coalesce(y, 'foo')) FROM collate_test10;
SELECT a, b, greatest(b, 'CCC') FROM collate_test1 ORDER BY 3;
SELECT a, b, greatest(b, 'CCC') FROM collate_test2 ORDER BY 3;
SELECT a, b, greatest(b, 'CCC') FROM collate_test3 ORDER BY 3;
SELECT a, x, y, lower(greatest(x, 'foo')), lower(greatest(y, 'foo')) FROM collate_test10;
SELECT a, nullif(b, 'abc') FROM collate_test1 ORDER BY 2;
SELECT a, nullif(b, 'abc') FROM collate_test2 ORDER BY 2;
SELECT a, nullif(b, 'abc') FROM collate_test3 ORDER BY 2;
SELECT a, lower(nullif(x, 'foo')), lower(nullif(y, 'foo')) FROM collate_test10;
SELECT a, CASE b WHEN 'abc' THEN 'abcd' ELSE b END FROM collate_test1 ORDER BY 2;
SELECT a, CASE b WHEN 'abc' THEN 'abcd' ELSE b END FROM collate_test2 ORDER BY 2;
SELECT a, CASE b WHEN 'abc' THEN 'abcd' ELSE b END FROM collate_test3 ORDER BY 2;
CREATE DOMAIN testdomain AS text;
SELECT a, b::testdomain FROM collate_test1 ORDER BY 2;
SELECT a, b::testdomain FROM collate_test2 ORDER BY 2;
SELECT a, b::testdomain FROM collate_test3 ORDER BY 2;
SELECT a, b::testdomain_sv FROM collate_test3 ORDER BY 2;
SELECT a, lower(x::testdomain), lower(y::testdomain) FROM collate_test10;
SELECT min(b), max(b) FROM collate_test1;
SELECT min(b), max(b) FROM collate_test2;
SELECT min(b), max(b) FROM collate_test3;
SELECT array_agg(b ORDER BY b) FROM collate_test1;
SELECT array_agg(b ORDER BY b) FROM collate_test2;
SELECT array_agg(b ORDER BY b) FROM collate_test3;
SELECT a, b FROM collate_test1 UNION ALL SELECT a, b FROM collate_test1 ORDER BY 2;
SELECT a, b FROM collate_test2 UNION SELECT a, b FROM collate_test2 ORDER BY 2;
SELECT a, b FROM collate_test3 WHERE a < 4 INTERSECT SELECT a, b FROM collate_test3 WHERE a > 1 ORDER BY 2;
SELECT a, b FROM collate_test3 EXCEPT SELECT a, b FROM collate_test3 WHERE a < 2 ORDER BY 2;
SELECT a, b FROM collate_test1 UNION ALL SELECT a, b FROM collate_test3;
SELECT a, b COLLATE "C" FROM collate_test1 UNION SELECT a, b FROM collate_test3 ORDER BY 2;
select x || y from collate_test10;
SELECT a, CAST(b AS varchar) FROM collate_test1 ORDER BY 2;
SELECT a, CAST(b AS varchar) FROM collate_test2 ORDER BY 2;
SELECT a, CAST(b AS varchar) FROM collate_test3 ORDER BY 2;
CREATE FUNCTION mylt (text, text) RETURNS boolean LANGUAGE sql
    AS $$ select $1 < $2 $$;
CREATE FUNCTION mylt_noninline (text, text) RETURNS boolean LANGUAGE sql
    AS $$ select $1 < $2 limit 1 $$;
SELECT * FROM unnest((SELECT array_agg(b ORDER BY b) FROM collate_test1)) ORDER BY 1;
SELECT * FROM unnest((SELECT array_agg(b ORDER BY b) FROM collate_test2)) ORDER BY 1;
SELECT * FROM unnest((SELECT array_agg(b ORDER BY b) FROM collate_test3)) ORDER BY 1;
CREATE FUNCTION dup (anyelement) RETURNS anyelement
    AS 'select $1' LANGUAGE sql;
SELECT a, dup(b) FROM collate_test1 ORDER BY 2;
SELECT a, dup(b) FROM collate_test2 ORDER BY 2;
SELECT a, dup(b) FROM collate_test3 ORDER BY 2;
CREATE INDEX collate_test1_idx1 ON collate_test1 (b);
CREATE INDEX collate_test1_idx2 ON collate_test1 (b COLLATE "C");
CREATE INDEX collate_test1_idx3 ON collate_test1 ((b COLLATE "C"));
CREATE INDEX collate_test1_idx4 ON collate_test1 (((b||'foo') COLLATE "POSIX"));
SELECT relname, pg_get_indexdef(oid) FROM pg_class WHERE relname LIKE 'collate_test%_idx%' ORDER BY 1;
set enable_seqscan = off;
explain (costs off)
select * from collate_test1 where b ilike 'abc';
select * from collate_test1 where b ilike 'abc';
explain (costs off)
select * from collate_test1 where b ilike 'ABC';
select * from collate_test1 where b ilike 'ABC';
reset enable_seqscan;
CREATE SCHEMA test_schema;
SET client_min_messages TO WARNING;
SET icu_validation_level = disabled;
CREATE COLLATION test0 FROM "C";
RESET icu_validation_level;
RESET client_min_messages;
SET icu_validation_level = ERROR;
RESET icu_validation_level;
CREATE COLLATION testx (provider = icu, locale = 'nonsense-nowhere');
DROP COLLATION testx;
CREATE COLLATION test5 FROM test0;
SELECT collname FROM pg_collation WHERE collname LIKE 'test%' ORDER BY 1;
ALTER COLLATION test0 RENAME TO test11;
ALTER COLLATION test11 SET SCHEMA test_schema;
SELECT collname, nspname, obj_description(pg_collation.oid, 'pg_collation')
    FROM pg_collation JOIN pg_namespace ON (collnamespace = pg_namespace.oid)
    WHERE collname LIKE 'test%'
    ORDER BY 1;
DROP COLLATION IF EXISTS test0;
SELECT collname FROM pg_collation WHERE collname LIKE 'test%';
CREATE COLLATION test0 FROM "C";
CREATE TABLE collate_dep_test1 (a int, b text COLLATE test0);
CREATE DOMAIN collate_dep_dom1 AS text COLLATE test0;
CREATE TYPE collate_dep_test2 AS (x int, y text COLLATE test0);
CREATE VIEW collate_dep_test3 AS SELECT text 'foo' COLLATE test0 AS foo;
CREATE TABLE collate_dep_test4t (a int, b text);
CREATE INDEX collate_dep_test4i ON collate_dep_test4t (b COLLATE test0);
DROP COLLATION test0 CASCADE;
DROP TABLE collate_dep_test1, collate_dep_test4t;
DROP TYPE collate_dep_test2;
create type textrange_c as range(subtype=text, collation="C");
create type textrange_en_us as range(subtype=text, collation="en-x-icu");
select textrange_c('A','Z') @> 'b'::text;
select textrange_en_us('A','Z') @> 'b'::text;
drop type textrange_c;
drop type textrange_en_us;
SELECT * FROM collate_test2 ORDER BY b COLLATE UCS_BASIC;
SELECT * FROM collate_test2 ORDER BY b COLLATE UNICODE;
SET client_min_messages=WARNING;
RESET client_min_messages;
SET client_min_messages=WARNING;
CREATE COLLATION testcoll_backwards (provider = icu, locale = '@colBackwards=yes');
RESET client_min_messages;
SELECT 'cotÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©' < 'cÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ´te' COLLATE "und-x-icu", 'cotÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©' > 'cÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ´te' COLLATE testcoll_backwards;
CREATE COLLATION testcoll_lower_first (provider = icu, locale = '@colCaseFirst=lower');
CREATE COLLATION testcoll_upper_first (provider = icu, locale = '@colCaseFirst=upper');
SELECT 'aaa' < 'AAA' COLLATE testcoll_lower_first, 'aaa' > 'AAA' COLLATE testcoll_upper_first;
CREATE COLLATION testcoll_shifted (provider = icu, locale = '@colAlternate=shifted');
SELECT 'de-luge' < 'deanza' COLLATE "und-x-icu", 'de-luge' > 'deanza' COLLATE testcoll_shifted;
SET client_min_messages=WARNING;
CREATE COLLATION testcoll_numeric (provider = icu, locale = '@colNumeric=yes');
RESET client_min_messages;
SELECT 'A-21' > 'A-123' COLLATE "und-x-icu", 'A-21' < 'A-123' COLLATE testcoll_numeric;
CREATE COLLATION testcoll_de_phonebook (provider = icu, locale = 'de@collation=phonebook');
SELECT 'Goldmann' < 'GÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¶tz' COLLATE "de-x-icu", 'Goldmann' > 'GÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¶tz' COLLATE testcoll_de_phonebook;
CREATE COLLATION testcoll_rules1 (provider = icu, locale = '', rules = '&a < g');
CREATE TABLE test7 (a text);
INSERT INTO test7 VALUES ('Abernathy'), ('apple'), ('bird'), ('Boston'), ('Graham'), ('green');
SELECT * FROM test7 ORDER BY a COLLATE "en-x-icu";
SELECT * FROM test7 ORDER BY a COLLATE testcoll_rules1;
DROP TABLE test7;
CREATE COLLATION ctest_det (provider = icu, locale = '', deterministic = true);
CREATE COLLATION ctest_nondet (provider = icu, locale = '', deterministic = false);
CREATE TABLE test6 (a int, b text);
INSERT INTO test6 VALUES (1, U&'\00E4bc');
INSERT INTO test6 VALUES (2, U&'\0061\0308bc');
SELECT * FROM test6;
SELECT * FROM test6 WHERE b = 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤bc' COLLATE ctest_det;
SELECT * FROM test6 WHERE b = 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤bc' COLLATE ctest_nondet;
CREATE TABLE test6a (a int, b text[]);
INSERT INTO test6a VALUES (1, ARRAY[U&'\00E4bc']);
INSERT INTO test6a VALUES (2, ARRAY[U&'\0061\0308bc']);
SELECT * FROM test6a;
SELECT * FROM test6a WHERE b = ARRAY['ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤bc'] COLLATE ctest_det;
SELECT * FROM test6a WHERE b = ARRAY['ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¤bc'] COLLATE ctest_nondet;
CREATE COLLATION case_sensitive (provider = icu, locale = '');
CREATE COLLATION case_insensitive (provider = icu, locale = '@colStrength=secondary', deterministic = false);
SELECT 'abc' <= 'ABC' COLLATE case_sensitive, 'abc' >= 'ABC' COLLATE case_sensitive;
SELECT 'abc' <= 'ABC' COLLATE case_insensitive, 'abc' >= 'ABC' COLLATE case_insensitive;
CREATE COLLATION lt_insensitive (provider = icu, locale = 'en-u-ks-level1', deterministic = false);
SELECT 'aBcD' COLLATE lt_insensitive = 'AbCd' COLLATE lt_insensitive;
CREATE COLLATION lt_upperfirst (provider = icu, locale = 'und-u-kf-upper');
SELECT 'Z' COLLATE lt_upperfirst < 'z' COLLATE lt_upperfirst;
CREATE TABLE test1cs (x text COLLATE case_sensitive);
CREATE TABLE test2cs (x text COLLATE case_sensitive);
CREATE TABLE test3cs (x text COLLATE case_sensitive);
INSERT INTO test1cs VALUES ('abc'), ('def'), ('ghi');
INSERT INTO test2cs VALUES ('ABC'), ('ghi');
INSERT INTO test3cs VALUES ('abc'), ('ABC'), ('def'), ('ghi');
SELECT x FROM test3cs WHERE x = 'abc';
SELECT x FROM test3cs WHERE x <> 'abc';
SELECT x FROM test3cs WHERE x LIKE 'a%';
SELECT x FROM test3cs WHERE x ILIKE 'a%';
SELECT x FROM test3cs WHERE x SIMILAR TO 'a%';
SELECT x FROM test3cs WHERE x ~ 'a';
SET enable_hashagg TO off;
SELECT x FROM test1cs UNION SELECT x FROM test2cs ORDER BY x;
SELECT x FROM test2cs UNION SELECT x FROM test1cs ORDER BY x;
SELECT x FROM test1cs INTERSECT SELECT x FROM test2cs;
SELECT x FROM test2cs INTERSECT SELECT x FROM test1cs;
SELECT x FROM test1cs EXCEPT SELECT x FROM test2cs;
SELECT x FROM test2cs EXCEPT SELECT x FROM test1cs;
SELECT DISTINCT x FROM test3cs ORDER BY x;
RESET enable_hashagg;
SELECT count(DISTINCT x) FROM test3cs;
SELECT x, count(*) FROM test3cs GROUP BY x ORDER BY x;
SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3cs ORDER BY x;
CREATE UNIQUE INDEX ON test1cs (x);
INSERT INTO test1cs VALUES ('ABC');
CREATE UNIQUE INDEX ON test3cs (x);
SELECT string_to_array('ABC,DEF,GHI' COLLATE case_sensitive, ',', 'abc');
SELECT string_to_array('ABCDEFGHI' COLLATE case_sensitive, NULL, 'b');
CREATE TABLE test1ci (x text COLLATE case_insensitive);
CREATE TABLE test2ci (x text COLLATE case_insensitive);
CREATE TABLE test3ci (x text COLLATE case_insensitive);
INSERT INTO test1ci VALUES ('abc'), ('def'), ('ghi');
INSERT INTO test2ci VALUES ('ABC'), ('ghi');
INSERT INTO test3ci VALUES ('abc'), ('ABC'), ('def'), ('ghi');
SELECT x FROM test3ci WHERE x = 'abc';
SELECT x FROM test3ci WHERE x <> 'abc';
SELECT x FROM test1ci UNION SELECT x FROM test2ci ORDER BY x;
SELECT x FROM test2ci UNION SELECT x FROM test1ci ORDER BY x;
SELECT x FROM test1ci INTERSECT SELECT x FROM test2ci ORDER BY x;
SELECT x FROM test2ci INTERSECT SELECT x FROM test1ci ORDER BY x;
SELECT x FROM test1ci EXCEPT SELECT x FROM test2ci;
SELECT x FROM test2ci EXCEPT SELECT x FROM test1ci;
SELECT DISTINCT x FROM test3ci ORDER BY x;
SELECT count(DISTINCT x) FROM test3ci;
SELECT x, count(*) FROM test3ci GROUP BY x ORDER BY x;
SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3ci ORDER BY x;
CREATE UNIQUE INDEX ON test1ci (x);
SELECT string_to_array('ABCDEFGHI' COLLATE case_insensitive, NULL, 'b');
CREATE TABLE test1bpci (x char(3) COLLATE case_insensitive);
CREATE TABLE test2bpci (x char(3) COLLATE case_insensitive);
CREATE TABLE test3bpci (x char(3) COLLATE case_insensitive);
INSERT INTO test1bpci VALUES ('abc'), ('def'), ('ghi');
INSERT INTO test2bpci VALUES ('ABC'), ('ghi');
INSERT INTO test3bpci VALUES ('abc'), ('ABC'), ('def'), ('ghi');
SELECT x FROM test3bpci WHERE x = 'abc';
SELECT x FROM test3bpci WHERE x <> 'abc';
SELECT x FROM test1bpci UNION SELECT x FROM test2bpci ORDER BY x;
SELECT x FROM test2bpci UNION SELECT x FROM test1bpci ORDER BY x;
SELECT x FROM test1bpci INTERSECT SELECT x FROM test2bpci ORDER BY x;
SELECT x FROM test2bpci INTERSECT SELECT x FROM test1bpci ORDER BY x;
SELECT x FROM test1bpci EXCEPT SELECT x FROM test2bpci;
SELECT x FROM test2bpci EXCEPT SELECT x FROM test1bpci;
SELECT DISTINCT x FROM test3bpci ORDER BY x;
SELECT count(DISTINCT x) FROM test3bpci;
SELECT x, count(*) FROM test3bpci GROUP BY x ORDER BY x;
SELECT x, row_number() OVER (ORDER BY x), rank() OVER (ORDER BY x) FROM test3bpci ORDER BY x;
CREATE UNIQUE INDEX ON test1bpci (x);
SELECT string_to_array('ABCDEFGHI'::char(9) COLLATE case_insensitive, NULL, 'b');
CREATE TABLE test4c (x text COLLATE "C");
INSERT INTO test4c VALUES ('abc');
CREATE INDEX ON test4c (x);
SET enable_seqscan = off;
SELECT x FROM test4c WHERE x LIKE 'ABC' COLLATE case_sensitive;
SELECT x FROM test4c WHERE x LIKE 'ABC%' COLLATE case_sensitive;
RESET enable_seqscan;
SELECT 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ½ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ´ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂµÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ' = 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ½ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¥ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£' COLLATE case_sensitive;
SELECT 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ½ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ´ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂµÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ' = 'ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¡ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ½ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ¥ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£ÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ£' COLLATE case_insensitive;
SELECT relname FROM pg_class WHERE relname = 'PG_CLASS'::text COLLATE case_insensitive;
SELECT relname FROM pg_class WHERE 'PG_CLASS'::text = relname COLLATE case_insensitive;
SELECT typname FROM pg_type WHERE typname LIKE 'int_' AND typname <> 'INT2'::text
  COLLATE case_insensitive ORDER BY typname;
SELECT typname FROM pg_type WHERE typname LIKE 'int_' AND 'INT2'::text <> typname
  COLLATE case_insensitive ORDER BY typname;
CREATE TEMP TABLE outer_text (f1 text COLLATE case_insensitive, f2 text);
INSERT INTO outer_text VALUES ('a', 'a');
INSERT INTO outer_text VALUES ('b', 'a');
INSERT INTO outer_text VALUES ('A', NULL);
INSERT INTO outer_text VALUES ('B', NULL);
CREATE TEMP TABLE inner_text (c1 text COLLATE case_insensitive, c2 text);
INSERT INTO inner_text VALUES ('a', NULL);
SELECT * FROM outer_text WHERE (f1, f2) NOT IN (SELECT * FROM inner_text);
SET client_min_messages=WARNING;
RESET client_min_messages;
CREATE TABLE test4 (a int, b text);
INSERT INTO test4 VALUES (1, 'cote'), (2, 'cÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ´te'), (3, 'cotÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©'), (4, 'cÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ´tÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂÃÂ©');
SELECT * FROM test4 WHERE b = 'cote';
SELECT * FROM test4 WHERE b = 'Cote' COLLATE case_insensitive;
CREATE TABLE test10pk (x text COLLATE case_sensitive PRIMARY KEY);
INSERT INTO test10pk VALUES ('abc'), ('def'), ('ghi');
CREATE TABLE test10fk (x text COLLATE case_insensitive REFERENCES test10pk (x) ON UPDATE CASCADE ON DELETE CASCADE);
INSERT INTO test10fk VALUES ('abc');
SELECT * FROM test10pk;
SELECT * FROM test10fk;
SELECT * FROM test10fk;
DELETE FROM test10pk WHERE x = 'abc';
SELECT * FROM test10pk;
SELECT * FROM test10fk;
CREATE TABLE test11pk (x text COLLATE case_insensitive PRIMARY KEY);
INSERT INTO test11pk VALUES ('abc'), ('def'), ('ghi');
CREATE TABLE test11fk (x text COLLATE case_sensitive REFERENCES test11pk (x) ON UPDATE CASCADE ON DELETE CASCADE);
INSERT INTO test11fk VALUES ('abc');
INSERT INTO test11fk VALUES ('ABC');
SELECT * FROM test11pk;
SELECT * FROM test11fk;
UPDATE test11pk SET x = 'ABC' WHERE x = 'abc';
SELECT * FROM test11fk;
DELETE FROM test11pk WHERE x = 'abc';
SELECT * FROM test11pk;
SELECT * FROM test11fk;
CREATE TABLE test20 (a int, b text COLLATE case_insensitive) PARTITION BY LIST (b);
CREATE TABLE test20_1 PARTITION OF test20 FOR VALUES IN ('abc');
INSERT INTO test20 VALUES (1, 'abc');
INSERT INTO test20 VALUES (2, 'ABC');
SELECT * FROM test20_1;
CREATE TABLE test21 (a int, b text COLLATE case_insensitive) PARTITION BY RANGE (b);
CREATE TABLE test21_1 PARTITION OF test21 FOR VALUES FROM ('ABC') TO ('DEF');
INSERT INTO test21 VALUES (1, 'abc');
INSERT INTO test21 VALUES (2, 'ABC');
SELECT * FROM test21_1;
CREATE TABLE test22 (a int, b text COLLATE case_sensitive) PARTITION BY HASH (b);
CREATE TABLE test22_0 PARTITION OF test22 FOR VALUES WITH (MODULUS 2, REMAINDER 0);
CREATE TABLE test22_1 PARTITION OF test22 FOR VALUES WITH (MODULUS 2, REMAINDER 1);
INSERT INTO test22 VALUES (1, 'def');
INSERT INTO test22 VALUES (2, 'DEF');
SELECT (SELECT count(*) FROM test22_0) = (SELECT count(*) FROM test22_1);
CREATE TABLE test22a (a int, b text[] COLLATE case_sensitive) PARTITION BY HASH (b);
CREATE TABLE test22a_0 PARTITION OF test22a FOR VALUES WITH (MODULUS 2, REMAINDER 0);
CREATE TABLE test22a_1 PARTITION OF test22a FOR VALUES WITH (MODULUS 2, REMAINDER 1);
INSERT INTO test22a VALUES (1, ARRAY['def']);
INSERT INTO test22a VALUES (2, ARRAY['DEF']);
SELECT (SELECT count(*) FROM test22a_0) = (SELECT count(*) FROM test22a_1);
CREATE TABLE test23 (a int, b text COLLATE case_insensitive) PARTITION BY HASH (b);
CREATE TABLE test23_0 PARTITION OF test23 FOR VALUES WITH (MODULUS 2, REMAINDER 0);
CREATE TABLE test23_1 PARTITION OF test23 FOR VALUES WITH (MODULUS 2, REMAINDER 1);
INSERT INTO test23 VALUES (1, 'def');
INSERT INTO test23 VALUES (2, 'DEF');
SELECT (SELECT count(*) FROM test23_0) <> (SELECT count(*) FROM test23_1);
CREATE TABLE test23a (a int, b text[] COLLATE case_insensitive) PARTITION BY HASH (b);
CREATE TABLE test23a_0 PARTITION OF test23a FOR VALUES WITH (MODULUS 2, REMAINDER 0);
CREATE TABLE test23a_1 PARTITION OF test23a FOR VALUES WITH (MODULUS 2, REMAINDER 1);
INSERT INTO test23a VALUES (1, ARRAY['def']);
INSERT INTO test23a VALUES (2, ARRAY['DEF']);
SELECT (SELECT count(*) FROM test23a_0) <> (SELECT count(*) FROM test23a_1);
CREATE TABLE test30 (a int, b char(3) COLLATE case_insensitive) PARTITION BY LIST (b);
CREATE TABLE test30_1 PARTITION OF test30 FOR VALUES IN ('abc');
INSERT INTO test30 VALUES (1, 'abc');
INSERT INTO test30 VALUES (2, 'ABC');
SELECT * FROM test30_1;
CREATE TABLE test31 (a int, b char(3) COLLATE case_insensitive) PARTITION BY RANGE (b);
CREATE TABLE test31_1 PARTITION OF test31 FOR VALUES FROM ('ABC') TO ('DEF');
INSERT INTO test31 VALUES (1, 'abc');
INSERT INTO test31 VALUES (2, 'ABC');
SELECT * FROM test31_1;
CREATE TABLE test32 (a int, b char(3) COLLATE case_sensitive) PARTITION BY HASH (b);
CREATE TABLE test32_0 PARTITION OF test32 FOR VALUES WITH (MODULUS 2, REMAINDER 0);
CREATE TABLE test32_1 PARTITION OF test32 FOR VALUES WITH (MODULUS 2, REMAINDER 1);
INSERT INTO test32 VALUES (1, 'def');
INSERT INTO test32 VALUES (2, 'DEF');
SELECT (SELECT count(*) FROM test32_0) = (SELECT count(*) FROM test32_1);
CREATE TABLE test33 (a int, b char(3) COLLATE case_insensitive) PARTITION BY HASH (b);
CREATE TABLE test33_0 PARTITION OF test33 FOR VALUES WITH (MODULUS 2, REMAINDER 0);
CREATE TABLE test33_1 PARTITION OF test33 FOR VALUES WITH (MODULUS 2, REMAINDER 1);
INSERT INTO test33 VALUES (1, 'def');
INSERT INTO test33 VALUES (2, 'DEF');
SELECT (SELECT count(*) FROM test33_0) <> (SELECT count(*) FROM test33_1);
RESET search_path;
SET client_min_messages TO warning;
DROP SCHEMA collate_tests CASCADE;
RESET client_min_messages;
CREATE COLLATION coll_icu_upgrade FROM "und-x-icu";
