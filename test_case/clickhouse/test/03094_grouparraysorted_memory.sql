CREATE MATERIALIZED VIEW 03094_grouparrysorted_mv TO 03094_grouparrysorted_dest
AS SELECT
   ServiceName,
   groupArraySortedState(100)(
                         CAST(
                             tuple(-Duration, Timestamp, TraceId, SpanId),
                             'Tuple(NegativeDurationNs Int64, Timestamp DateTime64(9), TraceId String, SpanId String)'
                         )) as SlowSpans
FROM 03094_grouparrysorted_src
GROUP BY
    ServiceName;
