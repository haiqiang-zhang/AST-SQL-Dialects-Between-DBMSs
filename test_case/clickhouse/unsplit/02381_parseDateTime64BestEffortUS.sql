SELECT 'parseDateTime64BestEffortUS';
SELECT '';
SELECT 'parseDateTime64BestEffortUSOrNull';
SELECT parseDateTime64BestEffortUSOrNull('01/45/1925 16:00:00',3,'UTC');
SELECT 'parseDateTime64BestEffortUSOrZero';
SELECT parseDateTime64BestEffortUSOrZero('01/45/1925 16:00:00',3,'UTC');
