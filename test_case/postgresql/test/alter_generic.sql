GRANT ALL ON SCHEMA alt_nsp1, alt_nsp2 TO public;
SET search_path = alt_nsp1, public;
CREATE FUNCTION alt_func1(int) RETURNS int LANGUAGE sql
  AS 'SELECT $1 + 1';
CREATE FUNCTION alt_func2(int) RETURNS int LANGUAGE sql
  AS 'SELECT $1 - 1';
CREATE AGGREGATE alt_agg1 (
  sfunc1 = int4pl, basetype = int4, stype1 = int4, initcond = 0
);
CREATE AGGREGATE alt_agg2 (
  sfunc1 = int4mi, basetype = int4, stype1 = int4, initcond = 0
);
ALTER FUNCTION alt_func1(int) RENAME TO alt_func3;
ALTER FUNCTION alt_func2(int) SET SCHEMA alt_nsp1;
ALTER FUNCTION alt_func2(int) SET SCHEMA alt_nsp2;
ALTER AGGREGATE alt_agg1(int) RENAME TO alt_agg3;
ALTER AGGREGATE alt_agg2(int) SET SCHEMA alt_nsp2;
CREATE FUNCTION alt_func1(int) RETURNS int LANGUAGE sql
  AS 'SELECT $1 + 2';
CREATE FUNCTION alt_func2(int) RETURNS int LANGUAGE sql
  AS 'SELECT $1 - 2';
CREATE AGGREGATE alt_agg1 (
  sfunc1 = int4pl, basetype = int4, stype1 = int4, initcond = 100
);
CREATE AGGREGATE alt_agg2 (
  sfunc1 = int4mi, basetype = int4, stype1 = int4, initcond = -100
);
ALTER FUNCTION alt_func3(int) RENAME TO alt_func4;
ALTER AGGREGATE alt_agg3(int) RENAME TO alt_agg4;
RESET SESSION AUTHORIZATION;
CREATE CONVERSION alt_conv1 FOR 'LATIN1' TO 'UTF8' FROM iso8859_1_to_utf8;
CREATE CONVERSION alt_conv2 FOR 'LATIN1' TO 'UTF8' FROM iso8859_1_to_utf8;
ALTER CONVERSION alt_conv1 RENAME TO alt_conv3;
ALTER CONVERSION alt_conv2 SET SCHEMA alt_nsp2;
CREATE CONVERSION alt_conv1 FOR 'LATIN1' TO 'UTF8' FROM iso8859_1_to_utf8;
CREATE CONVERSION alt_conv2 FOR 'LATIN1' TO 'UTF8' FROM iso8859_1_to_utf8;
ALTER CONVERSION alt_conv3 RENAME TO alt_conv4;
RESET SESSION AUTHORIZATION;
SELECT fdwname FROM pg_foreign_data_wrapper WHERE fdwname like 'alt_fdw%';
SELECT srvname FROM pg_foreign_server WHERE srvname like 'alt_fserv%';
RESET SESSION AUTHORIZATION;
CREATE OPERATOR @-@ ( leftarg = int4, rightarg = int4, procedure = int4mi );
CREATE OPERATOR @+@ ( leftarg = int4, rightarg = int4, procedure = int4pl );
ALTER OPERATOR @-@(int4, int4) SET SCHEMA alt_nsp2;
CREATE OPERATOR @-@ ( leftarg = int4, rightarg = int4, procedure = int4mi );
ALTER OPERATOR @+@(int4, int4) SET SCHEMA alt_nsp2;
RESET SESSION AUTHORIZATION;
RESET SESSION AUTHORIZATION;
RESET SESSION AUTHORIZATION;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
BEGIN TRANSACTION;
ROLLBACK;
CREATE TABLE alt_regress_1 (a INTEGER, b INTEGER);
CREATE STATISTICS alt_stat1 ON a, b FROM alt_regress_1;
CREATE STATISTICS alt_stat2 ON a, b FROM alt_regress_1;
ALTER STATISTICS alt_stat1 RENAME TO alt_stat3;
ALTER STATISTICS alt_stat2 SET SCHEMA alt_nsp2;
CREATE TABLE alt_regress_2 (a INTEGER, b INTEGER);
CREATE STATISTICS alt_stat1 ON a, b FROM alt_regress_2;
CREATE STATISTICS alt_stat2 ON a, b FROM alt_regress_2;
ALTER STATISTICS alt_stat3 RENAME TO alt_stat4;
RESET SESSION AUTHORIZATION;
CREATE TEXT SEARCH DICTIONARY alt_ts_dict1 (template=simple);
CREATE TEXT SEARCH DICTIONARY alt_ts_dict2 (template=simple);
ALTER TEXT SEARCH DICTIONARY alt_ts_dict1 RENAME TO alt_ts_dict3;
ALTER TEXT SEARCH DICTIONARY alt_ts_dict2 SET SCHEMA alt_nsp2;
CREATE TEXT SEARCH DICTIONARY alt_ts_dict1 (template=simple);
CREATE TEXT SEARCH DICTIONARY alt_ts_dict2 (template=simple);
ALTER TEXT SEARCH DICTIONARY alt_ts_dict3 RENAME TO alt_ts_dict4;
RESET SESSION AUTHORIZATION;
CREATE TEXT SEARCH CONFIGURATION alt_ts_conf1 (copy=english);
CREATE TEXT SEARCH CONFIGURATION alt_ts_conf2 (copy=english);
ALTER TEXT SEARCH CONFIGURATION alt_ts_conf1 RENAME TO alt_ts_conf3;
ALTER TEXT SEARCH CONFIGURATION alt_ts_conf2 SET SCHEMA alt_nsp2;
CREATE TEXT SEARCH CONFIGURATION alt_ts_conf1 (copy=english);
CREATE TEXT SEARCH CONFIGURATION alt_ts_conf2 (copy=english);
ALTER TEXT SEARCH CONFIGURATION alt_ts_conf3 RENAME TO alt_ts_conf4;
RESET SESSION AUTHORIZATION;
SELECT nspname, tmplname
  FROM pg_ts_template t, pg_namespace n
  WHERE t.tmplnamespace = n.oid AND nspname like 'alt_nsp%'
  ORDER BY nspname, tmplname;
SELECT nspname, prsname
  FROM pg_ts_parser t, pg_namespace n
  WHERE t.prsnamespace = n.oid AND nspname like 'alt_nsp%'
  ORDER BY nspname, prsname;
DROP SCHEMA alt_nsp1 CASCADE;
DROP SCHEMA alt_nsp2 CASCADE;
