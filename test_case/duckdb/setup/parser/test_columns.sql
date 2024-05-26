PRAGMA enable_verification;
CREATE TABLE integers AS SELECT 42 i, 84 j UNION ALL SELECT 13, 14;
CREATE TABLE grouped_table AS SELECT  1 id, 42 index1, 84 index2 UNION ALL SELECT 2, 13, 14;
