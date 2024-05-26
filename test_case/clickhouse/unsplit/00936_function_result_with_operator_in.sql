SET force_primary_key = 1;
DROP TABLE IF EXISTS samples;
CREATE TABLE samples (key UInt32, value UInt32) ENGINE = MergeTree() ORDER BY key PRIMARY KEY key;
INSERT INTO samples VALUES (1, 1)(2, 2)(3, 3)(4, 4)(5, 5);
SELECT count() FROM samples WHERE key IN range(10);
SELECT 'empty:';
SELECT 'a' IN splitByChar('c', 'abcdef');
SELECT 'errors:';
DROP TABLE samples;
