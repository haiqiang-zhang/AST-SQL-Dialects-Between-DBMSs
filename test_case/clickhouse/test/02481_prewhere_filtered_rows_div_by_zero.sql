SELECT _part_offset, intDiv(_part_offset, 3) as granule, * FROM test_filter ORDER BY _part_offset;
SELECT intDiv(b, c) FROM test_filter WHERE c != 0;
SET mutations_sync = 2;
DELETE FROM test_filter WHERE c = 0;
SELECT * FROM test_filter PREWHERE intDiv(b, c) > 0;
SELECT * FROM test_filter PREWHERE b != 0 WHERE intDiv(b, c) > 0;
DROP TABLE test_filter;
