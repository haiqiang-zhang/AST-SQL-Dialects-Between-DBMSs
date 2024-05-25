SELECT is_done FROM system.mutations WHERE table = 'mmm' and database=currentDatabase();
DROP TABLE IF EXISTS mmm;
