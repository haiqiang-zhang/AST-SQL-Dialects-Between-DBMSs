DROP TABLE IF EXISTS tab;
CREATE TABLE tab (haystack String, pattern String) engine = MergeTree() ORDER BY haystack;
INSERT INTO tab VALUES ('haystack', 'pattern\\');
DROP TABLE IF EXISTS tab;
