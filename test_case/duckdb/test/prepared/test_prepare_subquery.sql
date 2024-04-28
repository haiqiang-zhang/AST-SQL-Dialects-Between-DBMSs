PREPARE v1 AS SELECT * FROM (SELECT $1::INTEGER) sq1;;
EXECUTE v1(42);
PREPARE v2 AS SELECT * FROM (SELECT $1::INTEGER WHERE 1=0) sq1;;
EXECUTE v2(42);
PREPARE v3 AS SELECT (SELECT $1::INT+sq1.i) FROM (SELECT 42 AS i) sq1;;
EXECUTE v3(42);
PREPARE v4 AS SELECT (SELECT (SELECT $1::INT+sq1.i)+$2::INT+sq1.i) FROM (SELECT 42 AS i) sq1;;
EXECUTE v4(20, 20);