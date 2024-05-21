SELECT map(1, 2, 3, 4) AS m, toJSONString(m) AS s, isValidJSON(s);
SELECT map('key1', number, 'key2', number * 2) AS m, toJSONString(m) AS s, isValidJSON(s) FROM numbers(1, 1);
SELECT map('2020-10-10'::Date, 'v1', '2020-10-11'::Date, 'v2') AS m, toJSONString(m) AS s, isValidJSON(s);
SELECT map(11::UInt64, 'v1', 22::UInt64, 'v2') AS m, toJSONString(m) AS s, isValidJSON(s);
SELECT map(11::Int128, 'v1', 22::Int128, 'v2') AS m, toJSONString(m) AS s, isValidJSON(s);
CREATE TEMPORARY TABLE map_json (m1 Map(String, UInt64), m2 Map(UInt32, UInt32), m3 Map(Date, String));
