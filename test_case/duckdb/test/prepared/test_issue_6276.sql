PRAGMA enable_verification;
PREPARE v1 AS SELECT CASE ? WHEN ? THEN ? WHEN ? THEN ? ELSE ? END AS x;
EXECUTE V1(1, 2, 3, 4, 5, 6);;
