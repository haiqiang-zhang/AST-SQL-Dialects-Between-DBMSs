SELECT DISTINCT 1 FROM bug_13492, numbers(1) n;
SET max_threads = 2;
SELECT DISTINCT 1 FROM bug_13492, numbers(1) n;
DROP TABLE bug_13492;
