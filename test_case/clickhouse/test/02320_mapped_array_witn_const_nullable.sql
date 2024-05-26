select arrayMap(x -> toNullable(1), range(number)) from numbers(3);
select arrayFilter(x -> toNullable(1), range(number)) from numbers(3);
