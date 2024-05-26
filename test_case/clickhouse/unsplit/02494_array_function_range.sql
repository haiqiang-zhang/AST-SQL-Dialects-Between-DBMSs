SELECT range(100) == range(0, 100) and range(0, 100) == range(0, 100, 1);
SELECT range(100) == range(cast('100', 'Int8')) and range(100) == range(cast('100', 'Int16')) and range(100) == range(cast('100', 'Int32')) and range(100) == range(cast('100', 'Int64'));
SELECT range(cast('100', 'Int8')) == range(0, cast('100', 'Int8')) and  range(0, cast('100', 'Int8')) == range(0, cast('100', 'Int8'), 1) and range(0, cast('100', 'Int8')) == range(0, cast('100', 'Int8'), cast('1', 'Int8'));
SELECT range(-1, 1);
