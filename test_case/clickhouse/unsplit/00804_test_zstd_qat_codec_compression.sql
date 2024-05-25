-- no-fasttest because ZSTD_QAT isn't available in fasttest
-- no-cpu-aarch64 and no-cpu-s390x because ZSTD_QAT is x86-only

SET enable_zstd_qat_codec = 1;
SET send_logs_level = 'fatal';
DROP TABLE IF EXISTS compression_codec;
DROP TABLE IF EXISTS compression_codec;
