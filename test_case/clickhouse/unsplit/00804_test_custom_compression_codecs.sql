SET send_logs_level = 'fatal';
SET allow_suspicious_codecs = 1;
DROP TABLE IF EXISTS compression_codec;
CREATE TABLE compression_codec(
    id UInt64 CODEC(LZ4),
    data String CODEC(ZSTD),
    ddd Date CODEC(NONE),
    somenum Float64 CODEC(ZSTD(2)),
    somestr FixedString(3) CODEC(LZ4HC(7)),
    othernum Int64 CODEC(Delta)
) ENGINE = MergeTree() ORDER BY tuple();
INSERT INTO compression_codec VALUES(1, 'hello', toDate('2018-12-14'), 1.1, 'aaa', 5);
INSERT INTO compression_codec VALUES(2, 'world', toDate('2018-12-15'), 2.2, 'bbb', 6);
INSERT INTO compression_codec VALUES(3, '!', toDate('2018-12-16'), 3.3, 'ccc', 7);
SELECT * FROM compression_codec ORDER BY id;
OPTIMIZE TABLE compression_codec FINAL;
INSERT INTO compression_codec VALUES(2, '', toDate('2018-12-13'), 4.4, 'ddd', 8);
DETACH TABLE compression_codec;
ATTACH TABLE compression_codec;
SELECT count(*) FROM compression_codec WHERE id = 2 GROUP BY id;
DROP TABLE IF EXISTS compression_codec;
DROP TABLE IF EXISTS bad_codec;
DROP TABLE IF EXISTS params_when_no_params;
DROP TABLE IF EXISTS too_many_params;
DROP TABLE IF EXISTS codec_multiple_direct_specification_1;
DROP TABLE IF EXISTS codec_multiple_direct_specification_2;
DROP TABLE IF EXISTS delta_bad_params1;
DROP TABLE IF EXISTS delta_bad_params2;
DROP TABLE IF EXISTS bad_codec;
DROP TABLE IF EXISTS params_when_no_params;
DROP TABLE IF EXISTS too_many_params;
DROP TABLE IF EXISTS codec_multiple_direct_specification_1;
DROP TABLE IF EXISTS codec_multiple_direct_specification_2;
DROP TABLE IF EXISTS delta_bad_params1;
DROP TABLE IF EXISTS delta_bad_params2;
DROP TABLE IF EXISTS compression_codec_multiple;
SET network_compression_method = 'lz4hc';
DROP TABLE IF EXISTS compression_codec_multiple_more_types;
DROP TABLE IF EXISTS compression_codec_multiple_with_key;
SET network_compression_method = 'zstd';
SET network_zstd_compression_level = 5;
SET network_compression_method = 'ZSTD';
SET network_zstd_compression_level = 7;
DROP TABLE IF EXISTS compression_codec_multiple_with_key;
DROP TABLE IF EXISTS test_default_delta;
DROP TABLE IF EXISTS test_default_delta;
