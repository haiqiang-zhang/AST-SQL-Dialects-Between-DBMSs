SELECT abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_increasing OFFSET 20000 - 4;
SELECT abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_decreasing NULLS FIRST OFFSET 20000 - 4;
SELECT noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_increasing OFFSET 20000 - 4;
SELECT noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing NULLS FIRST OFFSET 20000 - 4;
SELECT abort_increasing, noabort_increasing FROM abbrev_abort_uuids ORDER BY abort_increasing LIMIT 5;
SELECT abort_increasing, noabort_increasing FROM abbrev_abort_uuids ORDER BY noabort_increasing NULLS FIRST LIMIT 5;
CREATE INDEX abbrev_abort_uuids__noabort_increasing_idx ON abbrev_abort_uuids (noabort_increasing);
CREATE INDEX abbrev_abort_uuids__noabort_decreasing_idx ON abbrev_abort_uuids (noabort_decreasing);
EXPLAIN (COSTS OFF)
SELECT id, noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_increasing LIMIT 5;
SELECT id, noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_increasing LIMIT 5;
EXPLAIN (COSTS OFF)
SELECT id, noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing LIMIT 5;
SELECT id, noabort_increasing, noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing LIMIT 5;
CREATE INDEX abbrev_abort_uuids__abort_increasing_idx ON abbrev_abort_uuids (abort_increasing);
CREATE INDEX abbrev_abort_uuids__abort_decreasing_idx ON abbrev_abort_uuids (abort_decreasing);
EXPLAIN (COSTS OFF)
SELECT id, abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_increasing LIMIT 5;
SELECT id, abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_increasing LIMIT 5;
EXPLAIN (COSTS OFF)
SELECT id, abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_decreasing LIMIT 5;
SELECT id, abort_increasing, abort_decreasing FROM abbrev_abort_uuids ORDER BY abort_decreasing LIMIT 5;
BEGIN;
SET LOCAL enable_indexscan = false;
CLUSTER abbrev_abort_uuids USING abbrev_abort_uuids__abort_increasing_idx;
SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid LIMIT 5;
SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid DESC LIMIT 5;
ROLLBACK;
BEGIN;
SET LOCAL enable_indexscan = false;
CLUSTER abbrev_abort_uuids USING abbrev_abort_uuids__abort_decreasing_idx;
SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid LIMIT 5;
SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid DESC LIMIT 5;
ROLLBACK;
BEGIN;
SET LOCAL enable_indexscan = false;
CLUSTER abbrev_abort_uuids USING abbrev_abort_uuids__noabort_increasing_idx;
SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid LIMIT 5;
SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid DESC LIMIT 5;
ROLLBACK;
BEGIN;
SET LOCAL enable_indexscan = false;
CLUSTER abbrev_abort_uuids USING abbrev_abort_uuids__noabort_decreasing_idx;
SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid LIMIT 5;
SELECT id, abort_increasing, abort_decreasing, noabort_increasing, noabort_decreasing
FROM abbrev_abort_uuids
ORDER BY ctid DESC LIMIT 5;
ROLLBACK;
BEGIN;
SET LOCAL enable_indexscan = false;
EXPLAIN (COSTS OFF) DECLARE c SCROLL CURSOR FOR SELECT noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing;
DECLARE c SCROLL CURSOR FOR SELECT noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing;
FETCH NEXT FROM c;
FETCH NEXT FROM c;
FETCH BACKWARD FROM c;
FETCH BACKWARD FROM c;
FETCH BACKWARD FROM c;
FETCH BACKWARD FROM c;
FETCH NEXT FROM c;
FETCH LAST FROM c;
FETCH BACKWARD FROM c;
FETCH NEXT FROM c;
FETCH NEXT FROM c;
FETCH NEXT FROM c;
FETCH BACKWARD FROM c;
FETCH NEXT FROM c;
COMMIT;
BEGIN;
SET LOCAL enable_indexscan = false;
SET LOCAL work_mem = '100kB';
EXPLAIN (COSTS OFF) DECLARE c SCROLL CURSOR FOR SELECT noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing;
DECLARE c SCROLL CURSOR FOR SELECT noabort_decreasing FROM abbrev_abort_uuids ORDER BY noabort_decreasing;
FETCH NEXT FROM c;
FETCH NEXT FROM c;
FETCH BACKWARD FROM c;
FETCH BACKWARD FROM c;
FETCH BACKWARD FROM c;
FETCH BACKWARD FROM c;
FETCH NEXT FROM c;
FETCH LAST FROM c;
FETCH BACKWARD FROM c;
FETCH NEXT FROM c;
FETCH NEXT FROM c;
FETCH NEXT FROM c;
FETCH BACKWARD FROM c;
FETCH NEXT FROM c;
COMMIT;
SELECT
    (array_agg(id ORDER BY id DESC NULLS FIRST))[0:5],
    (array_agg(abort_increasing ORDER BY abort_increasing DESC NULLS LAST))[0:5],
    (array_agg(id::text ORDER BY id::text DESC NULLS LAST))[0:5],
    percentile_disc(0.99) WITHIN GROUP (ORDER BY id),
    percentile_disc(0.01) WITHIN GROUP (ORDER BY id),
    percentile_disc(0.8) WITHIN GROUP (ORDER BY abort_increasing),
    percentile_disc(0.2) WITHIN GROUP (ORDER BY id::text),
    rank('00000000-0000-0000-0000-000000000000', '2', '2') WITHIN GROUP (ORDER BY noabort_increasing, id, id::text)
FROM (
    SELECT * FROM abbrev_abort_uuids
    UNION ALL
    SELECT NULL, NULL, NULL, NULL, NULL) s;
BEGIN;
SET LOCAL work_mem = '100kB';
SELECT
    (array_agg(id ORDER BY id DESC NULLS FIRST))[0:5],
    (array_agg(abort_increasing ORDER BY abort_increasing DESC NULLS LAST))[0:5],
    (array_agg(id::text ORDER BY id::text DESC NULLS LAST))[0:5],
    percentile_disc(0.99) WITHIN GROUP (ORDER BY id),
    percentile_disc(0.01) WITHIN GROUP (ORDER BY id),
    percentile_disc(0.8) WITHIN GROUP (ORDER BY abort_increasing),
    percentile_disc(0.2) WITHIN GROUP (ORDER BY id::text),
    rank('00000000-0000-0000-0000-000000000000', '2', '2') WITHIN GROUP (ORDER BY noabort_increasing, id, id::text)
FROM (
    SELECT * FROM abbrev_abort_uuids
    UNION ALL
    SELECT NULL, NULL, NULL, NULL, NULL) s;
ROLLBACK;
CREATE TEMP TABLE test_mark_restore(col1 int, col2 int, col12 int);
INSERT INTO test_mark_restore(col1, col2, col12)
   SELECT a.i, b.i, a.i * b.i FROM generate_series(1, 500) a(i), generate_series(1, 5) b(i);
BEGIN;
SET LOCAL enable_nestloop = off;
SET LOCAL enable_hashjoin = off;
SET LOCAL enable_material = off;
COMMIT;
