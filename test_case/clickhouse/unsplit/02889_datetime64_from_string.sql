SELECT toDateTime64('-123', 3, 'UTC');
SELECT toDateTime64('23.9', 3, 'UTC');
SELECT toDateTime64('-23.9', 3, 'UTC');
SELECT toDateTime64OrNull('0', 3, 'UTC');
SELECT cast('0' as Nullable(DateTime64(3, 'UTC')));
