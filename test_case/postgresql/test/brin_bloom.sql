SELECT brin_desummarize_range('brinidx_bloom', 0);
VACUUM brintest_bloom;
UPDATE brintest_bloom SET int8col = int8col * int4col;
UPDATE brintest_bloom SET textcol = '' WHERE textcol IS NOT NULL;
SELECT brin_summarize_new_values('brinidx_bloom');
CREATE TABLE brin_summarize_bloom (
    value int
) WITH (fillfactor=10, autovacuum_enabled=false);
CREATE INDEX brin_summarize_bloom_idx ON brin_summarize_bloom USING brin (value) WITH (pages_per_range=2);
SELECT brin_summarize_range('brin_summarize_bloom_idx', 0);
CREATE TABLE brin_test_bloom (a INT, b INT);
INSERT INTO brin_test_bloom SELECT x/100,x%100 FROM generate_series(1,10000) x(x);
CREATE INDEX brin_test_bloom_a_idx ON brin_test_bloom USING brin (a) WITH (pages_per_range = 2);
CREATE INDEX brin_test_bloom_b_idx ON brin_test_bloom USING brin (b) WITH (pages_per_range = 2);
VACUUM ANALYZE brin_test_bloom;
EXPLAIN (COSTS OFF) SELECT * FROM brin_test_bloom WHERE a = 1;
EXPLAIN (COSTS OFF) SELECT * FROM brin_test_bloom WHERE b = 1;
