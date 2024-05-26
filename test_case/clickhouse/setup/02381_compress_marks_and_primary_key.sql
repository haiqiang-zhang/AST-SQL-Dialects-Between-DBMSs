drop table if exists test_02381;
create table test_02381(a UInt64, b UInt64) ENGINE = MergeTree order by (a, b) SETTINGS compress_marks = false, compress_primary_key = false, ratio_of_defaults_for_sparse_serialization = 1;
insert into test_02381 select number, number * 10 from system.numbers limit 1000000;
drop table if exists test_02381_compress;
create table test_02381_compress(a UInt64, b UInt64) ENGINE = MergeTree order by (a, b)
    SETTINGS compress_marks = true, compress_primary_key = true, marks_compression_codec = 'ZSTD(3)', primary_key_compression_codec = 'ZSTD(3)', marks_compress_block_size = 65536, primary_key_compress_block_size = 65536, ratio_of_defaults_for_sparse_serialization = 1;
insert into test_02381_compress select number, number * 10 from system.numbers limit 1000000;
