SELECT analysisOfVariance(1.11, -20);
SELECT analysisOfVariance(1.11, 20 :: UInt128);
SELECT analysisOfVariance(1.11, 9000000000000000);
SELECT analysisOfVariance(number, number % 2), analysisOfVariance(100000000000000000000., number % 65535) FROM numbers(1048575);