SELECT count() FROM samples WHERE key IN range(10);
SELECT 'empty:';
SELECT 'a' IN splitByChar('c', 'abcdef');
SELECT 'errors:';
DROP TABLE samples;
