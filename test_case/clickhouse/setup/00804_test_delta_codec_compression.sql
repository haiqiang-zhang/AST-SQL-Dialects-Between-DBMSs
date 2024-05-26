SET send_logs_level = 'fatal';
SET joined_subquery_requires_alias = 0;
DROP TABLE IF EXISTS delta_codec_synthetic;
DROP TABLE IF EXISTS default_codec_synthetic;
CREATE TABLE delta_codec_synthetic
(
    id UInt64 Codec(Delta, ZSTD(3))
) ENGINE MergeTree() ORDER BY tuple() SETTINGS min_bytes_for_wide_part = 0, compress_marks = false, compress_primary_key = false, ratio_of_defaults_for_sparse_serialization = 1;
CREATE TABLE default_codec_synthetic
(
    id UInt64 Codec(ZSTD(3))
) ENGINE MergeTree() ORDER BY tuple() SETTINGS min_bytes_for_wide_part = 0, compress_marks = false, compress_primary_key = false, ratio_of_defaults_for_sparse_serialization = 1;
set max_insert_threads = 1;
INSERT INTO delta_codec_synthetic SELECT number FROM system.numbers LIMIT 5000000;
INSERT INTO default_codec_synthetic SELECT number FROM system.numbers LIMIT 5000000;
