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
