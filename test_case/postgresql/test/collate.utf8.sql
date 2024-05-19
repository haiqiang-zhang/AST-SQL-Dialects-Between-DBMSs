/*
 * This test is for collations and character operations when using the
 * builtin provider with the C.UTF-8 locale.
 */

/* skip test if not UTF8 server encoding */
SELECT getdatabaseencoding() <> 'UTF8' AS skip_test \gset

SET client_encoding TO UTF8;


CREATE COLLATION regress_pg_c_utf8 (
  provider = builtin, locale = 'C_UTF8'); 
CREATE COLLATION regress_pg_c_utf8 (
  provider = builtin, locale = 'C.UTF8');
DROP COLLATION regress_pg_c_utf8;
CREATE COLLATION regress_pg_c_utf8 (
  provider = builtin, locale = 'C.UTF-8');

CREATE TABLE test_pg_c_utf8 (
  t TEXT COLLATE PG_C_UTF8
);
INSERT INTO test_pg_c_utf8 VALUES
  ('abc DEF 123abc'),
  ('Ã¡bc sÃs Ãss DÃF'),
  ('ÇxxÇ ÇxxÇ ÇxxÇ'),
  ('ÈºÈºÈº'),
  ('â±¥â±¥â±¥'),
  ('â±¥Èº');

SELECT
    t, lower(t), initcap(t), upper(t),
    length(convert_to(t, 'UTF8')) AS t_bytes,
    length(convert_to(lower(t), 'UTF8')) AS lower_t_bytes,
    length(convert_to(initcap(t), 'UTF8')) AS initcap_t_bytes,
    length(convert_to(upper(t), 'UTF8')) AS upper_t_bytes
  FROM test_pg_c_utf8;

DROP TABLE test_pg_c_utf8;

SELECT lower('ÎÎ£' COLLATE PG_C_UTF8);
SELECT lower('ÎÍºÎ£Íº' COLLATE PG_C_UTF8);
SELECT lower('ÎÎÎ£Î' COLLATE PG_C_UTF8);


SELECT 'xyz' ~ '[[:alnum:]]' COLLATE PG_C_UTF8;
SELECT 'xyz' !~ '[[:upper:]]' COLLATE PG_C_UTF8;
SELECT '@' !~ '[[:alnum:]]' COLLATE PG_C_UTF8;
SELECT '=' ~ '[[:punct:]]' COLLATE PG_C_UTF8; 
SELECT 'a8a' ~ '[[:digit:]]' COLLATE PG_C_UTF8;
SELECT 'àµ§' !~ '\d' COLLATE PG_C_UTF8; 


SELECT 'xYz' ~* 'XyZ' COLLATE PG_C_UTF8;
SELECT 'xAb' ~* '[W-Y]' COLLATE PG_C_UTF8;
SELECT 'xAb' !~* '[c-d]' COLLATE PG_C_UTF8;
SELECT 'Î' ~* '[Î³-Î»]' COLLATE PG_C_UTF8;
SELECT 'Î´' ~* '[Î-Î]' COLLATE PG_C_UTF8; 
