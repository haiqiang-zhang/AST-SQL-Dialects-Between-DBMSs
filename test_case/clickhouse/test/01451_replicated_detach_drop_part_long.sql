SELECT name FROM system.detached_parts WHERE table = 'replica2' AND database = currentDatabase();
SELECT name FROM system.detached_parts WHERE table = 'replica2' AND database = currentDatabase();
SELECT '-- drop part --';
SELECT '-- resume merges --';
SELECT name FROM system.parts WHERE table = 'replica2' AND active AND database = currentDatabase();
