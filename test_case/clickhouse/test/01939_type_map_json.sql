SELECT map(1, 2, 3, 4) AS m, toJSONString(m) AS s, isValidJSON(s);
SELECT map('key1', number, 'key2', number * 2) AS m, toJSONString(m) AS s, isValidJSON(s) FROM numbers(1, 1);
CREATE TEMPORARY TABLE map_json (m1 Map(String, UInt64), m2 Map(UInt32, UInt32), m3 Map(Date, String));
