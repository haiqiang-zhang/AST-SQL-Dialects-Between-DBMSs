PRAGMA enable_verification;
CREATE TABLE accounts AS SELECT 1 id, 'Mark' AS name;
PREPARE query AS SUMMARIZE SELECT * FROM accounts WHERE id = $1;
PREPARE query AS (SUMMARIZE SELECT * FROM accounts WHERE id = $1);
PREPARE query AS DESCRIBE SELECT * FROM accounts WHERE id = $1;
PREPARE query AS (DESCRIBE SELECT * FROM accounts WHERE id = $1);
