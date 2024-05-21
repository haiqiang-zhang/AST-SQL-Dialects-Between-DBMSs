SET max_bytes_before_external_sort = 33554432;
set max_block_size = 1048576;
SET max_bytes_before_external_group_by = '100M';
SET max_memory_usage = '410M';
SET group_by_two_level_threshold = '100K';
SET group_by_two_level_threshold_bytes = '50M';
SET join_algorithm = 'partial_merge';
SET default_max_bytes_in_join = 0;
SET max_bytes_in_join = 10000000;
SYSTEM FLUSH LOGS;
SELECT
    if(
        any(ProfileEvents['ExternalProcessingFilesTotal']) >= 1 AND
        any(ProfileEvents['ExternalProcessingCompressedBytesTotal']) >= 100000 AND
        any(ProfileEvents['ExternalProcessingUncompressedBytesTotal']) >= 100000 AND
        any(ProfileEvents['ExternalSortWritePart']) >= 1 AND
        any(ProfileEvents['ExternalSortMerge']) >= 1 AND
        any(ProfileEvents['ExternalSortCompressedBytes']) >= 100000 AND
        any(ProfileEvents['ExternalSortUncompressedBytes']) >= 100000 AND
        count() == 1,
        'ok',
        'fail: ' || toString(count()) || ' ' || toString(any(ProfileEvents))
    )
    FROM system.query_log WHERE current_database = currentDatabase()
        AND log_comment = '02402_external_disk_mertrics/sort'
        AND query ILIKE 'SELECT%2097152%' AND type = 'QueryFinish';
SELECT
    if(
        any(ProfileEvents['ExternalProcessingFilesTotal']) >= 1 AND
        any(ProfileEvents['ExternalProcessingCompressedBytesTotal']) >= 100000 AND
        any(ProfileEvents['ExternalProcessingUncompressedBytesTotal']) >= 100000 AND
        any(ProfileEvents['ExternalAggregationWritePart']) >= 1 AND
        any(ProfileEvents['ExternalAggregationMerge']) >= 1 AND
        any(ProfileEvents['ExternalAggregationCompressedBytes']) >= 100000 AND
        any(ProfileEvents['ExternalAggregationUncompressedBytes']) >= 100000 AND
        count() == 1,
        'ok',
        'fail: ' || toString(count()) || ' ' || toString(any(ProfileEvents))
    )
    FROM system.query_log WHERE current_database = currentDatabase()
        AND log_comment = '02402_external_disk_mertrics/aggregation'
        AND query ILIKE 'SELECT%2097152%' AND type = 'QueryFinish';
SELECT
    if(
        any(ProfileEvents['ExternalProcessingFilesTotal']) >= 1 AND
        any(ProfileEvents['ExternalProcessingCompressedBytesTotal']) >= 100000 AND
        any(ProfileEvents['ExternalProcessingUncompressedBytesTotal']) >= 100000 AND
        any(ProfileEvents['ExternalJoinWritePart']) >= 1 AND
        any(ProfileEvents['ExternalJoinMerge']) >= 0 AND
        any(ProfileEvents['ExternalJoinCompressedBytes']) >= 100000 AND
        any(ProfileEvents['ExternalJoinUncompressedBytes']) >= 100000 AND
        count() == 1,
        'ok',
        'fail: ' || toString(count()) || ' ' || toString(any(ProfileEvents))
    )
    FROM system.query_log WHERE current_database = currentDatabase()
        AND log_comment = '02402_external_disk_mertrics/join'
        AND query ILIKE 'SELECT%2097152%' AND type = 'QueryFinish';