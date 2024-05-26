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
