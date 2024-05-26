SELECT sum(m['col1']), sum(m['col4']), sum(m['col7']), sum(m['col8'] = 0) FROM t_map;
SELECT toTypeName(obj) FROM t_json LIMIT 1;
INSERT INTO t_json
SELECT
    number,
    (
        arrayMap(x -> 'col' || toString(x), range(number % 10)),
        range(number % 10)
    )::Map(FixedString(4), UInt64)
FROM numbers(1000000);
DROP TABLE IF EXISTS t_json;
DROP TABLE IF EXISTS t_map;
