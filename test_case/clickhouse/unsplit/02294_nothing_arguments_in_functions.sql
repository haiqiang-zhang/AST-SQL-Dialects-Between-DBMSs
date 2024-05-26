select arrayMap(x -> 2 * x, []);
select toTypeName(arrayMap(x -> 2 * x, []));
select arrayFilter(x -> 2 * x < 0, []);
select toColumnTypeName(arrayMap(x -> toInt32(x), []));
