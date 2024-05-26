SELECT
    0 OR NULL,
    1 OR NULL,
    toNullable(0) OR NULL,
    toNullable(1) OR NULL,
    0.0 OR NULL,
    0.1 OR NULL,
    NULL OR 1 OR NULL,
    0 OR NULL OR 1 OR NULL;
DROP TABLE IF EXISTS test;
CREATE TABLE test
(
    x Nullable(Int32)
) ENGINE = Log;
INSERT INTO test VALUES(1), (0), (null);
SELECT * FROM test;
SELECT x FROM test WHERE x != 0;
SELECT x FROM test WHERE x != 0 OR isNull(x);
SELECT x FROM test WHERE x != 1;
DROP TABLE test;
