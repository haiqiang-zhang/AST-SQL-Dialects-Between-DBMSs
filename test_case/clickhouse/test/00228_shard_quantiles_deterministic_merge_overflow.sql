select quantilesDeterministic(0.5, 0.9)(number, number) from (select number from system.numbers limit 101);
