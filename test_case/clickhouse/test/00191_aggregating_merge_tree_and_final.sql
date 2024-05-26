SELECT k, finalizeAggregation(u) FROM aggregating_00191 FINAL order by k;
OPTIMIZE TABLE aggregating_00191 FINAL;
DROP TABLE aggregating_00191;
