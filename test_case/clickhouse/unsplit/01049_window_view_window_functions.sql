SELECT tumble(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL 1 SECOND, 'US/Samoa');
SELECT tumbleStart(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' DAY, 'US/Samoa');
SELECT toDateTime(tumbleStart(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' DAY, 'US/Samoa'), 'US/Samoa');
SELECT tumbleEnd(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' DAY, 'US/Samoa');
SELECT hop(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL 1 SECOND, INTERVAL 3 SECOND, 'US/Samoa');
SELECT hopStart(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' DAY, INTERVAL '3' DAY, 'US/Samoa');
SELECT hopEnd(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' DAY, INTERVAL '3' DAY, 'US/Samoa');
