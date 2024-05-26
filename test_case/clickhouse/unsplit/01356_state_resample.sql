select sumResample(0, 20, 1)(number, number % 20) from numbers(200);
select arrayMap(x -> finalizeAggregation(x), state) from (select sumStateResample(0, 20, 1)(number, number % 20) as state from numbers(200));
select groupArrayResample(0, 20, 1)(number, number % 20) from numbers(50);
