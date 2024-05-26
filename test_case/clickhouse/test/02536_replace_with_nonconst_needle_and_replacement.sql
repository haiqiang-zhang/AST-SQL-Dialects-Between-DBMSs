SELECT '- non-const needle, const replacement';
SELECT id, haystack, needle, 'x', replaceAll(haystack, needle, 'x') FROM test_tab ORDER BY id;
SELECT '- const needle, non-const replacement';
SELECT '- non-const needle, non-const replacement';
SELECT '** replaceOne() **';
SELECT '- non-const needle, const replacement';
SELECT id, haystack, needle, 'x', replaceOne(haystack, needle, 'x') FROM test_tab ORDER BY id;
SELECT '- const needle, non-const replacement';
SELECT '- non-const needle, non-const replacement';
SELECT '** replaceRegexpAll() **';
SELECT '- non-const needle, const replacement';
SELECT id, haystack, needle, 'x', replaceRegexpAll(haystack, needle, 'x') FROM test_tab ORDER BY id;
SELECT '- const needle, non-const replacement';
SELECT '- non-const needle, non-const replacement';
SELECT '** replaceRegexpOne() **';
SELECT '- non-const needle, const replacement';
SELECT id, haystack, needle, 'x', replaceRegexpOne(haystack, needle, 'x') FROM test_tab ORDER BY id;
SELECT '- const needle, non-const replacement';
SELECT '- non-const needle, non-const replacement';
DROP TABLE IF EXISTS test_tab;
SELECT 'Check that an exception is thrown if the needle is empty';
CREATE TABLE test_tab
  (id UInt32, haystack String, needle String, replacement String)
  engine = MergeTree()
  ORDER BY id;
DROP TABLE IF EXISTS test_tab;
