SELECT 'Check the bug causing situation: the special Australia/Lord_Howe time zone. toDateTime and toString functions are all tested at once';
SELECT toUnixTimestamp(x) as tt, (toDateTime('2019-04-07 01:00:00', 'Australia/Lord_Howe') + INTERVAL number * 600 SECOND) AS x,  toString(x) as xx FROM numbers(20);
SELECT '4 days test in batch comparing with manually computation result for Asia/Istanbul whose timezone epoc is of whole hour:';
SELECT '4 days test in batch comparing with manually computation result for Asia/Tehran whose timezone epoc is of half hour:';
SELECT '4 days test in batch comparing with manually computation result for Australia/Lord_Howe whose timezone epoc is of half hour and also its DST offset is half hour:';
