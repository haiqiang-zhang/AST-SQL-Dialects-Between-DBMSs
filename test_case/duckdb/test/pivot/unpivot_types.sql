PRAGMA enable_verification;
SELECT column_name, column_type FROM (DESCRIBE unpivot ( select 42) on columns(*));
SELECT column_name, column_type FROM (DESCRIBE unpivot ( select {n : 1 }) on columns(*));
