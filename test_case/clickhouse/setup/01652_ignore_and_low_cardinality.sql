set allow_suspicious_low_cardinality_types = 1;
CREATE TABLE lc_null_int8_defnull (val LowCardinality(Nullable(Int8)) DEFAULT NULL) ENGINE = MergeTree order by tuple();