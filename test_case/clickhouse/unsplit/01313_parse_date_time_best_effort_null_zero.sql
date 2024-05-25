SELECT parseDateTimeBestEffortOrNull('<Empty>');
SELECT parseDateTimeBestEffortOrZero('<Empty>', 'UTC');
SELECT parseDateTime64BestEffortOrNull('<Empty>');
SELECT parseDateTime64BestEffortOrZero('<Empty>', 0, 'UTC');
SELECT toDateTimeOrNull('<Empty>');
SELECT toDateTimeOrZero('<Empty>', 'UTC');
