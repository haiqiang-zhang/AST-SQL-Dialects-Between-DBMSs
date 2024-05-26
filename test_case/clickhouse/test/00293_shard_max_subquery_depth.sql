SELECT 2 FROM system.one WHERE 1 IN (SELECT 1 FROM system.one WHERE 1 IN (SELECT 1 FROM system.one WHERE 1 IN (SELECT 1 FROM system.one)));
