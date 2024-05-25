-- Tag no-replicated-database: Old syntax is not allowed

SET optimize_on_insert = 0;
SET send_logs_level = 'fatal';
DROP TABLE IF EXISTS old_style;
set allow_deprecated_syntax_for_merge_tree=1;
DROP TABLE IF EXISTS summing_r1;
DROP TABLE IF EXISTS summing_r2;
SELECT '*** Check that the parts are sorted according to the new key. ***';
SELECT '*** Check that the rows are collapsed according to the new key. ***';
SELECT '*** Check SHOW CREATE TABLE ***';
SELECT '*** Check SHOW CREATE TABLE after offline ALTER ***';
