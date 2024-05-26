SELECT accurateCastOrNull(-1, 'UInt8');
SELECT accurateCastOrNull(number + 127, 'Int8') AS x FROM numbers (2) ORDER BY x;
SELECT toString(accurateCastOrNull('2023-05-30 14:38:20', 'DateTime'), timezone());
SELECT toString(accurateCastOrNull('1965-05-30 14:38:20', 'DateTime'), timezone()) SETTINGS session_timezone = 'UTC';
SELECT toString(accurateCastOrNull('2223-05-30 14:38:20', 'DateTime'), timezone()) SETTINGS session_timezone = 'UTC';
