SELECT CAST(arrayJoin(['', 'abc', '123', '123a', '-123']) AS Nullable(UInt8));
SELECT toDateOrZero(arrayJoin(['', '2018', '2018-01-02', '2018-1-2', '2018-01-2', '2018-1-02', '2018-ab-cd', '2018-01-02a']));
SELECT toDateOrNull(arrayJoin(['', '2018', '2018-01-02', '2018-1-2', '2018-01-2', '2018-1-02', '2018-ab-cd', '2018-01-02a']));
SELECT toDateTimeOrZero(arrayJoin(['', '2018', '2018-01-02 01:02:03', '2018-01-02T01:02:03', '2018-01-02 01:02:03 abc']), 'UTC');
SELECT toDateTimeOrNull(arrayJoin(['', '2018', '2018-01-02 01:02:03', '2018-01-02T01:02:03', '2018-01-02 01:02:03 abc']));
