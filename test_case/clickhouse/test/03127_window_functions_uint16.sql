SELECT tumbleStart(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' WEEK, 'US/Samoa');
SELECT toDateTime(tumbleStart(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' WEEK, 'US/Samoa'), 'US/Samoa');
SELECT tumbleEnd(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' WEEK, 'US/Samoa');
SELECT hopStart(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' WEEK, INTERVAL '3' WEEK, 'US/Samoa');
SELECT hopEnd(toDateTime('2020-01-09 12:00:01', 'US/Samoa'), INTERVAL '1' WEEK, INTERVAL '3' WEEK, 'US/Samoa');
