SELECT argMax((n, n), n) t, toTypeName(t) FROM (SELECT if(number >= 100, NULL, number) AS n from numbers(10));
