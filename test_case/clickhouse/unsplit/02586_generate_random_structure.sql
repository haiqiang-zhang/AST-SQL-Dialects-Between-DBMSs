select generateRandomStructure(5, 42);
select toTypeName(generateRandomStructure(5, 42));
select toColumnTypeName(generateRandomStructure(5, 42));
SELECT * FROM generateRandom(generateRandomStructure(5, 42), 42) LIMIT 1;
desc generateRandom(10000000);
set allow_suspicious_low_cardinality_types=1;
