SELECT dummy FROM system.one ORDER BY materialize('{"k":"v"}'::JSON);
SELECT materialize('{"k":"v"}'::JSON) SETTINGS extremes = 1;
