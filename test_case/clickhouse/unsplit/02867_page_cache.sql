-- no-fasttest because we need an S3 storage policy
-- no-parallel because we look at server-wide counters about page cache usage

set use_page_cache_for_disks_without_file_cache = 1;
set page_cache_inject_eviction = 0;
set enable_filesystem_cache = 0;
set use_uncompressed_cache = 0;
create table events_snapshot engine Memory as select * from system.events;
create view events_diff as
    -- round all stats to 70 MiB to leave a lot of leeway for overhead
    with if(event like '%Bytes%', 70*1024*1024, 35) as granularity,
    -- cache hits counter can vary a lot depending on other settings:
    -- e.g. if merge_tree_min_bytes_for_concurrent_read is small, multiple threads will read each chunk
    -- so we just check that the value is not too low
         if(event in (
            'PageCacheBytesUnpinnedRoundedToPages', 'PageCacheBytesUnpinnedRoundedToHugePages',
            'PageCacheChunkDataHits'), 1, 1000) as clamp
    select event, min2(intDiv(new.value - old.value, granularity), clamp) as diff
    from system.events new
    left outer join events_snapshot old
    on old.event = new.event
    where diff != 0 and
          event in (
            'ReadBufferFromS3Bytes', 'PageCacheChunkMisses', 'PageCacheChunkDataMisses',
            'PageCacheChunkDataHits', 'PageCacheChunkDataPartialHits',
            'PageCacheBytesUnpinnedRoundedToPages', 'PageCacheBytesUnpinnedRoundedToHugePages')
    order by event;
drop table if exists page_cache_03055;
system stop merges page_cache_03055;
select * from events_diff;
truncate table events_snapshot;
insert into events_snapshot select * from system.events;
system start merges page_cache_03055;
truncate table events_snapshot;
insert into events_snapshot select * from system.events;
select * from events_diff where event not in ('PageCacheChunkDataHits');
truncate table events_snapshot;
insert into events_snapshot select * from system.events;
select * from events_diff;
truncate table events_snapshot;
insert into events_snapshot select * from system.events;
system drop page cache;
-- (Not checking PageCacheBytesUnpinned* because it's unreliable in this case because of an intentional race condition, see PageCache::evictChunk.)
select event, if(event in ('PageCacheChunkMisses', 'ReadBufferFromS3Bytes'), diff >= 1, diff) from events_diff where event not in ('PageCacheChunkDataHits', 'PageCacheBytesUnpinnedRoundedToPages', 'PageCacheBytesUnpinnedRoundedToHugePages');
truncate table events_snapshot;
insert into events_snapshot select * from system.events;
select * from events_diff where event not in ('PageCacheChunkDataHits');
truncate table events_snapshot;
insert into events_snapshot select * from system.events;
select * from events_diff;
truncate table events_snapshot;
insert into events_snapshot select * from system.events;
drop table events_snapshot;
drop view events_diff;
