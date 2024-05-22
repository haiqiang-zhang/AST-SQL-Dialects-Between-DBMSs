DROP TABLE IF EXISTS t_mutations_nondeterministic SYNC;
SET mutations_sync = 2;
SET mutations_execute_subqueries_on_initiator = 1;
SET mutations_execute_nondeterministic_on_initiator = 1;
SELECT command FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
SELECT command FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
SELECT command FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
SELECT
    replaceRegexpOne(command, '(\\d{10})', 'timestamp'),
FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
SELECT command FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND is_done
ORDER BY command;
SELECT
    replaceRegexpOne(command, '(\\d{10})', 'timestamp'),
FROM system.mutations
WHERE database = currentDatabase() AND table = 't_mutations_nondeterministic' AND NOT is_done
ORDER BY command;
