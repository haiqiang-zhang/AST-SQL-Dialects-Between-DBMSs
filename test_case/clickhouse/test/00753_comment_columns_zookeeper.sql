DROP TABLE IF EXISTS check_comments;
SELECT * FROM system.columns WHERE table = 'check.comments' and database = currentDatabase();
