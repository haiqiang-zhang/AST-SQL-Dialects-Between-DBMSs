PRAGMA enable_verification;
CREATE TABLE stringliterals AS SELECT 1 AS ID, 1::BIGINT AS a1,'value-1' AS a2,'value-1' AS a3,10::BIGINT AS a4;
