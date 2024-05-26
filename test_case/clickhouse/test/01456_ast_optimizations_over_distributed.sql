SELECT uniq(bitNot(number)) FROM numbers(1);
SELECT sum(number + 1) FROM numbers(1);
SELECT transform(number, [1, 2], ['google', 'censor.net'], 'other') FROM numbers(1);
SELECT number > 0 ? 'censor.net' : 'google' FROM numbers(1);
DROP TABLE IF EXISTS local_table;
DROP TABLE IF EXISTS dist;
CREATE TABLE local_table (number UInt64) ENGINE = Memory;
INSERT INTO local_table SELECT number FROM numbers(1);
DROP TABLE local_table;
