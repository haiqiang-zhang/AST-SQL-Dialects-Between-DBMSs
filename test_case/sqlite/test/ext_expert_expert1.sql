CREATE INDEX t1_idx_00000061 ON t1(a);
-- stat1: 100 50 
  CREATE INDEX t1_idx_00000062 ON t1(b);
-- stat1: 100 20 
  CREATE INDEX t1_idx_000123a7 ON t1(a, b);
-- stat1: 100 50 16

  CREATE INDEX t2_idx_00000063 ON t2(c);
-- stat1: 100 20 
  CREATE INDEX t2_idx_00000064 ON t2(d);
-- stat1: 100 5
  CREATE INDEX t2_idx_0001295b ON t2(c, d);
-- stat1: 100 20 5

  ANALYZE;
SELECT * FROM sqlite_stat1 ORDER BY 1, 2;
