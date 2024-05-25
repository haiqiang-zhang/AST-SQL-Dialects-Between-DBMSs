DROP TABLE IF EXISTS bloom_filter;
CREATE TABLE bloom_filter
(
    id UInt64,
    s String,
    INDEX tok_bf (s, lower(s)) TYPE tokenbf_v1(512, 3, 0) GRANULARITY 1
) ENGINE = MergeTree() ORDER BY id SETTINGS index_granularity = 8, index_granularity_bytes = '10Mi';
insert into bloom_filter select number, 'yyy,uuu' from numbers(1024);
insert into bloom_filter select number+2000, 'abc,def,zzz' from numbers(8);
insert into bloom_filter select number+3000, 'yyy,uuu' from numbers(1024);
insert into bloom_filter select number+3000, 'abcdefzzz' from numbers(1024);
