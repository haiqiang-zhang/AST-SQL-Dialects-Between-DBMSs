PRAGMA enable_verification;
CREATE TABLE try_cast(try_cast INTEGER);
INSERT INTO try_cast VALUES (3);
SELECT TRY_CAST('hello' as INTEGER);
SELECT TRY_CAST(3 as BIGINT), CAST(3 AS BIGINT), TRY_CAST(2 as BIGINT), CAST(3 AS INTEGER);
SELECT try_cast FROM try_cast;
SELECT try_cast(try_cast as bigint) FROM try_cast;
SELECT try_cast(try_cast(try_cast as integer) as integer) FROM try_cast;
