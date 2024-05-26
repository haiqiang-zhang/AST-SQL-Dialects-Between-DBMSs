SELECT quantilesTiming(0.5, 0.9)(number) FROM (SELECT number FROM system.numbers LIMIT 100);
