SELECT DISTINCT n.b FROM nested PREWHERE filter;
ALTER TABLE nested ADD COLUMN n.c Array(UInt64) DEFAULT arrayMap(x -> x * 2, n.a);
SELECT DISTINCT n.c FROM nested PREWHERE filter;
SELECT DISTINCT n.a, n.c FROM nested PREWHERE filter;
DROP TABLE nested;
