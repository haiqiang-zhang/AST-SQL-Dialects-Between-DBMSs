SELECT fromUnixTimestampInJodaSyntax(1669804872, 'G', 'UTC');
with '2018-01-12 22:33:44.55' as s, toDateTime64(s, 6) as datetime64 SELECT fromUnixTimestampInJodaSyntax(datetime64, 'S', 'UTC');
