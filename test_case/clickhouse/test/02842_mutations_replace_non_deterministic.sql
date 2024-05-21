DROP TABLE IF EXISTS t_mutations_nondeterministic SYNC;
SET mutations_sync = 2;
SET mutations_execute_subqueries_on_initiator = 1;
SET mutations_execute_nondeterministic_on_initiator = 1;
CREATE TABLE t_mutations_nondeterministic (id UInt64, v UInt64)
ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/02842_mutations_replace', '1')
ORDER BY id;
INSERT INTO t_mutations_nondeterministic VALUES (10, 20);
ALTER TABLE t_mutations_nondeterministic UPDATE v = (SELECT sum(number) FROM numbers(100)) WHERE 1;
SELECT id, v FROM t_mutations_nondeterministic ORDER BY id;
SELECT command FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
DROP TABLE t_mutations_nondeterministic SYNC;
CREATE TABLE t_mutations_nondeterministic (id UInt64, v Array(UInt64))
ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/02842_mutations_replace', '1')
ORDER BY id;
INSERT INTO t_mutations_nondeterministic VALUES (10, [20]);
ALTER TABLE t_mutations_nondeterministic UPDATE v = (SELECT groupArray(number) FROM numbers(10)) WHERE 1;
SELECT id, v FROM t_mutations_nondeterministic ORDER BY id;
ALTER TABLE t_mutations_nondeterministic UPDATE v = (SELECT groupArray(number) FROM numbers(10000)) WHERE 1;
SELECT command FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
DROP TABLE t_mutations_nondeterministic SYNC;
CREATE TABLE t_mutations_nondeterministic (id UInt64, v AggregateFunction(uniqExact, UInt64))
ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/02842_mutations_replace', '1')
ORDER BY id;
INSERT INTO t_mutations_nondeterministic VALUES (10, initializeAggregation('uniqExactState', 1::UInt64));
ALTER TABLE t_mutations_nondeterministic UPDATE v = (SELECT uniqExactState(number) FROM numbers(5)) WHERE 1;
SELECT id, finalizeAggregation(v) FROM t_mutations_nondeterministic ORDER BY id;
SELECT command FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
DROP TABLE t_mutations_nondeterministic SYNC;
CREATE TABLE t_mutations_nondeterministic (id UInt64, v DateTime)
ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/02842_mutations_replace', '1')
ORDER BY id;
INSERT INTO t_mutations_nondeterministic VALUES (10, '2020-10-10');
ALTER TABLE t_mutations_nondeterministic UPDATE v = now() WHERE 1;
SELECT id, v BETWEEN now() - INTERVAL 10 MINUTE AND now() FROM t_mutations_nondeterministic;
SELECT
    replaceRegexpOne(command, '(\\d{10})', 'timestamp'),
FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
DROP TABLE t_mutations_nondeterministic SYNC;
CREATE TABLE t_mutations_nondeterministic (id UInt64, v UInt64) ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/02842_mutations_replace', '1') ORDER BY id;
INSERT INTO t_mutations_nondeterministic VALUES (10, 10);
ALTER TABLE t_mutations_nondeterministic UPDATE v = filesystemCapacity(materialize('default')) WHERE 1;
DROP TABLE t_mutations_nondeterministic SYNC;
CREATE TABLE t_mutations_nondeterministic (id UInt64, v UInt64)
ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/02842_mutations_replace', '1')
ORDER BY id;
INSERT INTO t_mutations_nondeterministic VALUES (10, 10);
ALTER TABLE t_mutations_nondeterministic
UPDATE v =
(
    SELECT sum(number) FROM numbers(1000) WHERE number > randConstant()
) WHERE 1
SETTINGS mutations_execute_subqueries_on_initiator = 0, allow_nondeterministic_mutations = 1;
SELECT command FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
DROP TABLE t_mutations_nondeterministic SYNC;
CREATE TABLE t_mutations_nondeterministic (id UInt64, d DateTime)
ENGINE = ReplicatedMergeTree('/clickhouse/tables/{database}/02842_mutations_replace', '1')
ORDER BY id;
INSERT INTO t_mutations_nondeterministic VALUES (10, '2000-10-10'), (20, '2100-10-10');
ALTER TABLE t_mutations_nondeterministic DELETE WHERE d < now();
SELECT
    replaceRegexpOne(command, '(\\d{10})', 'timestamp'),
FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND NOT is_done
ORDER BY command;
SELECT id, d FROM t_mutations_nondeterministic ORDER BY id;
DROP TABLE t_mutations_nondeterministic SYNC;