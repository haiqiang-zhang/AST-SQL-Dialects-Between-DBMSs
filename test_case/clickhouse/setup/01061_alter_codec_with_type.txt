DROP TABLE IF EXISTS alter_bug;
create table alter_bug (
  epoch UInt64 CODEC(Delta,LZ4),
  _time_dec Float64
) Engine = MergeTree ORDER BY (epoch);
