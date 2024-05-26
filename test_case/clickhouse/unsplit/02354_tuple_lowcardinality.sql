SET allow_suspicious_low_cardinality_types = 1;
SELECT toTypeName(tuple(toLowCardinality('1'), toLowCardinality(1)));
