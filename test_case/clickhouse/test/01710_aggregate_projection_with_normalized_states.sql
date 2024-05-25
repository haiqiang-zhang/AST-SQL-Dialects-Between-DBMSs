DROP TABLE IF EXISTS r;
select finalizeAggregation(cast(quantileState(0)(arrayJoin([1,2,3])) as AggregateFunction(quantile(1), UInt8)));
CREATE TABLE r (
     x String,
     a LowCardinality(String),
     q AggregateFunction(quantilesTiming(0.5, 0.95, 0.99), Int64),
     s Int64,
     PROJECTION p
         (SELECT a, quantilesTimingMerge(0.5, 0.95, 0.99)(q), sum(s) GROUP BY a)
) Engine=SummingMergeTree order by (x, a);
insert into r
select number%100 x,
       'x' a,
       quantilesTimingState(0.5, 0.95, 0.99)(number::Int64) q,
       sum(1) s
from numbers(1000)
group by x,a;
DROP TABLE r;
