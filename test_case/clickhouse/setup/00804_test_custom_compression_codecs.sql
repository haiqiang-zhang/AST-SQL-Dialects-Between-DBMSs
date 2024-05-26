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
