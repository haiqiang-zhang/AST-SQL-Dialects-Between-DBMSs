SELECT arrayExists(x -> (x IN (SELECT '2')), [2]) FROM system.one;
