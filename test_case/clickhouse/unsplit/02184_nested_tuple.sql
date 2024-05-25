SET allow_suspicious_low_cardinality_types=1;
DROP TABLE IF EXISTS t_nested_tuple;
CREATE TABLE t_nested_tuple
(
    endUserIDs Tuple(
      _experience Tuple(
          aaid Tuple(
              id Nullable(String),
              namespace Tuple(
                  code LowCardinality(Nullable(String))
              ),
              primary LowCardinality(Nullable(UInt8))
          ),
          mcid Tuple(
              id Nullable(String),
              namespace Tuple(
                  code LowCardinality(Nullable(String))
              ),
              primary LowCardinality(Nullable(UInt8))
          )
      )
  )
)
ENGINE = MergeTree ORDER BY tuple();
DROP TABLE t_nested_tuple;
