-- no-fasttest because DEFLATE_QPL isn't available in fasttest
-- no-cpu-aarch64 and no-cpu-s390x because DEFLATE_QPL is x86-only

-- A bunch of random DDLs to test the DEFLATE_QPL codec.

SET enable_deflate_qpl_codec = 1;
-- back to software DeflateQpl coded."
SET send_logs_level = 'fatal';
DROP TABLE IF EXISTS compression_codec;
DROP TABLE IF EXISTS compression_codec;
