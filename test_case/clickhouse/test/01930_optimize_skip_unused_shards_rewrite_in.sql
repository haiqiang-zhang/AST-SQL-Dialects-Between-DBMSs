set optimize_skip_unused_shards=1;
set force_optimize_skip_unused_shards=2;
create temporary table data (id UInt64) engine=Memory() as with [
    0,
    1,
    0x7f, 0x80, 0xff,
    0x7fff, 0x8000, 0xffff,
    0x7fffffff, 0x80000000, 0xffffffff,
    0x7fffffffffffffff, 0x8000000000000000, 0xffffffffffffffff
] as values select arrayJoin(values) id;
