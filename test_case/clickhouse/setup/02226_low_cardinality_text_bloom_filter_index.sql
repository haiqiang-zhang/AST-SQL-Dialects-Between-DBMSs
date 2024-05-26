DROP TABLE IF EXISTS bf_tokenbf_lowcard_test;
DROP TABLE IF EXISTS bf_ngram_lowcard_test;
CREATE TABLE bf_tokenbf_lowcard_test
(
    row_id UInt32,
    lc LowCardinality(String),
    lc_fixed LowCardinality(FixedString(8)),
    INDEX lc_bf_tokenbf lc TYPE tokenbf_v1(256,2,0) GRANULARITY 1,
    INDEX lc_fixed_bf_tokenbf lc_fixed TYPE tokenbf_v1(256,2,0) GRANULARITY 1
) Engine=MergeTree() ORDER BY row_id SETTINGS index_granularity = 1;
CREATE TABLE bf_ngram_lowcard_test
(
    row_id UInt32,
    lc LowCardinality(String),
    lc_fixed LowCardinality(FixedString(8)),
    INDEX lc_ngram lc TYPE ngrambf_v1(4,256,2,0) GRANULARITY 1,
    INDEX lc_fixed_ngram lc_fixed TYPE ngrambf_v1(4,256,2,0) GRANULARITY 1
) Engine=MergeTree() ORDER BY row_id SETTINGS index_granularity = 1;
INSERT INTO bf_tokenbf_lowcard_test VALUES (1, 'K1', 'K1ZZZZZZ'), (2, 'K2', 'K2ZZZZZZ');
INSERT INTO bf_ngram_lowcard_test VALUES (1, 'K1', 'K1ZZZZZZ'), (2, 'K2', 'K2ZZZZZZ');
INSERT INTO bf_tokenbf_lowcard_test VALUES (3, 'abCD3ef', 'abCD3ef'), (4, 'abCD4ef', 'abCD4ef');
INSERT INTO bf_ngram_lowcard_test   VALUES (3, 'abCD3ef', 'abCD3ef'), (4, 'abCD4ef', 'abCD4ef');
