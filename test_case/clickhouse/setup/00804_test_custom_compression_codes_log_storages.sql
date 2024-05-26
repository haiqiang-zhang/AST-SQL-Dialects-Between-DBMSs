SET send_logs_level = 'fatal';
SET allow_suspicious_codecs = 1;
DROP TABLE IF EXISTS compression_codec_log;
CREATE TABLE compression_codec_log(
    id UInt64 CODEC(LZ4),
    data String CODEC(ZSTD),
    ddd Date CODEC(NONE),
    somenum Float64 CODEC(ZSTD(2)),
    somestr FixedString(3) CODEC(LZ4HC(7)),
    othernum Int64 CODEC(Delta)
) ENGINE = Log();
