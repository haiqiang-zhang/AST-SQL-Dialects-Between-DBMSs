DROP VIEW IF EXISTS test_view_tb;
CREATE MATERIALIZED VIEW test_view_tb ENGINE = MergeTree() ORDER BY a AS SELECT * FROM test_tb;
INSERT INTO test_tb VALUES (1, '1'), (2, '2'), (3, '3');
SELECT count(_part) FROM test_view_tb;
