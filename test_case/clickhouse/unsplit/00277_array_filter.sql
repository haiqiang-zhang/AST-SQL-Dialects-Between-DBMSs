SELECT sum(length(arr)) FROM (SELECT arrayMap(x -> toString(x), range(number % 10)) AS arr FROM (SELECT * FROM system.numbers LIMIT 1000) WHERE length(arr) % 2 = 0);
