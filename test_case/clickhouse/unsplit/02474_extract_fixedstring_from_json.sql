SELECT JSONExtract('{"a": 123456}', 'FixedString(11)');
SELECT JSONExtract(materialize('{"a": 131231}'), 'a', 'LowCardinality(FixedString(5))') FROM numbers(2);
