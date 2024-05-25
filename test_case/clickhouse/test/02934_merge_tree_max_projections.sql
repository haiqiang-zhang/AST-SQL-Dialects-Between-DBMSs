ALTER TABLE test_max_mt_projections_alter ADD PROJECTION p1 (SELECT c2 ORDER BY c2);
ALTER TABLE test_max_mt_projections_alter ADD PROJECTION p2 (SELECT c3 ORDER BY c3);
ALTER TABLE test_max_mt_projections_alter ADD PROJECTION p3 (SELECT c1, c2 ORDER BY c1, c2);
ALTER TABLE test_max_mt_projections_alter DROP PROJECTION p3;
ALTER TABLE test_max_mt_projections_alter ADD PROJECTION p4 (SELECT c2, c3 ORDER BY c2, c3);
DROP TABLE IF EXISTS test_max_mt_projections_alter;
DROP TABLE IF EXISTS test_max_mt_projections_create;
CREATE TABLE test_max_mt_projections_create (c1 UInt32, c2 UInt32,
        PROJECTION p (SELECT c1, c2 ORDER BY c2))
        ENGINE = MergeTree ORDER BY c1
        SETTINGS max_projections = 1;
DROP TABLE IF EXISTS test_max_mt_projections_create;
