-- no-s3 because read FileOpen metric
DROP TABLE IF EXISTS nested;
SET flatten_nested = 0;
SET use_uncompressed_cache = 0;
SET local_filesystem_read_method='pread';
CREATE TABLE nested
(
    col1 Nested(a UInt32, s String),
    col2 Nested(a UInt32, n Nested(s String, b UInt32)),
    col3 Nested(n1 Nested(a UInt32, b UInt32), n2 Nested(s String, t String))
)
ENGINE = MergeTree
ORDER BY tuple()
SETTINGS min_bytes_for_wide_part = 0;
INSERT INTO nested VALUES ([(1, 'q'), (2, 'w'), (3, 'e')], [(4, [('a', 5), ('s', 6), ('d', 7)])], [([(8, 9), (10, 11)], [('z', 'x'), ('c', 'v')])]);
INSERT INTO nested VALUES ([(12, 'qq')], [(4, []), (5, [('b', 6), ('n', 7)])], [([], []), ([(44, 55), (66, 77)], [])]);
OPTIMIZE TABLE nested FINAL;
SELECT 'all';
SELECT * FROM nested;
SELECT 'col1';
SELECT col1.a, col1.s FROM nested;
SELECT 'col2';
SELECT col2.a, col2.n, col2.n.s, col2.n.b FROM nested;
SELECT 'col3';
SELECT col3.n1, col3.n2, col3.n1.a, col3.n1.b, col3.n2.s, col3.n2.t FROM nested;
SELECT 'read files';
SYSTEM DROP MARK CACHE;
SYSTEM FLUSH LOGS;
SYSTEM DROP MARK CACHE;
SYSTEM FLUSH LOGS;
DROP TABLE nested;
CREATE TABLE nested
(
    id UInt32,
    col1 Nested(a UInt32, n Nested(s String, b UInt32))
)
ENGINE = MergeTree
ORDER BY id
SETTINGS min_bytes_for_wide_part = 0;
SELECT id % 10, sum(length(col1)), sumArray(arrayMap(x -> length(x), col1.n.b)) FROM nested GROUP BY id % 10;
SELECT arraySum(col1.a), arrayMap(x -> x * x * 2, col1.a) FROM nested ORDER BY id LIMIT 5;
SELECT untuple(arrayJoin(arrayJoin(col1.n))) FROM nested ORDER BY id LIMIT 10 OFFSET 10;
DROP TABLE nested;
