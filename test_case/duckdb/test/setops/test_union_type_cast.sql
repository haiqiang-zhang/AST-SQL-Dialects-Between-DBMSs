PRAGMA enable_verification;
SELECT 1 UNION SELECT 1.0;
SELECT 1 UNION ALL SELECT 1.0;
SELECT 1 UNION (SELECT 1 UNION SELECT 1 UNION SELECT 1);
SELECT 1 UNION (SELECT 1.0 UNION SELECT 1.0 UNION SELECT 1.0) UNION SELECT 1;;
SELECT 1 UNION ALL (SELECT 1.0 UNION ALL SELECT 1.0 UNION ALL SELECT 1.0) UNION ALL SELECT 1;;
SELECT 1 UNION (SELECT '1' UNION SELECT '1' UNION SELECT '1') UNION SELECT 1;;