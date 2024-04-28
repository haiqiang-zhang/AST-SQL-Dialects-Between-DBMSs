PRAGMA enable_verification;
CREATE TABLE table1 (id INTEGER, a INTEGER);;
CREATE TABLE table2 (table1_id INTEGER);;
INSERT INTO table2 WITH cte AS (INSERT INTO table1 SELECT 1, 2 RETURNING id) SELECT id FROM cte;;
