PRAGMA enable_verification;
SET errors_as_json=true;
SELECT * FROM nonexistent_table;
SELECT cbl FROM (VALUES (42)) t(col);
select corr('hello', 'world');
