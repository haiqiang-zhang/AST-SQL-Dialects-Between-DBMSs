SELECT uniq(x) > 50 FROM (SELECT number, groupArraySample(10)(arrayJoin(range(1000))) AS x FROM numbers(100) GROUP BY number);
