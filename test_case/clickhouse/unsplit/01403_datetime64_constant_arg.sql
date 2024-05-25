SELECT toDateTime(fromUnixTimestamp64Micro(toInt64(0)), 'UTC') as ts FROM numbers_mt(2) WHERE ts + 1 = ts;
SELECT toDateTime(fromUnixTimestamp64Micro(toInt64(0)), 'UTC') ts FROM numbers(2);
