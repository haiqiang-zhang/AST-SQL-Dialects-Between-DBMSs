SELECT a, toTypeName(a), b, toTypeName(b), c, toTypeName(c), d, toTypeName(d), e, toTypeName(e), f, toTypeName(f), g, toTypeName(g), h, toTypeName(h) FROM test;
SELECT 'parseDateTimeBestEffort';
SELECT 'parseDateTimeBestEffortOrNull';
SELECT 'parseDateTimeBestEffortOrZero';
SELECT 'parseDateTime32BestEffort';
SELECT 'parseDateTime32BestEffortOrNull';
SELECT 'parseDateTime32BestEffortOrZero';
DROP TABLE IF EXISTS test;
