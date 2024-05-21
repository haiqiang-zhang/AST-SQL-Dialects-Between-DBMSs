DROP TABLE IF EXISTS mmm;
ALTER TABLE mmm DELETE WHERE a IN (SELECT a FROM mmm) SETTINGS mutations_sync=1;
SELECT is_done FROM system.mutations WHERE table = 'mmm' and database=currentDatabase();
SELECT * FROM mmm;
DROP TABLE IF EXISTS mmm;